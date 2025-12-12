import QtQuick
import QtQuick.Controls
import Quickshell
import qs.utils
import qs.comp
import qs.config


PanelWindow {
    focusable: true
    implicitWidth: 400
    implicitHeight: col.implicitHeight > 200 ? col.height : 200

    property var entries: search.text === ""  ? [] : searcher.query(search.text)

    StyledRectangle {
        id: body
        anchors.fill: parent
        anchors.leftMargin: Config.padding_large
        anchors.rightMargin: Config.padding_large
        anchors.topMargin: Config.padding_large
        anchors.bottomMargin: Config.padding_large

        Column {
            id: col
            TextField {
                id: search
                anchors.left: body.left
                anchors.right: body.right
                Keys.onPressed: {
                    if (event.key === Qt.Key_Return) {
                        console.log(entries[0].name)
                        entries[0].execute()
                    }
                }
            }
        	Repeater {
        	    model: entries
        	    StyledText {
        	        text: modelData.name
        	        anchors.horizontalCenter: parent.horizontalCenter

        	        MouseArea {
        	            anchors.fill: parent
        	            onClicked: modelData.execute()
        	        }
        	    }
        	}
    	}
	}

	Searcher {
	    id: searcher
	    list: DesktopEntries.applications.values
	}
}
