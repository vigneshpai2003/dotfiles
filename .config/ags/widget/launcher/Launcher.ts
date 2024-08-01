import PopupWindow, { Padding } from "widget/PopupWindow"
import icons from "lib/icons"
import options from "options"
import * as AppLauncher from "./AppLauncher"
import Gdk from "types/@girs/gdk-3.0/gdk-3.0"

const { width, margin } = options.launcher

function Launcher() {
    const favs = AppLauncher.Favorites()
    const applauncher = AppLauncher.Launcher()
 
    favs.set_can_focus(true)
    applauncher.set_can_focus(true)

    function handleNumberKey(event) {
        let pressed = event.get_keyval()[1]

        if (Gdk.KEY_1 <= pressed && pressed <= Gdk.KEY_9) {
            let index = pressed - Gdk.KEY_1
            if (favs.get_reveal_child()) {
                favs.launch(index)
            } else {
                applauncher.launch(index)
                App.toggleWindow("launcher")
            }
        }
    }

    const entry = Widget.Entry({
        hexpand: true,
        primary_icon_name: icons.ui.search,
        on_accept: ({ text }) => {
            if (favs.get_reveal_child())
                favs.get_children()[0].get_children()[1].children[0].on_clicked()
            else {
                applauncher.launchFirst()
                App.toggleWindow("launcher")
            }
            entry.text = ""
        },
        on_change: ({ text }) => {
            text ||= ""
            favs.reveal_child = text === ""
            applauncher.filter(text)
        },
    }).on("key-press-event", (self, event) => {
        handleNumberKey(event)
    })

    function focus() {
        entry.text = ""
        entry.set_position(-1)
        entry.select_region(0, -1)
        entry.grab_focus()
        favs.reveal_child = true
    }

    const layout = Widget.Box({
        css: width.bind().as(v => `min-width: ${v}pt;`),
        class_name: "launcher",
        vertical: true,
        vpack: "start",
        setup: self => self.hook(App, (_, win, visible) => {
            if (win !== "launcher")
                return

            entry.text = ""
            if (visible)
                focus()
            applauncher.filter("")
        }),
        children: [
            Widget.Box([entry]),
            favs,
            applauncher,
        ],
    })

    return Widget.Box(
        { vertical: true, css: "padding: 1px" },
        Padding("launcher", {
            css: margin.bind().as(v => `min-height: ${v}pt;`),
            vexpand: false,
        }),
        layout,
    ).on("key-press-event", (self, event: Gdk.Event) => {
        entry.grab_focus()
        entry.set_position(-1)
        entry.select_region(-2, -1)
        entry.emit("key-press-event", event)
    })
}

export default () => PopupWindow({
    name: "launcher",
    layout: "top",
    child: Launcher(),
})
