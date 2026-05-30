# Examples

All examples live under:

```text
examples/
```

Use `target/debug/cherry` to run the latest local build.

## `hello.ch`

Basic variables and printing:

```sh
target/debug/cherry run examples/hello.ch
```

Expected output:

```text
Hello from Cherry
```

## `functions.ch`

Functions, return values, and `if/else`:

```sh
target/debug/cherry run examples/functions.ch
```

Expected output:

```text
15
large
```

## `control_flow.ch`

Mutable variables and `while` loop:

```sh
target/debug/cherry run examples/control_flow.ch
```

Expected output:

```text
factorial ok
120
```

## `ml_minigame.ch`

Small console minigame demonstrating a perceptron-like learning loop.

```sh
target/debug/cherry run examples/ml_minigame.ch
```

It prints training rounds, learned weights, test rounds, and a final score.

## `native_import.ch`

Shows the intended native package import style:

```cherry
import mathplus

fn main() {
    print(mathplus.add(5, 10))
}
```

Requires `mathplus` to be packaged and installed.

## `wikiview_demo.ch`

Uses the `wikiview` native package:

```sh
target/debug/cherry install examples/wikiview.chy
target/debug/cherry run examples/wikiview_demo.ch
```

The package prompts for a Wikipedia topic and prints the page summary.

## `tuidemo.ch`

Runs the basic TUI demo:

```sh
target/debug/cherry install examples/tuidemo.chy
target/debug/cherry run examples/tuidemo.ch
```

Press `q` to exit.

## `tui_widgets.ch`

Builds a TUI from Cherry code:

```sh
target/debug/cherry install examples/widgets.chy
target/debug/cherry run examples/tui_widgets.ch
```

Press `q` to exit.

## `package_exports.ch`

Demonstrates static package exports:

```sh
target/debug/cherry run examples/package_exports.ch
```

Expected output:

```text
Cherry TUI Demo
red
1
Cherry
white
```

## `sample_project`

A generated-style Cherry project:

```text
examples/sample_project/
  Cherry.toml
  Cherry.lock
  src/main.ch
```

Run:

```sh
target/debug/cherry run examples/sample_project/src/main.ch
```

Expected output:

```text
21
```

