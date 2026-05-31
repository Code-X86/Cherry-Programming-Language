import window

fn main() {
    let app = window.create("Cherry Mouse", 700, 450)
    app.setColor(18, 18, 22)

    while app.isOpen() {
        app.clear()
        let x = app.mouseX()
        let y = app.mouseY()
        app.circle(x, y, 18)
        if app.mouseDown("left") {
            app.rect(x - 25, y - 25, 50, 50)
        }
        app.text("Move and click", 30, 30)
        app.present()
    }
}
