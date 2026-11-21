# REAPER Live Drone & Instrument Latch Tools

> **AI Disclosure:** The JSFX scripts, routing logic, and documentation in this repository were developed collaboratively with an AI assistant (Google Gemini). If your workflow or community has a strict no-AI policy, please take note before using or contributing.

A lightweight JSFX utility suite and REAPER template pack for live improvisation. It lets you latch polyphonic synthesizer drones hands-free and continue playing a second MIDI instrument (piano, synth lead, etc.) over the held chord without touching track record-arm buttons.

---

## What's Included

### 1. `Effects/Poly_Chord_Latch`
A polyphonic MIDI note-latching JSFX with a custom `@gfx` status display and clickable controls:
- **Infinite Polyphonic Hold:** Intercepts and blocks `Note Off` messages so chords sustain indefinitely (even when REAPER's transport is stopped).
- **Momentary Chord Capture (`Ch 16, CC 102 = 127`):** Holding CC 102 enters `CAPTURE: READY`, clears the previous drone on the first new note-on, and automatically locks the new chord (`DRONE LOCKED`) once keys or CC 102 are released.
- **Quick Tap Toggle (`Ch 16, CC 102` tap `127 -> 0` with no notes):** Toggles between `DRONE LOCKED` and `LATCH: BYPASS` (silencing held notes when bypassed).
- **Kill / Panic (`Ch 16, CC 105 > 0`):** Immediately sends channel-matched `Note Off` messages and `CC 123` (All Notes Off) across all 16 channels.
- **Live Readout:** Displays the exact note names and octaves of all currently latched notes in pitch order.

### 2. `Effects/Drone_Capture_Mute`
A companion MIDI filter placed before your lead/piano instrument:
- Blocks incoming `Note On` messages while `Ch 16, CC 102` is held down (`127`), allowing you to enter new drone chords silently without triggering notes on your lead instrument.
- Always passes `Note Off` messages, Sustain Pedal (`CC 64`), and pitch bend so active notes never stick.

### 3. Track & Project Templates
- **`TrackTemplates/Drone + Piano (Folder).RTrackTemplate`:** A pre-routed 3-track folder (`Drone + Instrument Rig` parent bus + `Synth Drone` + `Piano`) with both child tracks Record-Armed and Input Monitoring enabled.
- **`TrackTemplates/Drone + Instrument Slot (Folder).RTrackTemplate`:** The same folder structure with an empty instrument slot after `Drone_Capture_Mute` so you can load any synth or sampler.
- **`ProjectTemplates/Live Jam - Drone & Instrument.RPP`:** Startup-ready project template preloaded with the folder rig.

---

## Installation (Linux)

1. Clone this repository:
   ```bash
   git clone <your-repo-url> ~/projects/reaper-drone-tools
   cd ~/projects/reaper-drone-tools
   ```
2. Run the symlink installer to link the JSFX plugins and templates into `~/.config/REAPER/`:
   ```bash
   chmod +x install.sh
   ./install.sh
   ```
3. Restart REAPER (or press `F5` inside the FX Browser) to scan the new JSFX plugins.

*(On macOS or Windows, copy the contents of `Effects/`, `TrackTemplates/`, and `ProjectTemplates/` into your respective REAPER resource directory found via **Options > Show REAPER resource path in explorer/finder**.)*

---

## MIDI Setup & Controls

Set both the **Synth Drone** track and your **Piano / Instrument** track to:
- **Record Arm:** `ON`
- **Input Monitoring:** `ON`
- **MIDI Input:** `All MIDI Inputs > All Channels`

| MIDI Message | Action |
| :--- | :--- |
| **Ch 16, CC 102 = 127 (Hold)** | Arms `CAPTURE: READY` on Drone; mutes `Note On` on Instrument |
| **Ch 16, CC 102 = 0 (After playing chord)** | Locks new chord (`DRONE LOCKED`); unmutes Instrument |
| **Ch 16, CC 102 = 127 -> 0 (Quick tap, no notes)** | Toggles between `DRONE LOCKED` and `LATCH: BYPASS` |
| **Ch 16, CC 105 > 0** | **Kill / Panic** — releases all latched drone notes immediately |

---

## License

This project is licensed under the [MIT License](LICENSE) — feel free to use, modify, and distribute these scripts and templates in any personal or commercial setup.
