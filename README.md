# REAPER Live Drone & Instrument Latch Tools

> **AI Disclosure:** The JSFX scripts, routing logic, and documentation in this repository were developed collaboratively with an AI assistant (Google Gemini). If your workflow or community has a strict no-AI policy, please take note before using or contributing.

A lightweight JSFX utility suite and REAPER template pack for live improvisation. It lets you latch polyphonic synthesizer drones hands-free and continue playing a second MIDI instrument (piano, synth lead, etc.) over the held chord without touching track record-arm buttons.

---

## What's Included

### 1. `Effects/Poly_Chord_Latch`
A polyphonic MIDI note-latching JSFX with a custom `@gfx` status display, clickable UI buttons, and configurable MIDI controls:
- **Infinite Polyphonic Hold:** Intercepts and blocks `Note Off` messages so chords sustain indefinitely (even when REAPER's transport is stopped).
- **Momentary or Toggle/Trigger Chord Capture:** Arms `CAPTURE: READY`, clears the previous drone on the first new note-on, and automatically locks the new chord (`DRONE LOCKED`) once keys or the capture CC are released.
- **Quick Tap Bypass Toggle:** Tapping the capture CC without playing any notes toggles between `DRONE LOCKED` and `LATCH: BYPASS` (silencing held notes when bypassed).
- **Kill / Panic:** Immediately sends channel-matched `Note Off` messages and `CC 123` (All Notes Off) across all 16 channels.
- **Live Note Readout:** Displays the exact note names and octaves of all currently latched notes in pitch order.
- **Configurable Parameters (Sliders):**
  - `Control MIDI Channel` (Default: `16`)
  - `Capture / Toggle CC#` (Default: `102`)
  - `Kill / Panic CC#` (Default: `105`)
  - `Capture Button Mode`:
    - `Momentary (127 Press / 0 Release)` *(Default)* — Hold button (`>= 64`) to enter capture mode; release (`< 64`) to lock chord (or toggle bypass on a quick tap with no notes).
    - `Toggle / Trigger (Any Press above 0)` — For toggle footswitches or trigger-only pads. Press once (`> 0`) to arm capture; playing and releasing a chord automatically locks it. Pressing again while still in capture mode (with no notes played) toggles bypass.

### 2. `Effects/Drone_Capture_Mute`
A companion MIDI filter placed before your lead/piano instrument:
- Blocks incoming `Note On` messages while drone capture is active, allowing you to enter new drone chords silently without triggering notes on your lead instrument.
- Always passes `Note Off` messages, Sustain Pedal (`CC 64`), and pitch bend so active notes never stick.
- Includes matching sliders for `Control MIDI Channel` (Default: `16`), `Capture / Mute CC#` (Default: `102`), and `Capture Button Mode` (`Momentary` or `Toggle / Trigger`).

### 3. Track & Project Templates
- **`TrackTemplates/Drone + Piano (Folder).RTrackTemplate`:** A pre-routed 3-track folder (`Drone + Instrument Rig` parent bus + `Synth Drone` + `Piano`) with both child tracks Record-Armed and Input Monitoring enabled.
- **`TrackTemplates/Drone + Instrument Slot (Folder).RTrackTemplate`:** The same folder structure with an empty instrument slot after `Drone_Capture_Mute` so you can load any synth or sampler.
- **`ProjectTemplates/Live Jam - Drone & Instrument.RPP`:** Startup-ready project template preloaded with the folder rig.

---

## Installation

### Option 1: Via ReaPack (Recommended — All Platforms)
1. In REAPER, open **Extensions > ReaPack > Import repositories...**
2. Paste the repository index URL:
   ```text
   https://githubusercontent.com<YOUR_GITHUB_USERNAME>/<YOUR_REPO_NAME>/main/index.xml
   ```
3. Open **Extensions > ReaPack > Browse packages...**, search for `Drone`, select the JSFX effects and templates you want, and click **Apply**.

### Option 2: Manual / Symlink Installation (Linux)
1. Clone this repository:
   ```bash
   git clone https://github.com<YOUR_GITHUB_USERNAME>/<YOUR_REPO_NAME>.git ~/projects/reaper-drone-tools
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

## MIDI Setup & Default Controls

Set both the **Synth Drone** track and your **Piano / Instrument** track to:
- **Record Arm:** `ON`
- **Input Monitoring:** `ON`
- **MIDI Input:** `All MIDI Inputs > All Channels`

*(If your controller uses a different MIDI channel, CC numbers, or toggle-style buttons, adjust the sliders on both `Poly_Chord_Latch` and `Drone_Capture_Mute` to match.)*

| Default MIDI Message | Mode | Action |
| :--- | :--- | :--- |
| **Ch 16, CC 102 >= 64 (Hold)** | `Momentary` | Arms `CAPTURE: READY` on Drone; mutes `Note On` on Instrument |
| **Ch 16, CC 102 < 64 (Release)** | `Momentary` | Locks new chord (`DRONE LOCKED`); unmutes Instrument |
| **Ch 16, CC 102 (Quick tap, no notes)** | `Momentary` | Toggles between `DRONE LOCKED` and `LATCH: BYPASS` |
| **Ch 16, CC 102 > 0 (Press)** | `Toggle / Trigger` | Arms `CAPTURE: READY` & mutes Instrument (auto-locks & unmutes once chord keys are released) |
| **Ch 16, CC 105 > 0** | `Both` | **Kill / Panic** — releases all latched drone notes immediately |

---

## License

This project is licensed under the [MIT License](LICENSE) — feel free to use, modify, and distribute these scripts and templates in any personal or commercial setup.
