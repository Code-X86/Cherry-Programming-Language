# TUI and Widgets

Cherry can load native packages that own the terminal and draw a text UI. This
works through native Rust packages, not through Cherry syntax changes.

## TUI Permissions

Interactive terminal packages should declare:

```toml
[permissions]
terminal = true
keyboard = true
```

They should also declare capabilities:

```toml
[capabilities]
kind = "tui"
interactive = true
entry = "run"
```

During install, Cherry prints an interactive package note:

```text
Interactive package note:
  this package may take over terminal rendering until it exits
```

## `tuidemo`

`tuidemo` is a basic full-screen TUI example.

Cherry:

```cherry
import tuidemo

fn main() {
    tuidemo.open()
}
```

Run:

```sh
target/debug/cherry run examples/tuidemo.ch
```

Controls:

- up/down to move
- `q` to exit

## `widgets`

`widgets` is a configurable TUI package. Cherry code creates labels and buttons
before opening the full-screen terminal UI.

Cherry:

```cherry
import widgets

fn main() {
    widgets.clear()
    widgets.title("Cherry Widget Builder")
    widgets.label("This screen is assembled from Cherry code.")
    widgets.label("Buttons below were added with widgets.button().")
    widgets.button("Train", "Training job selected")
    widgets.button("Docs", "Opening docs would happen here")
    widgets.button("Quit", "Press q to leave the TUI")
    widgets.status("Choose a button and press enter.")
    widgets.run()
}
```

Run:

```sh
target/debug/cherry run examples/tui_widgets.ch
```

Controls:

- tab/arrows to select buttons
- enter to activate selected button
- `q` or escape to exit

## `widgets` API

### `widgets.clear()`

Resets the package UI state to defaults.

### `widgets.title(text)`

Sets the screen title.

```cherry
widgets.title("Control Panel")
```

### `widgets.label(text)`

Adds a line of text to the UI.

```cherry
widgets.label("Ready")
```

### `widgets.button(label, action)`

Adds a selectable button.

The first string is displayed on the button. The second string is shown as the
status message when the user presses enter on that button.

```cherry
widgets.button("Deploy", "Deploy clicked")
```

### `widgets.status(text)`

Sets the initial status message.

```cherry
widgets.status("Choose an action.")
```

### `widgets.run()`

Opens the full-screen terminal UI.

This function blocks until the user exits.

## Why This Does Not Require Recompiling Cherry

Cherry loads the installed package dynamically:

1. `import widgets` reads installed package metadata
2. Cherry loads `libwidgets.so`
3. `widgets.title(...)` calls a native symbol
4. the package stores UI state internally
5. `widgets.run()` opens the terminal UI

Only the native package needs to be compiled when its implementation changes.
Cherry only needs to be rebuilt when the FFI bridge or language runtime changes.

## Current Limitations

- callbacks from native packages into Cherry functions are not implemented
- buttons only update native package status text
- no package-defined Cherry syntax
- no dynamic object return values from native functions yet
- string return values are not implemented yet

