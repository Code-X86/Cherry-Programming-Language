import window

fn main() {
    let app = window.create("Cherry Shapes", 800, 500)
    app.setColor(20, 22, 28)

    while app.isOpen() {
        app.clear()
        app.rect(80, 90, 160, 90)
        app.circle(420, 230, 70)
        app.line(60, 420, 740, 80)
        app.text("Shapes", 40, 35)
        app.present()
    }
}
