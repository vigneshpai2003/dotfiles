import icons, { substitutes } from "./icons"
import GLib from "gi://GLib?version=2.0"
import Gtk from "gi://Gtk?version=3.0"
import Gdk from "gi://Gdk"

export function forMonitors(widget: (monitor: number) => Gtk.Window) {
    const n = Gdk.Display.get_default()?.get_n_monitors() || 1
    return range(n, 0).flatMap(widget)
}

/**
 * @returns [start...length]
 */
export function range(length: number, start = 1) {
    return Array.from({ length }, (_, i) => i + start)
}

/**
 * @returns execAsync(["bash", "-c", cmd])
 */
export async function bash(strings: TemplateStringsArray | string, ...values: unknown[]) {
    const cmd = typeof strings === "string" ? strings : strings
        .flatMap((str, i) => str + `${values[i] ?? ""}`)
        .join("")

    return Utils.execAsync(["bash", "-c", cmd]).catch(err => {
        console.error(cmd, err)
        return ""
    })
}

/**
 * @returns execAsync(cmd)
 */
export async function sh(cmd: string | string[]) {
    return Utils.execAsync(cmd).catch(err => {
        console.error(typeof cmd === "string" ? cmd : cmd.join(" "), err)
        return ""
    })
}

export function icon(name: string | null, fallback = icons.missing) {
    if (!name)
        return fallback || ""

    if (GLib.file_test(name, GLib.FileTest.EXISTS))
        return name

    const icon = (substitutes[name] || name)
    if (Utils.lookUpIcon(icon))
        return icon

    print(`no icon substitute "${icon}" for "${name}", fallback: "${fallback}"`)
    return fallback
}
