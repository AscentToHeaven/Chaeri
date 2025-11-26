import Quickshell
import QtQuick
import "../parts"
import qs.config

Item {
  id: root

  anchors.top: parent.top
  anchors.right: parent.right
  anchors.rightMargin: Config.visual.border.right
  anchors.bottom: parent.bottom

  implicitWidth: parent.width / 2

  Row {
    anchors.top: parent.top
    anchors.right: parent.right
    anchors.rightMargin: Config.padding_large
    anchors.topMargin: Config.padding_small
    spacing: Config.padding

    Cpu {
      anchors.verticalCenter: parent.verticalCenter
    }

    Audio {
      anchors.verticalCenter: parent.verticalCenter
    }
  }

}
