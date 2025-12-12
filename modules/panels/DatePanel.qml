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

PanelBase {
    id: root
    body.height: contents.height
    body.width: 200

    Column {
        id: contents
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.leftMargin: Config.padding_large
        anchors.rightMargin: Config.padding_large
        spacing: Config.padding_large

        topPadding: Config.padding_large
        bottomPadding: (Config.visual.border.top / 2) - (lastElement.height / 2)

        ColumnLayout {
            anchors.left: parent.left
            anchors.right: parent.right
            StyledText {
                id: monthTitle
                text: "month"
                font.pixelSize: Config.visual.fontSize * 2
                anchors.horizontalCenter: parent.horizontalCenter
                bottomPadding: -20 // ??? idk why text is so weird but you get a HUGE gap without this
            }
            RowLayout {
                Repeater {
                    model: ["S", "M", "T", "O", "T", "F", "L"]
                    StyledText {
                        text: modelData
                        Layout.fillWidth: true
                        font.underline: true
                    }
                }
            }
            MonthGrid {
                id: month
                locale:("sv_SE")
                Layout.fillWidth: true

                delegate: StyledText {
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    text: model.day
                    color: model.today ? Colors.color6 : Colors.foreground
                    font.underline: model.today ? true : false

                    required property var model
                }
            }
        }

        Row {
            id: lastElement
            property int tabWidth: ((parent.width - clock.width) / 2) - Config.padding
            spacing: Config.padding
            anchors.horizontalCenter: parent.horizontalCenter

            TabBase {
                id: tab1
                anchors.verticalCenter: parent.verticalCenter
                width: parent.tabWidth
            }
            Clock {
                id: clock
                height: tab1.height
                y: - this.height * 2
            }
            TabBase {
                id: tab2
                anchors.verticalCenter: parent.verticalCenter
                width: parent.tabWidth
            }
        }
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
}
