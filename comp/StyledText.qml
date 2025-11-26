import QtQuick
import qs.config

Text {
  id: root
  color: ma.containsMouse ? Colors.color6 : Colors.color3

  font {
    family: "Helvetica"
    pointSize: Config.visual.fontSize
    italic: Config.visual.fontItalic
    bold: Config.visual.fontBold
  } 

  MouseArea {
    id: ma
    anchors.fill: parent
    hoverEnabled: true
  }

  Behavior on color {
    ColorAnimation {
      duration: Config.anim
    }
  }
}
