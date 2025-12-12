pragma Singleton
import Quickshell
import Quickshell.Io
import qs.utils

Singleton {

  property alias general: adapter.general
  property alias visual: adapter.visual
  property alias titles: adapter.titles
  property alias commands: adapter.commands

  property alias padding: adapter.padding
  property alias padding_small: adapter.padding_small
  property alias padding_large: adapter.padding_large

  property alias anim: adapter.animation_speed
  property alias anim_workspaces: adapter.animation_speed_workspaces

  property alias adapter: fileviewer

  FileView{
    id: fileviewer
    path:`${Paths.stringify(Paths.config)}/config.json`
    watchChanges: true
    onFileChanged: reload()
    onAdapterUpdated: writeAdapter()

    JsonAdapter {
      id: adapter

      property GeneralConfig general: GeneralConfig {}
      property VisualConfig visual: VisualConfig {}
      property list<string> titles: [""]
      property list<var> commands: [""]

      property int padding: 10
      property int padding_small: 5
      property int padding_large: 15

      property int animation_speed: 130
      property int animation_speed_workspaces: 300
    }

    onLoadFailed: e => {
      if (e == FileViewError.FileNotFound) {
        writeAdapter()
      }
      console.log("error loading file")
    }

    onLoaded: {
      Fn.awwwSet(visual.wallpaper)
    }
  }
}
