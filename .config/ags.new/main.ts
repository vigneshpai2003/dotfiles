import "lib/session"
import "style/style"
import { forMonitors } from "lib/utils"
import OSD from "widget/osd/OSD"

App.config({
    windows: () => [
        ...forMonitors(OSD),
    ],
})
