pragma Singleton
import Quickshell
import Quickshell.Io
import qs.utils

Singleton {

  property alias color0: adapter.color0
  property alias color1: adapter.color1
  property alias color2: adapter.color2
  property alias color3: adapter.color3
  property alias color4: adapter.color4
  property alias color5: adapter.color5
  property alias color6: adapter.color6
  property alias color7: adapter.color7
  property alias color8: adapter.color8
  property alias color9: adapter.color9
  property alias color10: adapter.color10
  property alias color11: adapter.color11
  property alias color12: adapter.color12
  property alias color13: adapter.color13
  property alias color14: adapter.color14
  property alias color15: adapter.color15
  property alias background: adapter.background
  property alias foreground: adapter.foreground
  property alias cursorColor: adapter.cursorColor
  property alias cursorText: adapter.cursorText
  property alias selectionBackground: adapter.selectionBackground
  property alias selectionForeground: adapter.selectionForeground

  FileView{
    path:`${Paths.stringify(Paths.cache)}/wal/quickshell.json`
    watchChanges: true
    onFileChanged: reload()
    // onAdapterUpdated: writeAdapter()

    JsonAdapter {
      id: adapter

      property string color0: ""
      property string color1: ""
      property string color2: ""
      property string color3: ""
      property string color4: ""
      property string color5: ""
      property string color6: ""
      property string color7: ""
      property string color8: ""
      property string color9: ""
      property string color10: ""
      property string color11: ""
      property string color12: ""
      property string color13: ""
      property string color14: ""
      property string color15: ""
      property string background: ""
      property string foreground: ""
      property string cursorColor: ""
      property string cursorText: ""
      property string selectionBackground: ""
      property string selectionForeground: ""
    }
  }
}
