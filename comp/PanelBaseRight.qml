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
    implicitHeight: body.height  + Config.padding_large * 2
    implicitWidth: body.width  + Config.padding_large
    // color: '#20ffffff'
    color: 'transparent'
    exclusionMode: ExclusionMode.Ignore

    default property alias content: body.data
    property bool visibleOverride: false
    property alias root: root
    property alias body: body
    property int margin_visible: 0 - (body.width - Config.visual.border.right)
    property int right_margin: this.visibleOverride ?
        0-1 :
        displayMA.containsMouse ?
            0 -1 : 
            this.margin_visible -2

    property int homeSize: 100

    anchors {
        right: true
    }

    margins {
        right: this.right_margin
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
        spread: root.visibleOverride ?
            3 :
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
        topLeftRadius: Config.visual.rounding.amount_small
        bottomLeftRadius: Config.visual.rounding.amount_small
        border.width: 0
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
    }

    Connections {
        target: AudioHander.sink.audio
    }

    Connections {
        target: Pipewire
    }

    Behavior on right_margin {
        NumberAnimation {
            duration: Config.anim
        }
    }
}
