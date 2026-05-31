[
    error = "continue"
    error_output = "stdout"
    main = "auto"
]

fn fail() {
    print(missing_value)
}

fn main() {
    print("before error")
    fail()
    print("after error")

    print(another_missing_value)
    print("still running after second error")
}
