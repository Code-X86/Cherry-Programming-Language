import math
import window

fn main() {
    let app = window.create("Cherry Math Graph", 900, 520)
    app.setColor(10, 12, 18)

    while app.isOpen() {
        app.clear()
        app.line(40, 260, 860, 260)
        app.line(450, 40, 450, 480)

        for x in 0..820 {
            let sx = x + 40
            let t = (x / 820) * math.tau
            let y = 260 + math.sin(t) * 120
            app.rect(sx, y, 2, 2)
        }

        app.text("sin wave", 40, 30)
        app.present()
    }
}
