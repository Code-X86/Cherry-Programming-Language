fn main() {
    let a = vec3(1, 2, 3)
    let b = vec3(4, 5, 6)

    print(a + b)
    print(a.dot(b))
    print(a.cross(b))
    print(a.normalize().length())
}
