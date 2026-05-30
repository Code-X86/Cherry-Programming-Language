# Cherry CLI

The binary command is `cherry`.

When developing locally, prefer:

```sh
target/debug/cherry <command>
```

If using the installed command, refresh it after source changes:

```sh
PATH="/home/mikehawk/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin:$PATH" \
/home/mikehawk/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin/cargo install --path .
```

## Commands

### `cherry run <file.ch>`

Parses and executes a Cherry source file.

```sh
target/debug/cherry run examples/functions.ch
```

Execution order:

1. lex the source
2. parse into an AST
3. execute top-level imports and declarations
4. run `main()` automatically if it exists

### `cherry check <file.ch>`

Lexes and parses a file without executing it.

```sh
target/debug/cherry check examples/tui_widgets.ch
```

This is useful before running interactive or native package code.

### `cherry new <project-name>`

Creates a basic Cherry project:

```text
Cherry.toml
Cherry.lock
src/main.ch
```

Example:

```sh
target/debug/cherry new hello_cherry
```

### `cherry new-native <package-name>`

Creates a starter Rust native package:

```text
Cargo.toml
Ident.toml
README.md
LICENSE
src/lib.rs
bin/
```

Example:

```sh
target/debug/cherry new-native mathplus
```

### `cherry build`

Builds a Cherry project from a directory containing `Cherry.toml`.

Current behavior is intentionally simple:

- reads `Cherry.toml`
- expects `src/main.ch`
- copies the entry source into `build/<package-name>.ch`
- writes `Cherry.lock`

### `cherry install <package.chy>`

Installs a `.chy` package.

Installer behavior:

1. opens the `.chy` ZIP archive
2. reads `Ident.toml`
3. detects the current OS and architecture
4. selects the matching target binary
5. verifies the target binary SHA256
6. prints package type, capabilities, exports, and requested permissions
7. extracts to `~/.cherry/packages/<name>/<version>/`
8. records the package in the active Cherry lockfile

Example:

```sh
target/debug/cherry install examples/widgets.chy
```

Install location depends on the current directory:

- inside a Cherry project: `./.cherry/packages/<name>/<version>/`
- outside a Cherry project: `~/.cherry/packages/<name>/<version>/`

A Cherry project is any directory tree with a `Cherry.toml` in the current
directory or one of its parents.

### `cherry remove <package-name>`

Removes an installed package.

```sh
target/debug/cherry remove widgets
```

### `cherry uninstall <package-name>`

Alias for `remove`.

```sh
target/debug/cherry uninstall widgets
```

### `cherry list`

Lists installed packages:

```sh
target/debug/cherry list
```

Example output:

```text
tuidemo 0.1.0 [app interactive]
widgets 0.1.0 [app interactive]
wikiview 0.1.0 [app interactive]
```

### `cherry info <package-name>`

Shows package metadata, permissions, exports, and API:

```sh
target/debug/cherry info widgets
```

Example output includes:

```text
widgets 0.1.0
Type: app
Capabilities:
  kind: tui
  interactive: true
  entry: run
Exports:
  name
  supports_buttons
  supports_labels
  theme
  version_code
Permissions:
  terminal: true
  keyboard: true
API:
  button(string, string) -> none
  clear() -> none
  label(string) -> none
  run() -> none
  status(string) -> none
  title(string) -> none
```

### `cherry doctor`

Prints environment details:

```sh
target/debug/cherry doctor
```

Includes:

- Cherry version
- OS
- architecture
- project root, if one is active
- active `.cherry` directory
- package directory
- global package directory
- installed package count

### `cherry bootstrap`

Installs the currently running Cherry executable into Cherry's own bin directory:

```text
~/.cherry/bin/cherry
```

If `~/.cherry/bin` is not already on `PATH`, Cherry adds it to `.profile`,
`.bashrc`, and `.zshrc`. It also prepends `~/.cherry/bin` to `PATH` for the
running Cherry process. A child process cannot permanently change the parent
shell environment, so restart the terminal or run the printed `export` command
for the current prompt. If Rust is missing, `bootstrap` also installs Rust with
rustup.

```sh
cherry bootstrap
```

First-run behavior is more conservative: Cherry creates `~/.cherry/bin`, copies
itself there if no `cherry` command is found, and updates shell startup files.
It only installs Rust automatically when this environment variable is set:

```sh
CHERRY_AUTO_INSTALL_RUST=1
```

Disable bootstrap checks entirely:

```sh
CHERRY_SKIP_BOOTSTRAP=1 cherry doctor
```
