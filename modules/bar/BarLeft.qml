import QtQuick
import Quickshell
import qs.config
import "../parts"
import qs.comp

Item {
    width: workspaces.implicitWidth
    height: workspaces.implicitHeight

    anchors {
        fill: parent
        leftMargin: Config.padding_large
        topMargin: Config.padding
    }

    Workspaces {
        id: workspaces
    }
}
