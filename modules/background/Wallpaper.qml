import QtQuick
import Quickshell
import qs.config

Loader {
  sourceComponent: Image {
    id: imageRoot
    source: Config.visual.wallpaper

    sourceSize {
      width: 1920
      height: 1080
    }
  }
}

