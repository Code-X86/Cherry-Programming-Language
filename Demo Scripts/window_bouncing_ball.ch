import window

fn main() {
    let app = window.create("Cherry Bouncing Ball", 800, 500)
    app.setColor(12, 14, 20)

    let mut x = 120
    let mut y = 90
    let mut dx = 4
    let mut dy = 3

    while app.isOpen() {
        app.clear()
        app.circle(x, y, 24)
        app.present()

        x = x + dx
        y = y + dy

        if x < 25 || x > 775 {
            dx = 0 - dx
        }
        if y < 25 || y > 475 {
            dy = 0 - dy
        }
    }
}
