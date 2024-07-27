/* eslint-disable max-len */
import { type Opt } from "lib/option"
import options from "options"
import { bash } from "lib/utils"
import colors from "./colors"

const deps = [
    "font",
    "theme",
    "bar.corners",
    "bar.flatButtons",
    "bar.position",
    "bar.battery.charging",
    "bar.battery.blocks",
]

const {
    padding,
    spacing,
    radius,
    shadows,
    border,
} = options.theme

const popoverPaddingMultiplier = 1.6

const $ = (name: string, value: string | Opt<any>) => `$${name}: ${value};`

const colorsToVariables = (scheme: string) => Object.entries(colors[scheme]).map(x => $(...x))

const variables = () => [
    ...colorsToVariables("frappe"),

    $("padding", `${padding}pt`),
    $("spacing", `${spacing}pt`),
    $("radius", `${radius}px`),
    $("transition", `${options.transition}ms`),

    $("shadows", `${shadows}`),

    $("border-width", `${border.width}px`),
    $("border-color", `transparentize(black, ${border.opacity.value / 100})`),
    $("border", "$border-width solid $border-color"),

    $("shadow-color", "rgba(0,0,0,.6)"),
    $("text-shadow", "2pt 2pt 2pt $shadow-color"),
    $("box-shadow", "2pt 2pt 2pt 0 $shadow-color, inset 0 0 0 $border-width $border-color"),

    $("popover-padding", `$padding * ${popoverPaddingMultiplier}`),
    $("popover-radius", radius.value === 0 ? "0" : "$radius + $popover-padding"),
]

async function resetCss() {
    try {
        const vars = `${TMP}/variables.scss`
        const scss = `${TMP}/main.scss`
        const css = `${TMP}/main.css`

        const fd = await bash(`fd ".scss" ${App.configDir}`)
        const files = fd.split(/\s+/)
        const imports = [vars, ...files].map(f => `@import '${f}';`)

        await Utils.writeFile(variables().join("\n"), vars)
        await Utils.writeFile(imports.join("\n"), scss)
        await bash`sass ${scss} ${css}`

        App.applyCss(css, true)
    } catch (error) {
        error instanceof Error
            ? logError(error)
            : console.error(error)
    }
}

Utils.monitorFile(`${App.configDir}/style`, resetCss)
options.handler(deps, resetCss)
await resetCss()
