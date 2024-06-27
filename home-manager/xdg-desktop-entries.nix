{ config, ... }:
{
  xdg.desktopEntries = {
    # - Hide these desktop entries
    htop = {
      name = "htop";
      noDisplay = true;
    };

    btop = {
      name = "btop++";
      noDisplay = true;
    };

    "org.gnome.Nautilus" = {
      name = "Files";
      noDisplay = true;
    };

    # - Enable Video Decode and Touchpad Gestures
    brave-browser = {
      name = "Brave Web Browser";
      genericName = "Web Browser";
      exec = "brave %U --enable-features=VaapiVideoDecodeLinuxGL,TouchpadOverscrollHistoryNavigation";
      startupNotify = true;
      terminal = false;
      icon = "brave-browser";
      type = "Application";
      categories = [ "Network" "WebBrowser" ];
      mimeType = [
        "application/pdf"
        "application/rdf+xml"
        "application/rss+xml"
        "application/xhtml+xml"
        "application/xhtml_xml"
        "application/xml"
        "image/gif"
        "image/jpeg"
        "image/png"
        "image/webp"
        "text/html"
        "text/xml"
        "x-scheme-handler/http"
        "x-scheme-handler/https"
        "x-scheme-handler/ipfs"
        "x-scheme-handler/ipns"
      ];
    };
  };
}
