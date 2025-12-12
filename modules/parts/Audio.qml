import Quickshell
import Quickshell.Io
import QtQuick
import Quickshell.Services.Pipewire
import qs.comp
import qs.utils

Item {
  id: root

  width: text.width
  height: text.height

  property real volumeRaw: AudioHandler.sink.audio.volume
  property int volume: Math.round(volumeRaw * 100)

  StyledText {
    id: text
    text: "   "+root.volume+"%"

    Item {
      anchors.fill: parent

      MouseArea{
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton

        onClicked: {
          switch (mouse.button) {
            case Qt.LeftButton:
              if (AudioHandler.sink.audio.muted) {
                AudioHandler.sink.audio.muted = false
              } else {
                AudioHandler.sink.audio.muted = true
              }
              break
            case Qt.RightButton:
              AudioHandler.toggleSource()
              break
          }
        }

        onWheel: (event)=> {
          if (event.angleDelta.y > 0) {
            AudioHandler.volUp(0.05)
          } else if (event.angleDelta.y < 0) {
            AudioHandler.volDown(0.05)
          }
        }
      }
    }
  }

  

  Connections {
    target: AudioHandler.sink.audio
    function onMutedChanged() {updateVolText()}
    function onVolumeChanged() {updateVolText()}
  }

  Connections {
    target: Pipewire
    function onDefaultAudioSinkChanged() {updateVolText()}
  }

  PwObjectTracker {
      objects: [...AudioHandler.sinks, ...AudioHandler.sources]
  }
    function updateVolText(): void {
        if (AudioHandler.sink.audio.muted) {
            text.text = ""
        } else {
            text.text = "   "+Math.round((AudioHandler.sink.audio.volume * 100))+"%"
        }
    }
}
