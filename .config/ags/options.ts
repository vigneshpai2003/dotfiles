import { opt, mkOptions } from "lib/option"

const Tpack = opt<"start" | "center" | "end">
const Tanchor = opt<Array<"top" | "bottom" | "left" | "right">>

const options = mkOptions(OPTIONS, {
    autotheme: opt(false),

    theme: {
        border: {
            width: opt(1),
            opacity: opt(96),
        },

        shadows: opt(true),
        padding: opt(7),
        spacing: opt(12),
        radius: opt(11),
    },

    transition: opt(200),

    font: {
        size: opt(13),
        name: opt("Ubuntu Nerd Font"),
    },

    osd: {
        progress: {
            vertical: opt(true),
            pack: {
                h: Tpack("end"),
                v: Tpack("center"),
            },
        },
        microphone: {
            pack: {
                h: Tpack("center"),
                v: Tpack("end"),
            },
        },
    },

    media: {
        anchor: Tanchor(["bottom", "right"])
    },

    notifications: {
        anchor: Tanchor(["top", "right"]),
        width: opt(500),
        timeout: opt(6000)
    },

    launcher: {
        width: opt(0),
        margin: opt(80),
        nix: {
            pkgs: opt("nixpkgs/nixos-unstable"),
            max: opt(8),
        },
        sh: {
            max: opt(16),
        },
        apps: {
            iconSize: opt(62),
            max: opt(6),
            favorites: opt([
                [
                    "brave-browser",
                    "visual studio code",
                    "terminal",
                    "resources"
                ],
            ]),
        },
    },
})

globalThis["options"] = options
export default options
