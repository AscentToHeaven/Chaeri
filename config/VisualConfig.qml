import Quickshell.Io
import qs.utils

JsonObject {
    property Rounding rounding: Rounding {}
    property Border border: Border {}

    component Rounding: JsonObject {
        property bool enabled: true 
        property int amount: 25
        property int amount_small: 15
    }

    component Border: JsonObject {
        property int top: 30
        property int right: 10
        property int bottom: 10
        property int left: 10
    }

    // property string wallpaper:`${Paths.strip(Paths.profile)}/wallpaper.png`
    property string wallpaper:``
    property bool wallpaperToggle: true

    property int fontSize: 12
    property bool fontItalic: false
    property bool fontBold: true
}
