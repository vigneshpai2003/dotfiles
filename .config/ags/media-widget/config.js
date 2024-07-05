import { Media } from "./Media.js"

const win = Widget.Window({
    name: "media-widget",
    anchor: ["top", "right"],
    child: Media(),
})

App.config({
    style: "./style.css",
    windows: [win],
})

App.toggleWindow(win.name)

export default win
