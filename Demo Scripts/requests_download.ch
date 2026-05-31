import requests

fn main() {
    let result = requests.download("https://example.com", "example.html")
    print(result.status)
    print(result.bytes)
    print(result.path)
}
