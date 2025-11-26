import QtQuick
import Quickshell
import Quickshell.Wayland

PanelWindow {
  WlrLayershell.layer: WlrLayer.Top

  anchors {
    top: true
    bottom: true
    left:true
    right: true
  }

  Border {}

  mask: Region { // this mask enabled click through
      item: null
  }
  color: 'transparent'
}
