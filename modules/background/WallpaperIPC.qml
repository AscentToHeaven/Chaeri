import QtQuick
import Quickshell
import Quickshell.Io
import qs.config
import qs.utils

IpcHandler {
    target: "wallpaper"

    function set(path: string):void {
        Fn.awwwSet(path)
    }

    function change(path: string): void {
        Config.visual.wallpaper = path
        Fn.awwwSet(path)
    }

    function pw(path: string): void {
        Fn.pywal(path)
    }
}
