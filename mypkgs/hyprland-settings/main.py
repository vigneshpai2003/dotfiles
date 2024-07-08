import gi

gi.require_version("Gtk", "4.0")
from gi.repository import Gtk, GLib


class MyWindow(Gtk.Window):
    def __init__(self):
        super().__init__(title="Main Window")
        self.set_default_size(400, 300)

        # Create a button to show the shortcuts window
        button = Gtk.Button(label="Show Shortcuts")
        button.connect("clicked", self.on_button_clicked)
        self.set_child(button)

    def on_button_clicked(self, widget):
        shortcuts_window = Gtk.ShortcutsWindow()
        shortcuts_window.set_modal(True)
        shortcuts_window.set_transient_for(self)

        section = Gtk.ShortcutsSection(
            title="Wofi", section_name="wofi"
        )

        shortcuts = [
            ("<Super>n", "Show notification history."),
            ("<Super>b", "Browse library."),
            ("<Super>v", "Clipboard history."),
        ]

        for keys, description in shortcuts:
            shortcut = Gtk.ShortcutsShortcut(accelerator=keys, title=description)
            section.append(shortcut)

        shortcuts_window.add_section(section)
        shortcuts_window.present()


def main():
    win = MyWindow()
    win.connect("destroy", Gtk.Window.destroy)
    win.show()

    loop = GLib.MainLoop()
    loop.run()


if __name__ == "__main__":
    main()
