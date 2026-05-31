import requests

fn main() {
    let response = requests.get("https://example.com")
    print(response.status)
    print(response.contentType)
    print(response.text)
}
