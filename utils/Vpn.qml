pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root
    property bool connected: false
    property string status: ""

    Process {
        id: proc
        command: [`${Paths.strip(Paths.config)}/scripts/vpn.sh`]
        running: true

        stdout: StdioCollector {
            onStreamFinished: root.status = this.text
        }
    }

    Timer {
        interval: 60000
        running: true
        repeat: true
        onTriggered: proc.running = true
    }
}
