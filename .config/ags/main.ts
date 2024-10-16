import "lib/session"
import "style/style"
import { forMonitors } from "lib/utils"
import OSD from "widget/osd/OSD"
import Media from "widget/Media"
import NotificationPopups from "widget/notifications/NotificationPopups"
import NotificationCenter from "widget/notifications/NotificationCenter"
import Launcher from "widget/launcher/Launcher"

App.config({
    windows: [
        ...forMonitors(OSD),
        ...forMonitors(NotificationPopups),
        NotificationCenter(),
        Media(),
        Launcher(),
    ],
    iconTheme: "kora"
})

globalThis.launcher = Launcher
