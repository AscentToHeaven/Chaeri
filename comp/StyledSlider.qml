import QtQuick
import QtQuick.Controls
import qs.config

Slider {
    id: root

    implicitWidth: 200
    implicitHeight: 4

	handle: Rectangle {
	    id: handle
        x: root.leftPadding + root.visualPosition * (root.availableWidth - width)
        y: root.topPadding + root.availableHeight / 2 - height / 2
        implicitWidth: Config.visual.fontSize * 1.4
        implicitHeight: Config.visual.fontSize * 1.4
        radius: this.width
        color: root.pressed ? Colors.color6 : Colors.color4
	}

	background: Rectangle {
        x: root.leftPadding
        y: root.topPadding + root.availableHeight / 2 - height / 2
        implicitWidth: root.implicitWidth
        implicitHeight: root.implicitHeight
        width: root.availableWidth
        height: implicitHeight
        radius: this.height
        color: Colors.color8

        Rectangle {
            width: root.visualPosition * parent.width
            height: parent.height
            color: Colors.color1
            radius: parent.radius
        }
	}
}
