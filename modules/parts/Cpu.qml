import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import qs.comp

Item {
  id: root

  implicitWidth: cpu.width
  implicitHeight: cpu.height

  property real cpuPerc 
  property real lastCpuIdle
  property real lastCpuTotal

  StyledText {
    id: cpu
    anchors.centerIn: parent

    text: "󰍛 0%"

    Timer {
      interval: 1000
      running: true
      repeat: true
      onTriggered: {
        stats.reload();
        // cpu.text = root.cpuPerc
        cpu.text = "󰍛 "+Math.round((root.cpuPerc * 100))+"%";
      }
    }

    FileView {
      id: stats

      path: "/proc/stat"

      onLoaded: {
        const data = text().match(/^cpu\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)/);

        if (data) {
                const stats = data.slice(1).map(n => parseInt(n, 10));
                const total = stats.reduce((a, b) => a + b, 0);
                const idle = stats[3] + (stats[4] ?? 0); 

                const totalDiff = total - root.lastCpuTotal;
                const idleDiff = idle - root.lastCpuIdle;
                root.cpuPerc = totalDiff > 0 ? (1 - idleDiff / totalDiff) : 0;

                root.lastCpuTotal = total;
                root.lastCpuIdle = idle;
        }
      }
    }
  }
}
