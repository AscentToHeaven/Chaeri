import QtQuick
import qs.config

Text {
  id: root
  color: Colors.color3

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
