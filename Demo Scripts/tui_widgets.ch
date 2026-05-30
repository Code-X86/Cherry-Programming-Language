import widgets

fn main() {
    widgets.clear()
    widgets.title("Cherry Widget Builder")
    widgets.label("This screen is assembled from Cherry code.")
    widgets.label("Buttons below were added with widgets.button().")
    widgets.button("Train", "Training job selected")
    widgets.button("Docs", "Opening docs would happen here")
    widgets.button("Quit", "Press q to leave the TUI")
    widgets.status("Choose a button and press enter.")
    widgets.run()
}
