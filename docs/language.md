# Cherry Language

## File Flags

Cherry files can set runtime behavior with `flag` statements.

```cherry
[
    error = "abort"
    error_output = "stderr"
    main = "auto"
]
```

The block must be at the top of the file. It starts with `[` and ends with `]`.

Supported flags:

- `error = "abort"`: default; runtime errors stop the program.
- `error = "continue"`: report the runtime error, skip the failing statement, and keep running.
- `error = "ignore"`: skip failing statements silently.
- `error_output = "stderr"`: default; continued errors print to stderr.
- `error_output = "stdout"`: continued errors print to stdout.
- `main = "auto"`: default; run `main()` automatically after top-level code.
- `main = "manual"`: do not run `main()` automatically.

Cherry is intentionally small. The parser is deterministic, uses braces for
blocks, and does not depend on indentation.

## Files

Cherry source files use:

```text
.ch
```

Example:

```cherry
fn main() {
    print("Hello from Cherry")
}
```

## Comments

Cherry supports line comments:

```cherry
# shell-style comment
// C-style line comment
```

## Variables

Immutable variable:

```cherry
let x = 5
```

Mutable variable:

```cherry
let mut total = 0
total = total + 1
```

Assigning to an immutable variable is a runtime error.

## Values

Supported v1 values:

- `int`
- `float`
- `bool`
- `string`
- `none`

Examples:

```cherry
let count = 10
let ratio = 0.5
let enabled = true
let name = "Cherry"
let empty = none
```

## Functions

Functions use `fn`:

```cherry
fn add(a, b) {
    return a + b
}

fn main() {
    print(add(2, 3))
}
```

If a `main()` function exists, Cherry runs it automatically after top-level
imports and declarations are processed.

## Blocks

Blocks use braces:

```cherry
if score > 10 {
    print("high")
} else {
    print("low")
}
```

Cherry does not parse Python-style indentation.

## Control Flow

`if` and `else`:

```cherry
if x > 0 {
    print("positive")
} else {
    print("zero or negative")
}
```

`while`:

```cherry
let mut i = 0

while i < 3 {
    print(i)
    i = i + 1
}
```

`return`:

```cherry
fn value() {
    return 42
}
```

## Operators

Arithmetic:

```cherry
a + b
a - b
a * b
a / b
a % b
```

Comparison:

```cherry
a == b
a != b
a < b
a <= b
a > b
a >= b
```

Boolean logic:

```cherry
ready && enabled
ready || enabled
!ready
```

## Imports

Imports load installed native packages:

```cherry
import widgets

fn main() {
    widgets.title("Demo")
}
```

Imported packages are available as package objects. Member access resolves native
functions and static exports:

```cherry
print(widgets.name)
print(widgets.theme.primary)
widgets.run()
```

## Errors

Lexer and parser errors include line and column numbers.

Runtime errors include:

- message
- line and column
- file path
- source line
- caret location

Example:

```text
runtime error at 2:14: division by zero
 --> examples/bad.ch:2:14
  |
2 |     print(10 / 0)
  |              ^
```
