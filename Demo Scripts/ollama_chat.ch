import console
import requests

let model = "qwen3.5:2b"
let url = "http://127.0.0.1:11434/api/generate"

fn ask_ollama(prompt) {
    let body = "{"
        + "\"model\":" + requests.jsonString(model) + ","
        + "\"prompt\":" + requests.jsonString(prompt) + ","
        + "\"stream\":true"
        + "}"

    print("ollama> ")
    requests.postStreamJson(url, body, "response")
}

fn main() {
    print("Cherry Ollama chat")
    print("Make sure Ollama is running: ollama serve")
    print("Type /quit to exit")

    let mut running = true

    while running {
        let message = console.input("you> ")

        if message == "/quit" {
            running = false
        } else {
            if message != "" {
                ask_ollama(message)
            }
        }
    }
}
