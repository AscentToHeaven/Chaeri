import QtQuick
import Quickshell.Io
import qs.config
import qs.comp
import qs.utils

Item {
    id: diskRoot
    anchors.left: parent.left
    anchors.right: parent.right
    height: diskBackground.height

    readonly property int setHeight: Config.visual.fontSize * 1.5
    property int diskSize: 0
    property string diskName: "unknown"

    Rectangle {
        id: diskBackground
        anchors.left: parent.left
        anchors.right: parent.right
        height: diskRoot.setHeight
        radius: Config.visual.rounding.amount
        color: Colors.color8
    }
    Rectangle {
        id: diskForeground
        anchors.left: parent.left
        height: diskRoot.setHeight
        width: diskBackground.width * (diskRoot.diskSize / 100)
        radius: Config.visual.rounding.amount
        color: Colors.color4
    }
    StyledText {
        property bool delim: (diskForeground.width > (Config.padding + diskTitle.width + this.width))
        anchors.verticalCenter: parent.verticalCenter
        text: diskRoot.diskSize+"%"
        font.pixelSize: diskRoot.setHeight - 2
        color: this.delim ? Colors.foreground : Colors.color0
        x: this.delim ? diskForeground.width - (this.width + Config.padding_small) : diskForeground.width + Config.padding_small
	}
    StyledText {
        id: diskTitle 
        anchors.verticalCenter: parent.verticalCenter
        leftPadding: Config.padding
        color: Colors.foreground
        text: (diskRoot.diskName == "root") ? "/" : "/" + diskRoot.diskName
    }

    Process {
        id: diskProc
        running: true
        command: [`${Paths.strip(Paths.config)}/scripts/storage.sh`, `${diskRoot.diskName}`]

        stdout: StdioCollector {
            onStreamFinished: diskRoot.diskSize = text
        }
    }

    Timer {
        interval: 5000
        running: true
        repeat: true
        onTriggered: diskProc.running = true
    }
}
