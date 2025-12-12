import QtQuick
import Quickshell.Io
import qs.comp
import qs.config

PanelBaseRight {
    id: main
    body.height: 75
    body.width: contents.width

    root.anchors.top: true
    root.margins.top: 150

    Row {
        id: contents
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.margins: Config.padding_large
        spacing: Config.padding_large
        rightPadding: Config.padding_large
        leftPadding: Config.padding_large

        Repeater {
            model: [
                ["", [["hyprctl", "dispatch", "exit"],[""]]],
                ["", [["systemctl", "poweroff"]],[""]],
                ["", [["systemctl", "reboot"], ["systemctl", "soft-reboot"]]],
                ["", [["systemctl", "suspend"], ["systemctl", "hibernate"]]]
            ]
            StyledText {
                text: modelData[0]
                font.pixelSize: parent.height
                anchors.verticalCenter: parent.verticalCenter

                MouseArea {
                    anchors.fill: parent
                    acceptedButtons: Qt.LeftButton | Qt.RightButton
                    onClicked: {
                        proc.command = (mouse.button == Qt.LeftButton) ? modelData[1][0] : modelData[1][1]
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

	IpcHandler {
	    target: "PowerMenu"

	    function toggle(): void {
	        main.root.visibleOverride = !main.root.visibleOverride;
    	}
	}

}
