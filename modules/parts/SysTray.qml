import Quickshell.Services.SystemTray
import Quickshell.Widgets
import QtQuick
import qs.config

Item {
  id: root

  readonly property var tray: SystemTray.items.values.reduce((acc, icon) => {
    acc.push(icon);
    return acc;
  }, [] )

  width: rootRow.implicitWidth
  height: Config.visual.fontSize *2

  Row {
    id: rootRow
    spacing: 5
    anchors.fill: parent

    Repeater {
      model: SystemTray.items
      anchors.fill: parent

      delegate: IconImage {
        source: tray[index].icon
        implicitSize: Config.visual.fontSize *2

        MouseArea{
          anchors.fill: parent

          onClicked: event => {
            if (event.button == Qt.LeftButton) {
              modelData.activate()
            } else if (event.button == Qt.RightButton) {
              modelData.display(parent, 0, 0)
            }
          }
        }
      }
    }
  }
}
