# Requests

The built-in `requests` module is Cherry's basic curl-like HTTP client.

```cherry
import requests

fn main() {
    let response = requests.get("https://example.com")
    print(response.status)
    print(response.text)
}
```

## Functions

- `requests.get(url)`
- `requests.post(url, body)`
- `requests.put(url, body)`
- `requests.delete(url)`
- `requests.head(url)`
- `requests.fetch(method, url, body)`
- `requests.download(url, path)`
- `requests.jsonString(value)`
- `requests.jsonField(jsonText, key)`
- `requests.postStreamJson(url, body, key)`

`get`, `post`, `put`, `delete`, `head`, and `fetch` return an object:

```text
status
ok
statusText
contentType
url
text
```

`download` writes the response body to a file and returns:

```text
status
ok
    path
    bytes
```

`jsonString` escapes a Cherry value so it can be placed into a JSON request
body. `jsonField` pulls a top-level field out of a JSON response, which is handy
for simple APIs like Ollama.

`postStreamJson` sends a POST request, reads newline-delimited JSON as it
arrives, prints the selected field immediately, and returns the collected text.
It is designed for APIs like Ollama's streaming endpoint.

This is intentionally small. Headers, JSON helpers, authentication helpers, and
streaming can be added later without changing the basic API.

## Ollama Chat Example

```cherry
import console
import requests

let model = "llama3.2"
let url = "http://127.0.0.1:11434/api/generate"

fn main() {
    let mut running = true

    while running {
        let message = console.input("you> ")

        if message == "/quit" {
            running = false
        } else {
            let body = "{"
                + "\"model\":" + requests.jsonString(model) + ","
                + "\"prompt\":" + requests.jsonString(message) + ","
                + "\"stream\":true"
                + "}"

            print("ollama> ")
            requests.postStreamJson(url, body, "response")
        }
    }
}
```

Run Ollama locally first, then run:

```sh
cherry run examples/ollama_chat.ch
```
