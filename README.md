# Diablo IV Spam Controller

A lightweight **AutoHotkey v2 tool** that allows you to spam selected ability keys in **Diablo IV** with a toggle hotkey and a small in-game overlay.

The tool provides a simple UI to enable or disable default Diablo IV ability keys (**Q, W, E, R**) and control the spam interval.

---

## Screenshot

![Diablo IV Spam Controller](https://i.imgur.com/W6uSREw.png)

---

## Features

* Toggle spam **ON / OFF with F8**
* Emergency exit with **F10**
* Simple configuration UI
* Enable or disable individual keys (**Q / W / E / R**)
* Adjustable spam interval
* Optional **in-game overlay**
* Only sends input when **Diablo IV is the active window**

---

## Requirements

* Windows
* **AutoHotkey v2**

Download AutoHotkey v2:

https://www.autohotkey.com/

---

## Installation

1. Install **AutoHotkey v2**
2. Download or clone the repository

```
git clone https://github.com/YOURNAME/diablo4-spam-controller.git
```

3. Run the script

```
DiabloIV_Spam.ahk
```

---

## Usage

1. Start the script
2. Configure the settings in the UI
3. Click **Start**
4. Launch **Diablo IV**

### Hotkeys

| Key | Function             |
| --- | -------------------- |
| F8  | Toggle spam ON / OFF |
| F10 | Exit script          |

Spam only runs when:

* the script is started
* spam is toggled ON
* **Diablo IV** is the active window

---

## Configuration

### Keys

Enable or disable the default Diablo IV skill keys:

* Q
* W
* E
* R

### Interval

Controls how fast keys are spammed.

Example:

```
120 ms
```

Lower values = faster key spam.

---

## Overlay

When enabled, a small overlay appears while **Diablo IV** is focused showing the current state:

```
Spam: ON
Spam: OFF
```

---

## Disclaimer

Use at your own risk.

Automation tools may violate the terms of service of some games. This project is provided for educational purposes only.

---

## License

MIT License
