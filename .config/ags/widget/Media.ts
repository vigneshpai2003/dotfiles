import icons from "lib/icons"
import options from "options"

const mpris = await Service.import("mpris")
const players = mpris.bind("players")

function lengthStr(length: number) {
    const min = Math.floor(length / 60)
    const sec = Math.floor(length % 60)
    const sec0 = sec < 10 ? "0" : ""
    return `${min}:${sec0}${sec}`
}

function Player(player) {
    const img = Widget.Box({
        class_name: "img",
        vpack: "start",
        css: player.bind("cover_path").transform(p => `
            background-image: url('${p}');
        `),
    })

    const title = Widget.Label({
        class_name: "title",
        wrap: true,
        hpack: "start",
        label: player.bind("track_title"),
    })

    const artist = Widget.Label({
        class_name: "artist",
        wrap: true,
        hpack: "start",
        label: player.bind("track_artists").transform(a => a.join(", ")),
    })

    const positionSlider = Widget.Slider({
        class_name: "position",
        draw_value: false,
        on_change: ({ value }) => player.position = value * player.length,
        visible: player.bind("length").as(l => l > 0),
        setup: self => {
            function update() {
                const value = player.position / player.length
                self.value = value > 0 ? value : 0
            }
            self.hook(player, update)
            self.hook(player, update, "position")
            self.poll(1000, update)
        },
    })

    const positionLabel = Widget.Label({
        class_name: "position",
        hpack: "start",
        setup: self => {
            const update = (_, time) => {
                self.label = lengthStr(time || player.position)
                self.visible = player.length > 0
            }

            self.hook(player, update, "position")
            self.poll(1000, update)
        },
    })

    const lengthLabel = Widget.Label({
        class_name: "length",
        hpack: "end",
        visible: player.bind("length").transform(l => l > 0),
        label: player.bind("length").transform(lengthStr),
    })

    const icon = Widget.Icon({
        class_name: "icon",
        hexpand: true,
        hpack: "end",
        vpack: "start",
        tooltip_text: player.identity || "",
        icon: player.bind("entry").transform(entry => {
            const name = `${entry}-symbolic`
            return Utils.lookUpIcon(name) ? name : icons.fallback.audio
        }),
    })

    const playPause = Widget.Button({
        class_name: "play-pause",
        on_clicked: () => player.playPause(),
        visible: player.bind("can_play"),
        child: Widget.Icon({
            icon: player.bind("play_back_status").transform(s => {
                switch (s) {
                    case "Playing": return icons.mpris.playing
                    case "Paused":
                    case "Stopped": return icons.mpris.paused
                }
            }),
        }),
    })

    const prev = Widget.Button({
        on_clicked: () => player.previous(),
        visible: player.bind("can_go_prev"),
        child: Widget.Icon(icons.mpris.prev),
    })

    const next = Widget.Button({
        on_clicked: () => player.next(),
        visible: player.bind("can_go_next"),
        child: Widget.Icon(icons.mpris.next),
    })

    return Widget.Box(
        { 
            class_name: "player",
            visible: player.bind("track_title")
        },
        img,
        Widget.Box(
            {
                vertical: true,
                hexpand: true,
            },
            Widget.Box([
                title,
                icon,
            ]),
            artist,
            Widget.Box({ vexpand: true }),
            positionSlider,
            Widget.CenterBox({
                start_widget: positionLabel,
                center_widget: Widget.Box([
                    prev,
                    playPause,
                    next,
                ]),
                end_widget: lengthLabel,
            }),
        ),
    )
}

export default Widget.Window({
    name: "media-widget",
    class_name: "media-widget",
    anchor: options.media.anchor.bind(),
    child: Widget.Box({
        vertical: true,
        class_name: 'box',
        visible: players.as(p => p.length > 0),
        children: players.as(p => p.map(Player)),
    }),
})
