import QtQuick
import Quickshell
import qs.config
import "modules/background"
import "modules/border"
import "modules/bar"
import "modules/panels"

ShellRoot {
  Panels {}
  BarMain {}

  ControlPanel {}
  DatePanel {}
  PowerPanel {}
  // CmdsPanel {}

  WallpaperIPC {}
  // MenuPanel {}
}
