# Window Module

Cherry v1.5 adds a built-in `window` module for simple native windows.

```cherry
import window

fn main() {
    let app = window.create("Cherry App", 800, 600)
    app.setColor(30, 30, 40)

    while app.isOpen() {
        app.clear()
        app.text("Hello from Cherry", 40, 40)
        app.rect(40, 80, 180, 90)
        app.present()
    }
}
```

## API

- `window.create(title, width, height)`
- `window.create(title, width, height, mode)`
- `app.show()`
- `app.close()`
- `app.isOpen()`
- `app.clear()`
- `app.present()`
- `app.setTitle(title)`
- `app.setSize(width, height)`
- `app.setColor(r, g, b)`
- `app.setDrawColor(r, g, b)`
- `app.text(value, x, y)`
- `app.rect(x, y, width, height)`
- `app.circle(x, y, radius)`
- `app.line(x1, y1, x2, y2)`
- `app.triangleDepth(x1, y1, z1, x2, y2, z2, x3, y3, z3)`
- `app.inputKey(key)`
- `app.mouseX()`
- `app.mouseY()`
- `app.mouseDown(button)`
- `app.fps()`

The optional `mode` argument can be `"windowed"` or `"frameless"`.

Text rendering is placeholder-quality in this first release. Shapes, mouse input,
key input, and frame presentation are the foundation for the later GUI toolkit.

## 3D Engine Test

Cherry does not have hardware 3D yet, but the window module can run a simple
software 3D pipeline:

```sh
cherry run examples/engine_3d_test.ch
```

The example rotates cube vertices, projects them with perspective math, fills
colored faces with `app.triangleDepth(...)`, and draws crisp wireframe edges
with `app.line(...)`.
