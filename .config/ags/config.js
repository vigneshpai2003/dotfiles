import { Media } from "./Media.js"

const win = Widget.Window({
    name: "mpris",
    anchor: ["top", "left"],
    child: Media(),
    layer: "background"
})

App.config({
    style: "./style.css",
    windows: [win],
})