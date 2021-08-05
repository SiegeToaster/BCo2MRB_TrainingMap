# Bravo Company, 2nd Marine Raider Battalion Training Map
Training map for the Bravo Company, 2nd Marine Raider Battalion ArmA 3 Unit.

## Features

#### Items with checked boxes are completed.
###### Training Areas:
  - [x] AT
  - [ ] AA
  - [ ] Grenadier *
  - [ ] Corpsman *
  - [x] Marksman
  - [ ] JTAC
  - [ ] Driver
  - [ ] Parachuting/HALO
  - [ ] Aviation

######
- [ ] USS Khe Sahn (LHD) Strike Group
- [x] Vehicle Garages
- [x] Firing Range (100-400m)
- [x] Firing Range (400m+)
- [x] Briefing Area
- [x] Maritime Interdiction Scenario
- [x] CQC Shoothouses
  - [x] Shoothouse 1
  - [x] Shoothouse 2
  - [x] Shoothouse 3
  - [x] The Pit
  - [x] Consulate
- [x] Land Navigation Course (Rogaining)
- [ ] Scoreboards for Shoothouse and Rogaining minigames

###### More * = higher priority

## Change Log

### Version 0.1.0
- All scripts done
- 3den setup in progress

### Version 0.2.0
- Main Base Complete
- Shoothouses 1-2, The Pit, and Consulate complete
- Land Navigation Course (Rogaining) complete

### Version 0.2.1
- Fixed the bug stopping players from starting the shoothouse or land navigation course.
- Added Vehicle Pools
- Cleaned up Layers (Editor)
	- Removed empty layers
	- Renamed layers
	- Changed what objects are in what layers
- Added group names to player groups.
- Moved all scripts to the Functions Library (Optimization)
- Added ORBAT
- Updated Briefing

### Version 0.2.2
- Added 100-400 meter firing ranges
- Updated ORBAT
- Miscellaneous optimization changes
- Added the USS Khe Sahn (LHD), USS Liberty (Destroyer), and Cargo Ship (Natural Gas); No interactions, respawns, etc. have been added.

### Version 0.2.3
- Added 400-1000m firing range
- Added teleporter to 100-400m firing ranges and 400-1000m firing range
- Added runway lights and helicopters at main base (Hall)
- Added new helicopters to helicopter spawner (small aviation vehicles)
- Cleaned up Layers (Editor)
- Merged 'Hide Terrain Object' Modules where appropriate
- Added MOS Training Areas
	- AT Range
	- Marksman Range (400-1000m firing range)
- Updated shoothouses
	- Ability to choose responsive/unresponsive AI (responsive AI will shoot back, unresponsive won't)
	- Added spectator buildings and teleporters for The Pit
	- Minor bug fixes
- Added loadout saving

### Version 0.2.4 - Hotfix
- Fixed arsenal trigger bug that sends a systemchat to everyone instead of the specific player that exited the trigger
- Bug fixes to the loadout saving script
	- remoteExec and call script
	- use current player loadout instead of nil for fetching loadout
- Started work on Shoothouse 3
- Removed all assets/scripts with a dependency for the [FIR AWS(AirWeaponSystem)](https://steamcommunity.com/workshop/filedetails/?id=366425329) mod

### Version 0.2.5
- 3den Attributes updated
- Updated/Added function descriptions
- Fixed shoothouse scripts (null objects in _players array)
- Added difficulty to shoothouses
- Added automatic array generation for consecutive objects (e.g, shoothouse spawn locations)
- Players can no longer leave a shoothouse without using the return to base action.
- Updated ORBAT
- Minor update to vehicle pool GUI function
- Added custom GUI to start shoot houses
- Updated small and medium aviation vehicles
	- renamed little birds to add proper designations
	- added new large helicopters
- Added Shoothouse 3
- Added custom GUI to start rogaining
- Added waitUntil conditions to make sure everything is setup before moving on in shootHouse, rogaining, and mosATLand functions
- Fixed locality bugs in rogaining and mosATLand functions
#### Version 0.2.5.1
- Added multi-level support for shoothouses (fix to shoot house 3 and The Consulate)

### Version 0.2.6
- Added repair, refuel, rearm trucks to vehicle spawners (per Wristy's request)
- Added repair, refuel, rearm trucks to helipad area
- Removed 2 northern-most helicopters on helipad (per Wristy's request)
- added intro cinematic
- all shoothouse walls converted to Military Base Wall/Sandbags where possible
- added fail/finished/cancel messages to shoothouses
- Compressed ace actions for shooting ranges
- Added a version log after loading is complete
- Added respawn, arsenal, and x1 HH-60G/M Pavehawk to the USS Khe Sahn (LHD) and USS Liberty (Destroyer)
- Added cargo ship shoothouse

### Version 0.3.0
- rogaining.sqf locality fixes
- rogaining minigame removes all items (gives them back at the end).
- fixed version log displaying before player could see
- added scoreboards (still WiP)

### Version 0.3.1
- removed dependency issues with new modpack version (v3)