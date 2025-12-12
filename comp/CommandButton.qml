import QtQuick
import Quickshell.Io
import qs.config

Item {
    id: root
    width: 12
    height: 12

    property var command: ["echo", "hello world"]
    property int radius: this.width
    property color color_active: Colors.color6
    property color color_inactive: Colors.color1
    property color border_color_active: 'transparent'
    property color border_color_inactive: 'transparent'
    property int border_width: 3

    Rectangle {
        id: rect
        anchors.fill: parent
        radius: root.radius
        color: color_inactive
        border.color: root.border_color_inactive
        border.width: root.border_width
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true

        onEntered: {
            rect.color = color_active
            rect.border.color = border_color_active
        }

        onExited: {
            rect.color = color_inactive
            rect.border.color = border_color_inactive
        }

        onClicked: {
            proc.running = true
        }
    }

    Process {
        id: proc
        running: false
        command: root.command
        stdout: StdioCollector {
            onStreamFinished: console.log(`${this.text}`)
        }
    }
}
