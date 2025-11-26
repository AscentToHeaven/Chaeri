import QtQuick
import Quickshell
import Quickshell.Hyprland
import qs.config
import qs.comp

Item {

  width: rootRow.implicitWidth + magic.width
  height: rootRow.implicitHeight
  // anchors.fill: parent
  
  readonly property var spaces: Hyprland.workspaces.values.reduce((acc, space) => {
    // console.log(space)
    acc.push(space);
    return acc;
  }, [] )

  Row {
    id: rootRow
    anchors.fill: parent
    spacing: 3

    Repeater {
      model: spaces.length
      anchors.fill: parent

      delegate: Rectangle {
        id: rect
        width: spaces[index].active ? (this.height * 2.5) : this.height
        height: Config.visual.fontSize
        radius: Config.visual.rounding.amount
        color: spaces[index].active ? Colors.color6 : Colors.color1
        visible: spaces[index].id >= 1 ? true : false

        Behavior on width {
          NumberAnimation {
            duration: Config.anim_workspaces
          }
        }

        Behavior on color {
          ColorAnimation {
            duration: Config.anim_workspaces
          }
        }

        MouseArea {
          anchors.fill: parent
          onClicked: spaces[index].activate()
          hoverEnabled: true
        }
      }
    }
  }

  CommandButton {
    id: magic
    radius: 0
    color_active: 'transparent'
    color_inactive: 'transparent'
    border_color_active: Colors.color6
    border_color_inactive: Colors.color1
    x: rootRow.width
    rotation: 45
    command: ["hyprctl", "dispatch", "togglespecialworkspace", "magic"]
  }
}
