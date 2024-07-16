const { query } = await Service.import("applications")
const WINDOW_NAME = "applauncher"

const AppItem = app => Widget.Button({
    on_clicked: () => {
        App.closeWindow(WINDOW_NAME)
        app.launch()
    },
    attribute: { app },
    child: Widget.Box({
        children: [
            Widget.Icon({
                icon: app.icon_name || "",
                size: 42,
            }),
            Widget.Label({
                class_name: "title",
                label: app.name,
                xalign: 0,
                vpack: "center",
                truncate: "end",
            }),
        ],
    }),
})

const LibraryLauncher = ({ width = 500, height = 500, spacing = 12 }) => {
    const searchDir = "/home/vignesh/Documents"
    const paths = Utils.exec(`bash -c "find ${searchDir} -type f -not -path '*/\.git*' -not -path '*/\.config*' | grep -E '.pdf|.djvu' | sed 's|${searchDir}/||g'"`).split("\n")
    
    const library = paths.map(path => {
        let title = path.split("/").pop()
        let author = ""

        const decomp = title.split("_ ")
        if (decomp.length == 2) {
            [author, title] = decomp
        }

        return { title: title, path: path }
    })

    let items = library.map(book => Object.assign(
        Widget.Box({
            children: [
                Widget.Icon({
                    icon: "document",
                    size: 42,
                }),
                Widget.Box({
                    vertical: true,
                    children: [
                        Widget.Label({
                            label: book.title,
                            xalign: 0,
                            vpack: "center",
                            truncate: "end",
                        }),
                        Widget.Label({
                            label: book.path,
                            xalign: 0,
                            vpack: "center",
                            truncate: "end",
                        }),
                    ]
                })
            ],
        }),
        {
            book: book,
        }
    ))

    const list = Widget.Box({
        vertical: true,
        children: items,
    })

    const entry = Widget.Entry({
        hexpand: true,
        css: `margin-bottom: ${spacing}px;`,

        on_accept: () => {
	        const results = items.filter((item) => item.visible);
            if (results[0]) {
                App.toggleWindow(WINDOW_NAME)
                print(results[0].book.path)
            }
        },

        on_change: ({ text }) => items.forEach(item => {
            item.visible = item.book.path.toLowerCase().match(text.toLowerCase() ?? "")
        }),
    })

    return Widget.Box({
        vertical: true,
        css: `margin: ${spacing * 2}px;`,
        children: [
            entry,
            Widget.Scrollable({
                hscroll: "never",
                css: `min-width: ${width}px;`
                    + `min-height: ${height}px;`,
                child: list,
            }),
        ],
        setup: self => self.hook(App, (_, windowName, visible) => {
            if (windowName !== WINDOW_NAME)
                return

            if (visible) {
                entry.text = ""
                entry.grab_focus()
            }
        }),
    })
}

const AppLauncher = ({ width = 500, height = 500, spacing = 12 }) => {
    // list of application buttons
    let applications = query("").map(AppItem)

    // container holding the buttons
    const list = Widget.Box({
        vertical: true,
        children: applications,
        spacing,
    })

    // repopulate the box, so the most frequent apps are on top of the list
    function repopulate() {
        applications = query("").map(AppItem)
        list.children = applications
    }

    // search entry
    const entry = Widget.Entry({
        hexpand: true,
        css: `margin-bottom: ${spacing}px;`,

        // to launch the first item on Enter
        on_accept: () => {
            // make sure we only consider visible (searched for) applications
	    const results = applications.filter((item) => item.visible);
            if (results[0]) {
                App.toggleWindow(WINDOW_NAME)
                results[0].attribute.app.launch()
            }
        },

        // filter out the list
        on_change: ({ text }) => applications.forEach(item => {
            item.visible = item.attribute.app.match(text ?? "")
        }),
    })

    return Widget.Box({
        vertical: true,
        css: `margin: ${spacing * 2}px;`,
        children: [
            entry,

            // wrap the list in a scrollable
            Widget.Scrollable({
                hscroll: "never",
                css: `min-width: ${width}px;`
                    + `min-height: ${height}px;`,
                child: list,
            }),
        ],
        setup: self => self.hook(App, (_, windowName, visible) => {
            if (windowName !== WINDOW_NAME)
                return

            // when the applauncher shows up
            if (visible) {
                repopulate()
                entry.text = ""
                entry.grab_focus()
            }
        }),
    })
}

// there needs to be only one instance
const applauncher = Widget.Window({
    name: WINDOW_NAME,
    setup: self => self.keybind("Escape", () => {
        App.closeWindow(WINDOW_NAME)
    }),
    // visible: false,
    keymode: "exclusive",
    child: AppLauncher({
        width: 500,
        height: 500,
        spacing: 12,
    }),
})

App.config({
    windows: [applauncher],
})