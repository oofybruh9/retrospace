# retrospace

Emulation on a GitHub Codespace!

## Why?

Most people want to play classic games from their era or just wanna play Mario. But noone wants to go on a deep rabbithole to just find an good pc, emulator, and rom for their game to run smoothly, so I made this!

## Setup

### First steps

Fork the repo so u pay for the codespace cuz i cant afford all that usage, then click Code, then the tab Codespaces, then the plus button to create your codespace!

### Codespace time!

Just run `./setup.sh` in the terminal:  
![setup.sh](./images/start.sh.png)  

### Entering the Desktop

Go to the Ports tab ![ports](./images/ports.png) and select the URL next to `desktop (6080)` ![6080](./images/6080.png)  Click that URL and then click the globe ![globe](./images/globe.png) to access the desktop.  
![desktop](./images/desk.png)  
Right click the desktop and go to the System tab  
![sys](./images/sub-menu.png)  
Then click Edit Desktop Menu  
![edit](./images/edit.png)  
You will get to a screen similar to this  
![fluxbox](./images/fluxbox.png)  
Delete the Web Browser line  
and add these lines to the bottom of the Web Browser tab  

```text
    [exec] (midori) { midori } <>
    [exec] (ES-DE) { emulationstation } <>
    [exec] (RetroArch) { retroarch }
    [exec] (Wine GUI) { winegui } <>
    [exec] (Bauh) { bauh } <>
```

### End! `¯\_(ツ)_/¯`

And there you go! You now have a retro gaming machine, accessible ANYWHERE(if u login with github :D )

## [License](LICENSE)

licensed under GPLv3 `¯\_(ツ)_/¯`
