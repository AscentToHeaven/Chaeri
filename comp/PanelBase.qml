import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import Quickshell
import Quickshell.Io
import Quickshell.Services.Pipewire
import qs.config
import qs.comp
import qs.utils
import "../parts"
import QtQuick.Layouts

PanelWindow {
    id: root
    implicitHeight: body.height  + Config.padding_large
    implicitWidth: body.width  + Config.padding_large * 2
    // color: '#20ffffff'
    color: 'transparent'
    exclusionMode: ExclusionMode.Ignore

    default property alias content: body.data
    property alias rootAnchors: root.anchors
    property alias rootMargins: root.margins
    property alias root: root
    property alias body: body
    property int top_margin: displayMA.containsMouse ?
         0 :
         0 - (body.height - Config.visual.border.top)
    property int homeSize: 100

    anchors {
        top: true
    }

    margins {
        top: this.top_margin
    }

    MouseArea {
        id: displayMA
        anchors.fill: body
        hoverEnabled: true
        acceptedButtons: Qt.NoButton
        z: 10
    }

    RectangularShadow {
        id: shadow
        anchors.fill: body
        radius: Config.visual.rounding.amount_small
        spread:
            displayMA.containsMouse ?
                3 :
                -6

        Behavior on spread {
            NumberAnimation {
                duration: Config.anim
            }
        }
    }

    StyledRectangle {
        id: body
        radius: 0
        bottomRightRadius: Config.visual.rounding.amount_small
        bottomLeftRadius: Config.visual.rounding.amount_small
        border.width: 0
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Connections {
        target: AudioHander.sink.audio
    }

    Connections {
        target: Pipewire
    }

    Process {
        command: ["date", '+%B']
        running: true

        stdout: StdioCollector {
            onStreamFinished: monthTitle.text = this.text
        }
    }

    Timer { //updates time ever second
        interval: 3600000
        running: true
        repeat: true
        onTriggered: proc.running = true
    }

    Behavior on top_margin {
        NumberAnimation {
            duration: Config.anim
        }
    }
}
