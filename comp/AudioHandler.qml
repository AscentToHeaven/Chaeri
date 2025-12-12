pragma Singleton
import Quickshell
import Quickshell.Io
import QtQuick
import Quickshell.Services.Pipewire
import qs.utils

Singleton {
  id: root
  readonly property var nodes: Pipewire.nodes.values.reduce((acc, node) => {
      if (!node.isStream) {
          if (node.isSink)
              acc.sinks.push(node);
          else if (node.audio)
              acc.sources.push(node);
      }
      return acc;
  }, {
      sources: [],
      sinks: []
  })

  readonly property list<PwNode> sinks: nodes.sinks
  readonly property list<PwNode> sources: nodes.sources

  readonly property PwNode sink: Pipewire.defaultAudioSink
  readonly property PwNode source: Pipewire.defaultAudioSource

  readonly property bool muted: !!sink?.audio?.muted
  readonly property real volume: sink?.audio?.volume ?? 0

  PwObjectTracker {
      objects: [...root.sinks, ...root.sources]
  }

  function setVol(amount: real): void {
    if (sink?.ready && sink?.audio) {
      sink.audio.muted = false
      sink.audio.volume = Math.max(0, Math.min(1, amount));
    }
  }

  function volUp(amount: real): void {
    setVol(volume + amount)
  }

  function volDown(amount: real): void {
    setVol(volume - amount)
  }

  function toggleSource(): void {
    swapProc.running = true
  }
    Process {
        id: swapProc
        command: ["bash", `${Paths.strip(Paths.config)}/scripts/toggleaudio.sh`]
        running: false
    }
}
