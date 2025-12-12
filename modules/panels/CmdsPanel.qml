import QtQuick
import Quickshell.Io
import qs.comp
import qs.config

PanelBaseRight {
    id: main
    body.height: contents.height
    body.width: contents.width

    root.anchors.top: true
    root.margins.top: 300

    Column {
        id: contents
        anchors.margins: Config.padding_large
        spacing: Config.padding_large
        topPadding: Config.padding_large
        bottomPadding: Config.padding_large
        rightPadding: Config.padding_large
        leftPadding: Config.padding_large

        StyledText {
            text: "Quick Commands:"
        }

        Repeater {
            model: Config.titles
            StyledText {
                text: "  " + modelData
                hoverOn: true

                MouseArea {
                    id: ma
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        proc.command = Config.commands[index]
                        proc.running = true
                    }
                }
            }
        }
    }

    Process {
        id: proc
        running: false
        command: modelData[1]
    }
}
