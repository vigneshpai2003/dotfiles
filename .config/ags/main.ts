import "lib/session"
import "style/style"
import { forMonitors } from "lib/utils"
import OSD from "widget/osd/OSD"
import Media from "widget/Media"
import NotificationPopups from "widget/notifications/NotificationPopups"

App.config({
    windows: [
        ...forMonitors(OSD),
        ...forMonitors(NotificationPopups),
        Media
    ],
    iconTheme: "kora"
})
