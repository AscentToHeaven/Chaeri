import QtQuick
import Quickshell
import Quickshell.Wayland

PanelWindow {
  WlrLayershell.layer: WlrLayer.Background

  anchors {
    top: true
    bottom: true
    left:true
    right: true
  }

  Wallpaper {}

  color: 'transparent'
}
