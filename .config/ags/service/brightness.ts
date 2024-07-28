import { bash, sh } from "lib/utils"

const get = (args: string) => Number(Utils.exec(`brightnessctl ${args}`))
const screen = await bash`ls -w1 /sys/class/backlight | head -1`
const kbd = await bash`ls -w1 /sys/class/leds | head -1`

class Brightness extends Service {
    static {
        Service.register(this, {}, {
            "screen": ["float", "rw"],
            "kbd": ["int", "rw"],
        })
    }

    #kbdMax = get(`--device ${kbd} max`)
    #kbd = get(`--device ${kbd} get`) / this.#kbdMax
    #screenMax = get("max")
    #screen = get("get") / (get("max") || 1)

    get kbd() { return this.#kbd }
    get screen() { return this.#screen }

    set kbd(value) {
        if (value < 0 || value > this.#kbdMax)
            return

        sh(`brightnessctl -d ${kbd} s ${value} -q`).then(() => {
            this.#kbd = value
            this.changed("kbd")
        })
    }

    set screen(percent) {
        if (percent < 0)
            percent = 0

        if (percent > 1)
            percent = 1

        sh(`brightnessctl set ${Math.floor(percent * 100)}% -q`).then(() => {
            this.#screen = percent
            this.changed("screen")
        })
    }

    constructor() {
        super()

        const screenPath = `/sys/class/backlight/${screen}/brightness`
        const kbdPath = `/sys/class/leds/${kbd}/brightness`

        Utils.monitorFile(screenPath, async f => {
            const v = await Utils.readFileAsync(f)
            this.#screen = Number(v) / this.#screenMax
            this.changed("screen")
        })

        // kbdPath cannot be monitered by Gio, so we have to poll it
        // triggering from a keybind is not possible since on my current hardware, the kbd brightness key has no keycode
        Utils.interval(250, async () => {
            const v = Number(await Utils.readFileAsync(kbdPath)) / this.#kbdMax
            if (v !== this.#kbd) {
                this.#kbd = v
                this.changed("kbd")
            }
        })
    }
}

export default new Brightness
