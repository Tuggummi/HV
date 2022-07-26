# HV - Handle the Vehicle.

This is created since I didn't find a repair and clean resource, later on I decided to combind it with my own vehicle spawn and delete resource.

I've also made a translations.lua, where you can change all messages that are promted to the user. This makes it really easy configurable for your taste.

There is two configurable parts, which you can view in config.lua

## Features:

There's 5 commands, repair, clean and fix.

**/repair** - Repairs the vehicle, works if you're inside the vehicle or close to it.

**/clean** - Cleans the vehicle, works if you're inside the vehicle or close to it.

**/fix** - Repairs and cleans the vehicle, works if you're inside the vehicle or close to it.

**/v** - Spawn the vehicle with the given name, Player spawns insied the vehicle.

**/dv** - Deletes the vehicle you're sitting in, or closest to. Only delete one, the closest one, have to be within 5 meters i believe. Changeble in client:118

### Installation

1. Download the resource, put it in either your root directory or perhaps a "script" directory, your choice
2. Change the name to HV and ensure/start it from the server.cfg.
3. Edit the config and translations to your liking, and restart the server.
4. Enjoy!

#### No external scripts required.
