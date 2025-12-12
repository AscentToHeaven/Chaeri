import Quickshell
import QtQuick
import Quickshell.Wayland

import qs.config
import qs.comp
import qs.comp

PanelWindow {
  exclusionMode: ExclusionMode.Ignore

  color: 'transparent'

  anchors {
    left: true
    right: true
    top: true
  }

  implicitHeight: Config.visual.border.top

  BarLeft {}
  BarMiddle {}
  BarRight {}
}
