import QtQuick
import qs.config

Text {
  id: root
  color: hoverOn ?
      ma.containsMouse ? Colors.color8 : Colors.color3
          : Colors.color3

  property bool hoverOn: false

  font {
    family: "Helvetica"
    pointSize: Config.visual.fontSize
    italic: Config.visual.fontItalic
    bold: Config.visual.fontBold
  } 

  Behavior on color {
    ColorAnimation {
      duration: Config.anim
    }
  }
}
