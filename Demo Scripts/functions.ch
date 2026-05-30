let x = 5
let y = 10

fn add(a, b) {
    return a + b
}

fn describe(value) {
    if value > 10 {
        print("large")
    } else {
        print("small")
    }
}

fn main() {
    let result = add(x, y)
    print(result)
    describe(result)
}
