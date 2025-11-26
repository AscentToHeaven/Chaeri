pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import QtQuick.Effects
import Qt5Compat.GraphicalEffects
import qs.config

Item {
  id: root

  anchors.fill: parent

  Rectangle {
    id: rect
    anchors.fill: parent

    layer.enabled: true
    layer.effect: MultiEffect { // this rect covers the entire screen and the 'mask' cuts a hole through it
      maskEnabled: true
      maskInverted: true
      maskSource: mask
      maskThresholdMin: 0.5 // these 2 fix the aliasing issue
      maskSpreadAtMin: 1
    }

    color: Colors.background
  }

  Item {
    id: mask

    anchors.fill: parent
    layer.enabled: true
    visible: false

    Rectangle {
      id: maskRect
      anchors.fill: parent
      anchors.topMargin: Config.visual.border.top
      anchors.rightMargin: Config.visual.border.right
      anchors.bottomMargin: Config.visual.border.bottom
      anchors.leftMargin: Config.visual.border.left

      radius: { //if rounding is dissabled, this sets it to 0
        if (Config.visual.rounding.enabled) {
          Config.visual.rounding.amount
        } else {0}
      }
    }
  }
}
