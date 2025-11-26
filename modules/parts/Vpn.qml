import Quickshell
import Quickshell.Io // for Process
import QtQuick
import QtQuick.Layouts

Rectangle {
  id: root

  implicitWidth: vpn.width
  implicitHeight: vpn.height
  color: "transparent"
  property bool toggle: true

  Text {
    id: vpn
    anchors.centerIn: parent

    color: WalTheme.color1
    font.pixelSize: Conf.option.fontSize
    font.bold: Conf.option.fontBold

    text: "loading.."

    Process {
      id: vpnProc
      command: root.toggle ? ["/home/kena/scripts/qs/vpn.sh"] : ["/home/kena/scripts/qs/vpn.sh","-f"]
      running: true

      stdout: StdioCollector {
        onStreamFinished: vpn.text = text
      }
    }

    Timer {
      interval: 60000
      running: true
      repeat: true
      onTriggered: vpnProc.running = true
    }

  }
    MouseArea {
      anchors.fill: parent
      onClicked: {
        root.toggle = !root.toggle
        vpnProc.running = true
      }

      hoverEnabled: true
      onEntered: vpn.color = Theme.color6
      onExited: vpn.color = Theme.color1
    }
}
