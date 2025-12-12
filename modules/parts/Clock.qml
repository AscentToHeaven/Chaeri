import Quickshell.Io
import QtQuick
import qs.config
import qs.comp

Item {
  id: root

  implicitWidth: clock.width
  implicitHeight: clock.height

  StyledText {
    id: clock
    text: "00:00" //00:00 is placeholder
  }

  Process {
    id: proc
    command: Config.general.showDate ? ["date","+%d %B %Y"] : ["date","+%H:%M"] //if true, shows date, if false shows time instead
    running: true

    stdout: StdioCollector {
      onStreamFinished: clock.text = text
    }
  }

  Timer { //updates time ever second
    interval: 1000
    running: true
    repeat: true
    onTriggered: proc.running = true
  }

  MouseArea {
    anchors.fill: parent
    onClicked: {Config.general.showDate = !Config.general.showDate; proc.running = true} //when pressed, swaps time for date
  }
}
