import Quickshell
import QtQuick
import "../parts"
import qs.config

Row {
  id: root

  anchors.horizontalCenter: parent.horizontalCenter
  anchors.verticalCenter: parent.verticalCenter
  spacing: Config.padding_small

  property color tabColor: Colors.color8
  property int tabHeight: 4
}
