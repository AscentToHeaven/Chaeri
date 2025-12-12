pragma Singleton
import Quickshell.Io
import Quickshell
import QtQml
import qs.config

Singleton {
    id: root

    function awwwSet(path: string): void {
        proc.command = ["awww", "img", path, "--transition-type", "wipe", "--transition-fps", "144", "--transition-duration", "2"]
        proc.running = true
        root.pywal(path)
    }

    function pywal(path: string): void {
        console.log("running pywal")
        // proc.command = ["wal", "-i", path, "--backend", "modern_colorthief"]
        proc.command = ["wal", "-i", path]
        proc.running = true
        root.pywalDiscord()
    }

    function pywalDiscord(): void {
        discDelay.running = true
    }

    Process {
        id: proc
        command: []
        running: false
    }

    // process delays are causing pywal discord to fail since it happens before pywal finishes-
    // so this is needed to give it time.
    Timer {
        id: discDelay
        interval: 1000
        running: false

        onTriggered: {
            proc.command = ["pywal-discord"]
            proc.running = true
        }
    }
}
