import Quickshell.Io
import qs.utils

JsonObject {
    property Apps apps: Apps {}

    component Apps: JsonObject {
        property list<string> terminal: ["kitty"]
        property list<string> audio: ["pavucontrol"]
    }

    property bool showDate: false
}
