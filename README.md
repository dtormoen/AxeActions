# Axe FX Reaper Actions
This project adds scripts which allow you to control your Axe FX with actions in
Reaper. These actions can be mapped to keyboard shortcuts, midi commands from
control surfaces, or chained together into Reaper scripts.

Let me know if there is any functionality you are interested in or even just let
me know if you find this useful!

# Setup
Pay close attention to the location of files so they can be run properly from
Reaper. I tried to write this so it would work on different OS's and varying
setups, but it has only been tested on my Windows machine.

## Checkout or Download from Github
Checkout or download this repository so it is contained in the
`<Reaper Installation>/scripts` folder. `AxeMain.lua` should have the path
`<Reaper Installation>/scripts/AxeActions/AxeMain.lua`. 

## Add actions to Reaper
Press `?` to bring up the actions menu. In the lower right corner select 
`Reascript: Load`. Select all of the files in the `actions` folder. These
actions will now be available to be mapped to keyboard shortcuts or midi control
surfaces similar to any other Reaper action.

## Setup Axe FX
This has only been tested on an Axe FX III and is configured to search for that
device's name. This basic idea should work for any other device which accepts
midi messages with minimal tweaking.

In the Axe FX midi setup I could not get automatically learning parameters to
work properly so I had to manually set the midi message in the Axe FX to the
mapping at the top of `AxeMain.lua`. 

For example, go to 
`SETUP -> MIDI/Remote -> Other (farthest right page) -> Preset Increment` and
set `Preset Increment` to `8` to map that control.
