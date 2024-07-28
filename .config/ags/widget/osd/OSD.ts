import icons from "lib/icons"
import Progress from "./Progress"
import brightness from "service/brightness"
import options from "options"

const audio = await Service.import("audio")
const { progress, microphone } = options.osd

const DELAY = 2500

function calculateAudioIcon(volume: number) {
    const approxVolume = Number(volume.toPrecision(2))

    if (approxVolume < 0.33)
        return icons.audio.volume.low

    if (approxVolume < 0.66)
        return icons.audio.volume.medium

    if (approxVolume <= 1)
        return icons.audio.volume.high

    return icons.audio.volume.overamplified
}

function calculateScreenBrightnessIcon(brightness: number) {
    const approxBrightness = Number(brightness.toPrecision(2))

    if (approxBrightness < 0.33)
        return icons.brightness.screen.low

    if (approxBrightness < 0.66)
        return icons.brightness.screen.medium

    return icons.brightness.screen.high
}

function OnScreenProgress(vertical: boolean) {
    const indicator = Widget.Icon({
        size: 42,
        vpack: "start",
    })
    const progress = Progress({
        vertical,
        width: vertical ? 42 : 300,
        height: vertical ? 300 : 42,
        child: indicator,
    })

    const revealer = Widget.Revealer({
        transition: "slide_left",
        child: progress,
    })

    let count = 0
    function show(value: number, icon: string, class_name: string) {
        revealer.reveal_child = true
        progress.toggleClassName('screen', false)
        progress.toggleClassName('kbd', false)
        progress.toggleClassName('speaker', false)
        progress.toggleClassName(class_name, true)
        indicator.icon = icon
        progress.setValue(value)
        count++
        Utils.timeout(DELAY, () => {
            count--

            if (count === 0)
                revealer.reveal_child = false
        })
    }

    return revealer
        .hook(brightness, () => show(
            brightness.screen,
            calculateScreenBrightnessIcon(brightness.screen),
            "screen"
        ), "notify::screen")
        .hook(brightness, () => show(
            brightness.kbd,
            icons.brightness.keyboard,
            "kbd"
        ), "notify::kbd")
        .hook(audio.speaker, () => show(
            audio.speaker.volume,
            calculateAudioIcon(audio.speaker.volume),
            "speaker"
        ), "notify::volume")
}

function MicrophoneMute() {
    const icon = Widget.Icon({
        class_name: "microphone",
    })

    const revealer = Widget.Revealer({
        transition: "slide_up",
        child: icon,
    })

    let count = 0
    let microphoneMute = audio.microphone.stream?.is_muted ?? false
    let speakerMute = audio.speaker.stream?.is_muted ?? false

    return revealer.hook(audio.microphone, () => Utils.idle(() => {
        if (microphoneMute !== audio.microphone.stream?.is_muted) {
            microphoneMute = audio.microphone.stream!.is_muted
            icon.icon = icons.audio.mic[microphoneMute ? "muted" : "high"]
            revealer.reveal_child = true
            count++

            Utils.timeout(DELAY, () => {
                count--
                if (count === 0)
                    revealer.reveal_child = false
            })
        }
    })).hook(audio.speaker, () => Utils.idle(() => {
        if (speakerMute !== audio.speaker.stream?.is_muted) {
            speakerMute = audio.speaker.stream!.is_muted
            icon.icon = speakerMute ? icons.audio.volume.muted : calculateAudioIcon(audio.speaker.volume)
            revealer.reveal_child = true
            count++

            Utils.timeout(DELAY, () => {
                count--
                if (count === 0)
                    revealer.reveal_child = false
            })
        }
    }))
}

export default (monitor: number) => Widget.Window({
    monitor,
    name: `indicator${monitor}`,
    class_name: "indicator",
    layer: "overlay",
    click_through: true,
    anchor: ["right", "left", "top", "bottom"],
    child: Widget.Box({
        css: "padding: 2px;",
        expand: true,
        child: Widget.Overlay({
            child: Widget.Box({ expand: true }),
            overlays: [
                Widget.Box({
                    hpack: progress.pack.h.bind(),
                    vpack: progress.pack.v.bind(),
                    child: progress.vertical.bind().as(OnScreenProgress),
                }),
                Widget.Box({
                    hpack: microphone.pack.h.bind(),
                    vpack: microphone.pack.v.bind(),
                    child: MicrophoneMute(),
                })
            ]
        }),
    }),
})
