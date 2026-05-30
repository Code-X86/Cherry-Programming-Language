fn factorial(n) {
    let mut value = 1
    let mut i = 2

    while i <= n {
        value = value * i
        i = i + 1
    }

    return value
}

fn main() {
    let answer = factorial(5)

    if answer == 120 {
        print("factorial ok")
        print(answer)
    } else {
        print("factorial failed")
    }
}
