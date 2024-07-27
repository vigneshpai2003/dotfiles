import "lib/session"
import "style/style"
import { forMonitors } from "lib/utils"
import OSD from "widget/osd/OSD"
import Media from "widget/Media"

App.config({
    windows: [
        ...forMonitors(OSD),
        Media
    ],
    iconTheme: "kora"
})
