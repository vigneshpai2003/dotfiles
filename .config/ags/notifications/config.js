import { NotificationPopups } from "./notificationPopups.js"

Utils.timeout(100, () => Utils.notify({
    summary: "AGS Notification Daemon",
    iconName: "info-symbolic",
    body: "Notification daemon started!",
    actions: {
        "Cool": () => print("pressed Cool"),
    },
}))

App.config({
    style: App.configDir + "/style.css",
    windows: [
        NotificationPopups(),
    ],
})