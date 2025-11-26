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
    implicitWidth: 420
    implicitHeight: contents.implicitHeight  + (Config.padding_large) + 10 
    // color: '#20ffffff'
    color: 'transparent'

    exclusionMode: ExclusionMode.Ignore

    readonly property int top_margin: - this.height + Config.visual.border.top + body.anchors.bottomMargin
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

        onEntered: {
            root.margins.top = 0
            shadow_on.running = true
        }

        onExited: {
            root.margins.top = root.top_margin
            shadow_off.running = true
        }
    }

    RectangularShadow {
        id: shadow
        anchors.fill: body
        radius: Config.visual.rounding.amount_small
        spread: -6
    }

    StyledRectangle {
        id: body
        anchors {
            fill: parent
            leftMargin: 10
            rightMargin: 10
            bottomMargin: 10
        }
        radius: 0
        bottomRightRadius: Config.visual.rounding.amount_small
        bottomLeftRadius: Config.visual.rounding.amount_small
        border.width: 0

        Column {
            id: contents
            anchors.fill: parent
            anchors.topMargin: Config.padding_large
            anchors.leftMargin: Config.padding_large
            anchors.rightMargin: Config.padding_large
            bottomPadding: (Config.visual.border.top - clock.height) / 2
            spacing: Config.padding_large

            GridLayout {
                anchors.left: parent.left
                anchors.right: parent.right
                columns: 1
                StyledText {
                    id: monthTitle
                    text: "month"
                    font.pixelSize: Config.visual.fontSize * 2
                    font.underline: true
                    anchors.horizontalCenter: parent.horizontalCenter
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
                property color tabColor: Colors.color8
                property int tabHeight: Config.visual.fontSize * 0.3
                property int tabWidth: ((parent.width / 2)  - (clock.width / 2) - Config.padding) / 3
                spacing: Config.padding
                anchors.horizontalCenter: parent.horizontalCenter

                Rectangle {
                    id: tab1
                    anchors.verticalCenter: parent.verticalCenter
                    color: parent.tabColor
                    width: parent.tabWidth
                    height: parent.tabHeight
                    radius: this.height
                }
                Clock {
                    id: clock
                }
                Rectangle {
                    id: tab2
                    anchors.verticalCenter: parent.verticalCenter
                    color: parent.tabColor
                    width: parent.tabWidth
                    height: parent.tabHeight
                    radius: this.height
                }
            }
        }
    }

    NumberAnimation {
        id: shadow_off
        target: shadow
        property: "spread"
        duration: Config.anim * 2
        from: 3
        to: -6
    }

    NumberAnimation {
        id: shadow_on
        target: shadow
        property: "spread"
        duration: Config.anim * 2
        from: -6
        to: 3
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
