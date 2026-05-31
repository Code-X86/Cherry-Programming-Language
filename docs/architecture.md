# Architecture

Cherry is implemented as a Rust binary crate. The source files are deliberately
split by compiler/runtime stage.

## Source Layout

```text
src/
  main.rs
  lexer.rs
  parser.rs
  ast.rs
  interpreter.rs
  runtime.rs
  package.rs
  native_loader.rs
```

## `main.rs`

Owns the CLI.

Responsibilities:

- first-run bootstrap checks
- self-install the running executable into `~/.cherry/bin` when needed
- required Rust toolchain checks, with opt-in rustup installation
- parse command-line arguments
- dispatch commands
- read `.ch` source files
- format runtime errors with source snippets
- call package installation/list/info helpers
- call the interpreter for `run`

Important functions:

- `first_start_bootstrap`
- `bootstrap_command`
- `install_current_exe_to_path`
- `install_rust_with_rustup`
- `run_cli`
- `run_file`
- `check_file`
- `parse_source`
- `format_runtime_error`
- `show_package_info`

## `lexer.rs`

Turns source text into tokens.

Features:

- keywords: `import`, `let`, `mut`, `fn`, `if`, `else`, `while`, `return`, `print`
- literals: ints, floats, strings, booleans, `none`
- operators and punctuation
- `#` and `//` line comments
- line and column tracking

Errors are reported as:

```text
lexer error at line:column: message
```

## `parser.rs`

Turns tokens into an AST.

Features:

- deterministic recursive descent statement parsing
- precedence climbing for expressions
- call expressions
- member access expressions
- source spans attached to every statement and expression

The source span is used later for runtime diagnostics.

## `ast.rs`

Defines the syntax tree:

- `Program`
- `Stmt`
- `StmtKind`
- `Expr`
- `ExprKind`
- `Span`
- operators

Statements and expressions carry `Span` values.

## `runtime.rs`

Defines runtime values and environments.

Runtime values:

- `Int`
- `Float`
- `Bool`
- `String`
- `None`
- `Function`
- `NativePackage`
- `NativeFunction`
- `Object`

`Object` is used for package export tables, such as:

```cherry
widgets.theme.primary
```

`Environment` manages lexical variable scopes and mutability.

`RuntimeError` carries:

- message
- optional `Span`

## `interpreter.rs`

Executes AST nodes.

Responsibilities:

- execute top-level imports and declarations
- run `main()` automatically
- evaluate expressions
- enforce mutable vs immutable assignment
- call Cherry functions
- call native package functions
- resolve package exports
- attach runtime error spans

Import flow:

```cherry
import widgets
```

This loads the installed native package and defines `widgets` as a package value.

Member access flow:

```cherry
widgets.title
widgets.theme.primary
widgets.run()
```

The interpreter resolves:

1. native function names from `[api]`
2. static exported values from `[exports]`
3. nested object fields

## `package.rs`

Owns package metadata and installation.

Responsibilities:

- parse `Ident.toml`
- parse `Cherry.toml`
- detect package directory paths
- install `.chy` archives
- verify SHA256
- list installed packages
- remove packages
- create starter projects
- create starter native package projects

Active package location inside a Cherry project:

```text
./.cherry/packages/<name>/<version>/
```

Global package location outside a Cherry project:

```text
~/.cherry/packages/<name>/<version>/
```

Project-local lockfile:

```text
./.cherry/Cherry.lock
```

Global lockfile:

```text
~/.cherry/Cherry.lock
```

Package imports search the active project-local store first and then fall back to
the global store.

## `native_loader.rs`

Loads and calls native dynamic libraries with `libloading`.

Responsibilities:

- locate installed package metadata
- pick the current OS/architecture target
- load `.so`, `.dll`, or `.dylib`
- validate argument types against `[api]`
- bridge supported Cherry values into C ABI function calls
- convert TOML exports into Cherry runtime values

Current FFI bridge supports:

- `() -> none`
- `() -> int`
- `() -> float`
- `() -> bool`
- `(int) -> int`
- `(float) -> float`
- `(int, int) -> int`
- `(float, float) -> float`
- `(string) -> none`
- `(string, string) -> none`

String arguments are passed as `*const c_char` to native Rust functions.
