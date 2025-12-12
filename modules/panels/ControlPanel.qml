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

PanelBase {
    id: root
    body.height: contents.height
    body.width: 200

    rootAnchors {
        right: true
    }
    rootMargins {
        right: 200
    }

    Column {
        id: contents
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.leftMargin: Config.padding_large
        anchors.rightMargin: Config.padding_large
        spacing: Config.padding_large

        topPadding: Config.padding_large
        bottomPadding: (Config.visual.border.top / 2) - (lastElement.height / 2)

        Column {
            height: volumeText.height + volumeSlider.height
            anchors.left: parent.left
            anchors.right: parent.right
            StyledText {
                id: volumeText
                text: "Volume"
            }

            StyledSlider {
                id: volumeSlider
                from: 0
                to: 100
                value: AudioHandler.sink.audio.volume*100
                onMoved: AudioHandler.setVol(value/100)
                implicitWidth: parent.width
            }
        }

        StyledText {
            text: "Disks:"
            bottomPadding: - Config.padding
        }
        Repeater {
            model: Config.general.disks
            Disk {
                diskName: modelData
            }
        }
        Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter
            width: sysTray.width + Config.padding_small * 2
            height: sysTray.height + Config.padding_small * 2
            radius: Config.visual.rounding.amount
            color: Colors.color8

            SysTray {
                id: sysTray
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        TabBase {
            id:lastElement
        }
    }
}
