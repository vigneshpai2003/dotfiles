const date = Variable('', {
    poll: [1000, 'date'],
})

const { speaker } = await Service.import("audio")
const slider = Widget.Slider({
    value: speaker.bind("volume"),
    onChange: ({ value }) => speaker.volume = value,
})
const Bar = (monitor) => Widget.Window({
    monitor,
    name: 'bar',
    anchor: ['top', 'left', 'right'],
    child: slider
})

App.config({
    windows: [
        Bar(0), // can be instantiated for each monitor
    ],
})

export {}