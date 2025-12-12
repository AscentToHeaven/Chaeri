import Quickshell
import Quickshell.Io // for Process
import QtQuick
import QtQuick.Layouts

Item {
  id: root

  property real memTotal
  property real memAvailable
  property real memPerc

  implicitWidth: mem.width
  implicitHeight: mem.height


  StyledText {
    id: mem
    anchors.centerIn: parent

    text: "󰘚 0%";

    Timer {
      interval: 1000
      running: true
      repeat: true
      onTriggered: {
        stats.reload();
        mem.text = "󰘚 " + root.memPerc + "%";
      }
    }

    FileView {
      id: stats

      path: "/proc/meminfo"

      onLoaded: {
        const data = text();

        root.memTotal = parseInt(data.match(/MemTotal: *(\d+)/)[1], 10) || 1;
        root.memAvailable = parseInt(data.match(/MemAvailable: *(\d+)/)[1], 10) || 0;
        root.memPerc = Math.round(((1 - (root.memAvailable / root.memTotal)) * 100))
      }
    }
  }
}
