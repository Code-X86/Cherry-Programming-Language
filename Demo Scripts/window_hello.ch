import window

fn main() {
    let app = window.create("Cherry Window", 800, 500)
    app.setColor(30, 30, 40)

    while app.isOpen() {
        app.clear()
        app.text("Hello from Cherry", 40, 40)
        app.present()
    }
}
