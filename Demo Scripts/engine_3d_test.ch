import math
import window

let width = 900
let height = 620
let cx = width // 2
let cy = height // 2
let scale = 180
let distance = 4

fn rotate_x_y_z(x, y, z, ax, ay, az) {
    let cosx = math.cos(ax)
    let sinx = math.sin(ax)
    let cosy = math.cos(ay)
    let siny = math.sin(ay)
    let cosz = math.cos(az)
    let sinz = math.sin(az)

    let y1 = y * cosx - z * sinx
    let z1 = y * sinx + z * cosx
    let x1 = x

    let x2 = x1 * cosy + z1 * siny
    let z2 = (0 - x1) * siny + z1 * cosy
    let y2 = y1

    let x3 = x2 * cosz - y2 * sinz
    let y3 = x2 * sinz + y2 * cosz

    return [x3, y3, z2]
}

fn project_x(point) {
    let z = point[2] + distance
    return cx + point[0] * scale / z
}

fn project_y(point) {
    let z = point[2] + distance
    return cy + point[1] * scale / z
}

fn project_z(point) {
    return point[2] + distance
}

fn draw_edge(app, a, b) {
    app.line(project_x(a), project_y(a), project_x(b), project_y(b))
}

fn draw_tri(app, a, b, c, r, g, blue) {
    app.setDrawColor(r, g, blue)
    app.triangleDepth(
        project_x(a), project_y(a), project_z(a),
        project_x(b), project_y(b), project_z(b),
        project_x(c), project_y(c), project_z(c)
    )
}

fn draw_face(app, a, b, c, d, r, g, blue) {
    draw_tri(app, a, b, c, r, g, blue)
    draw_tri(app, a, c, d, r, g, blue)
}

fn draw_cube(app, angle) {
    let ax = angle * 0.7
    let ay = angle
    let az = angle * 0.35

    let p0 = rotate_x_y_z(-1, -1, -1, ax, ay, az)
    let p1 = rotate_x_y_z(1, -1, -1, ax, ay, az)
    let p2 = rotate_x_y_z(1, 1, -1, ax, ay, az)
    let p3 = rotate_x_y_z(-1, 1, -1, ax, ay, az)
    let p4 = rotate_x_y_z(-1, -1, 1, ax, ay, az)
    let p5 = rotate_x_y_z(1, -1, 1, ax, ay, az)
    let p6 = rotate_x_y_z(1, 1, 1, ax, ay, az)
    let p7 = rotate_x_y_z(-1, 1, 1, ax, ay, az)

    draw_face(app, p0, p1, p2, p3, 230, 75, 80)
    draw_face(app, p4, p7, p6, p5, 70, 175, 245)
    draw_face(app, p0, p4, p5, p1, 250, 185, 70)
    draw_face(app, p3, p2, p6, p7, 80, 220, 145)
    draw_face(app, p1, p5, p6, p2, 170, 105, 245)
    draw_face(app, p0, p3, p7, p4, 245, 110, 190)

    app.setDrawColor(245, 250, 255)
    draw_edge(app, p0, p1)
    draw_edge(app, p1, p2)
    draw_edge(app, p2, p3)
    draw_edge(app, p3, p0)

    draw_edge(app, p4, p5)
    draw_edge(app, p5, p6)
    draw_edge(app, p6, p7)
    draw_edge(app, p7, p4)

    draw_edge(app, p0, p4)
    draw_edge(app, p1, p5)
    draw_edge(app, p2, p6)
    draw_edge(app, p3, p7)
}

fn main() {
    let app = window.create("Cherry 3D Engine Test", width, height, "frameless")
    app.setColor(8, 10, 16)

    let mut angle = 0

    while app.isOpen() {
        if app.inputKey("Escape") {
            app.close()
        } else {
            app.clear()
            app.setDrawColor(210, 225, 245)
            app.text("Cherry 3D Engine Test", 30, 30)
            app.text("Depth-buffered triangles + wireframe", 30, 50)
            app.text("Press Escape to close", 30, 70)
            app.text("FPS", width - 95, 20)
            app.text(app.fps(), width - 55, 20)
            app.setDrawColor(45, 55, 75)
            app.line(0, cy, width, cy)
            app.line(cx, 0, cx, height)
            draw_cube(app, angle)
            app.present()

            angle = angle + 0.035
        }
    }
}
