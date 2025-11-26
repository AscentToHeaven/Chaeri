import QtQuick
import Quickshell

import "modules/background"
import "modules/border"
import "modules/bar"
import "modules/panels"

ShellRoot {
  Panels {}
  Background {}
  BarMain {}

  ControlPanel {}
  DatePanel {}
  PowerPanel {}
}
