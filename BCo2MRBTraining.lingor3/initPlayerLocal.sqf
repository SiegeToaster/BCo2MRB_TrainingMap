waitUntil {({!isNil _x} count ["shootHousePlayerInterfaces", "shootHouseSpectatorInterfaces", "MOSTrainingInterfaces"]) > 1};

//=============Player Variables=============\\

player setVariable ["scoreArray",[]];
player setVariable ["totalScore",[0,0]]; // shooting range vars

player setVariable ["loadout", nil];
player setVariable ["customLoadout", false]; // loadout vars

player setVariable ["playredIntro", false]; // misc vars

//=============ACE Interactions=============\\

//=============Shoothouse Interactions=============\\
_start = ["start_root", "Start Shoot Houses", "", {call Co2T_fnc_shootHouseDialogCreate}, {true}] call ace_interact_menu_fnc_createAction;
[startInterface, 0, ["ACE_MainActions"], _start, true] call ace_interact_menu_fnc_addActionToObject;

_personalShootHouseScore = ["shootHouseScore", "Display Personal Score", "", {
	private _scores = shootHouseScoreboard getOrDefault [getPlayerUID _player, [0, 0, 0, 0]];
	private _playerName = getPlayerUID _player call BIS_fnc_getUnitByUid;
	if (isNull _playerName) then {
		_playerName = "Unkown player"
	} else {
		_playerName = name _playerName;
	};
	shootHouseScoreString = (_playerName + " has completed " + (str (_scores select 2)) + " out of " + (str (_scores select 3)) + " shoot house games with an average time of " + ((_scores select 1) call Co2T_fnc_timeConvert) + ".  Their lowest time is " + ((_scores select 0) call Co2T_fnc_timeConvert));
	publicVariable "shootHouseScoreString";
	shootHouseScoreString remoteExec ["systemChat"];
}, {true}] call ace_interact_menu_fnc_createAction;
[startInterface, 0, ["ACE_MainActions"], _personalShootHouseScore, true] call ace_interact_menu_fnc_addActionToObject;

_return = ["return", "Return to Base", "", {_player setPosATL (getPosATL startArea); [objNull, _player] call ace_medical_treatment_fnc_fullHeal;}, {true}] call ace_interact_menu_fnc_createAction;
{[_x, 0, ["ACE_MainActions"], _return, true] call ace_interact_menu_fnc_addActionToObject;} forEach shootHousePlayerInterfaces;

//=============Shoothouse Spectator Actions=============\\
_spectate = ["spectate_root", "Spectate", "", {}, {true}] call ace_interact_menu_fnc_createAction;
{[_x, 0, ["ACE_MainActions"], _spectate, true] call ace_interact_menu_fnc_addActionToObject;} forEach shootHouseSpectatorInterfaces;

_spectatePit = ["spectate_pit", "Spectate The Pit", "", {}, {true}] call ace_interact_menu_fnc_createAction;
{[_x, 0, ["ACE_MainActions", "spectate_root"], _spectatePit, true] call ace_interact_menu_fnc_addActionToObject;} forEach [spectateInterface, pitNorthSpectator, pitSouthSpectator];

_spectatePitNorth = ["spectate_pit_north", "North", "", {_player setCaptive true; _player allowDamage false; _player setPosATL (getPosATL pitNorthSpectator);}, {true}] call ace_interact_menu_fnc_createAction;
{[_x, 0, ["ACE_MainActions", "spectate_root", "spectate_pit"], _spectatePitNorth, true] call ace_interact_menu_fnc_addActionToObject;} forEach [spectateInterface, pitSouthSpectator];

_spectatePitSouth = ["spectate_pit_south", "South", "", {_player setCaptive true; _player allowDamage false; _player setPosATL (getPosATL pitSouthSpectator);}, {true}] call ace_interact_menu_fnc_createAction;
{[_x, 0, ["ACE_MainActions", "spectate_root", "spectate_pit"], _spectatePitSouth, true] call ace_interact_menu_fnc_addActionToObject;} forEach [spectateInterface, pitNorthSpectator];
/*
_spectateSH1 = ["spectate_SH1", "Spectate Shoot House 1", "", {}, {true}] call ace_interact_menu_fnc_createAction;
{[_x, 0, ["ACE_MainActions", "spectate_root"], _spectateSH1, true] call ace_interact_menu_fnc_addActionToObject;} forEach [spectateInterface, sh1EastSpectator, sh1WestSpectator];

_spectateSH1East = ["spectate_SH1_east", "East", "", {_player setCaptive true; _player allowDamage false; _player setPosATL (getPosATL sh1EastSpectator);}, {true}] call ace_interact_menu_fnc_createAction;
{[_x, 0, ["ACE_MainActions", "spectate_root", "spectate_SH1"], _spectateSH1East, true] call ace_interact_menu_fnc_addActionToObject;} forEach [spectateInterface, sh1WestSpectator];

_spectateSH1West = ["spectate_SH1_west", "West", "", {_player setCaptive true; _player allowDamage false; _player setPosATL (getPosATL sh1WestSpectator);}, {true}] call ace_interact_menu_fnc_createAction;
{[_x, 0, ["ACE_MainActions", "spectate_root", "spectate_SH1"], _spectateSH1West, true] call ace_interact_menu_fnc_addActionToObject;} forEach [spectateInterface, sh1EastSpectator];

_spectateSH2 = ["spectate_SH2", "Spectate Shoot House 2", "", {}, {true}] call ace_interact_menu_fnc_createAction;
{[_x, 0, ["ACE_MainActions", "spectate_root"], _spectateSH2, true] call ace_interact_menu_fnc_addActionToObject;} forEach [spectateInterface, sh2EastSpectator, sh2WestSpectator];

_spectateSH2East = ["spectate_SH2_east", "East", "", {_player setCaptive true; _player allowDamage false; _player setPosATL (getPosATL sh2EastSpectator);}, {true}] call ace_interact_menu_fnc_createAction;
{[_x, 0, ["ACE_MainActions", "spectate_root", "spectate_SH2"], _spectateSH2East, true] call ace_interact_menu_fnc_addActionToObject;} forEach [spectateInterface, sh2WestSpectator];

_spectateSH2West = ["spectate_SH2_west", "West", "", {_player setCaptive true; _player allowDamage false; _player setPosATL (getPosATL sh2WestSpectator);}, {true}] call ace_interact_menu_fnc_createAction;
{[_x, 0, ["ACE_MainActions", "spectate_root", "spectate_SH2"], _spectateSH2West, true] call ace_interact_menu_fnc_addActionToObject;} forEach [spectateInterface, sh2EastSpectator];
*/
_spectateReturn = ["spectate_return", "Return to Base", "", {_player setCaptive false; _player allowDamage true; _player setPosATL (getPosATL spectateInterface)}, {true}] call ace_interact_menu_fnc_createAction;
{[_x, 0, ["ACE_MainActions", "spectate_root"], _spectateReturn, true] call ace_interact_menu_fnc_addActionToObject;} forEach shootHouseSpectatorInterfaces - [spectateInterface];

//=============Rogaining Action=============\\
_rogain = ["rogain", "Start Rogaining", "", {call Co2T_fnc_rogaineDialogCreate}, {true}] call ace_interact_menu_fnc_createAction;
[rogaineInterface, 0, ["ACE_MainActions"], _rogain, true] call ace_interact_menu_fnc_addActionToObject;

_personalRogaineScore = ["rogainScore", "Display Personal Score", "", {
	private _scores = rogainingScoreboard getOrDefault [getPlayerUID _player, [0, 0, 0]];
	private _playerName = getPlayerUID _player call BIS_fnc_getUnitByUid;
	if (isNull _playerName) then {
		_playerName = "Unkown player"
	} else {
		_playerName = name _playerName;
	};
	rogaineScoreString = (_playerName + " has completed " + (str (_scores select 2)) + " rogaine games with an average time of " + ((_scores select 1) call Co2T_fnc_timeConvert) + ".  Their lowest time is " + ((_scores select 0) call Co2T_fnc_timeConvert));
	publicVariable "rogaineScoreString";
	rogaineScoreString remoteExec ["systemChat"];
}, {true}] call ace_interact_menu_fnc_createAction;
[rogaineInterface, 0, ["ACE_MainActions"], _personalRogaineScore, true] call ace_interact_menu_fnc_addActionToObject;

//=============100-400 Shooting Range Actions=============\\
_rangeLeft = ["range_left", "Shooting Range Controls", "", {}, {true}] call ace_interact_menu_fnc_createAction;
[sRangeLeftInteract, 0, ["ACE_MainActions"], _rangeLeft, true] call ace_interact_menu_fnc_addActionToObject;

_rangeLeft100 = ["100", "100 Meters", "", {["-left", shootRangeLeftLogic, 100] call Co2T_fnc_shootRange}, {(shootRangeLeftLogic getVariable "distancePosition") != 100}] call ace_interact_menu_fnc_createAction;
_rangeLeft150 = ["150", "150 Meters", "", {["-left", shootRangeLeftLogic, 150] call Co2T_fnc_shootRange}, {(shootRangeLeftLogic getVariable "distancePosition") != 150}] call ace_interact_menu_fnc_createAction;
_rangeLeft200 = ["200", "200 Meters", "", {["-left", shootRangeLeftLogic, 200] call Co2T_fnc_shootRange}, {(shootRangeLeftLogic getVariable "distancePosition") != 200}] call ace_interact_menu_fnc_createAction;
_rangeLeft300 = ["300", "300 Meters", "", {["-left", shootRangeLeftLogic, 300] call Co2T_fnc_shootRange}, {(shootRangeLeftLogic getVariable "distancePosition") != 300}] call ace_interact_menu_fnc_createAction;
_rangeLeft400 = ["400", "400 Meters", "", {["-left", shootRangeLeftLogic, 400] call Co2T_fnc_shootRange}, {(shootRangeLeftLogic getVariable "distancePosition") != 400}] call ace_interact_menu_fnc_createAction;
{[sRangeLeftInteract, 0, ["ACE_MainActions", "range_left"], _x, true] call ace_interact_menu_fnc_addActionToObject} forEach [_rangeLeft100, _rangeLeft150, _rangeLeft200, _rangeLeft300, _rangeLeft400];


_rangeMiddle = ["range_middle", "Shooting Range Controls", "", {}, {true}] call ace_interact_menu_fnc_createAction;
[sRangeMiddleInteract, 0, ["ACE_MainActions"], _rangeMiddle, true] call ace_interact_menu_fnc_addActionToObject;

_rangeMiddle100 = ["100", "100 Meters", "", {["-middle", shootRangeMiddleLogic, 100] call Co2T_fnc_shootRange}, {(shootRangeMiddleLogic getVariable "distancePosition") != 100}] call ace_interact_menu_fnc_createAction;
_rangeMiddle150 = ["150", "150 Meters", "", {["-middle", shootRangeMiddleLogic, 150] call Co2T_fnc_shootRange}, {(shootRangeMiddleLogic getVariable "distancePosition") != 150}] call ace_interact_menu_fnc_createAction;
_rangeMiddle200 = ["200", "200 Meters", "", {["-middle", shootRangeMiddleLogic, 200] call Co2T_fnc_shootRange}, {(shootRangeMiddleLogic getVariable "distancePosition") != 200}] call ace_interact_menu_fnc_createAction;
_rangeMiddle300 = ["300", "300 Meters", "", {["-middle", shootRangeMiddleLogic, 300] call Co2T_fnc_shootRange}, {(shootRangeMiddleLogic getVariable "distancePosition") != 300}] call ace_interact_menu_fnc_createAction;
_rangeMiddle400 = ["400", "400 Meters", "", {["-middle", shootRangeMiddleLogic, 400] call Co2T_fnc_shootRange}, {(shootRangeMiddleLogic getVariable "distancePosition") != 400}] call ace_interact_menu_fnc_createAction;
{[sRangeMiddleInteract, 0, ["ACE_MainActions", "range_middle"], _x, true] call ace_interact_menu_fnc_addActionToObject} forEach [_rangeMiddle100, _rangeMiddle150, _rangeMiddle200, _rangeMiddle300, _rangeMiddle400];


_rangeRight = ["range_right", "Shooting Range Controls", "", {}, {true}] call ace_interact_menu_fnc_createAction;
[sRangeRightInteract, 0, ["ACE_MainActions"], _rangeRight, true] call ace_interact_menu_fnc_addActionToObject;

_rangeRight100 = ["100", "100 Meters", "", {["-right", shootRangeRightLogic, 100] call Co2T_fnc_shootRange}, {(shootRangeRightLogic getVariable "distancePosition") != 100}] call ace_interact_menu_fnc_createAction;
_rangeRight150 = ["150", "150 Meters", "", {["-right", shootRangeRightLogic, 150] call Co2T_fnc_shootRange}, {(shootRangeRightLogic getVariable "distancePosition") != 150}] call ace_interact_menu_fnc_createAction;
_rangeRight200 = ["200", "200 Meters", "", {["-right", shootRangeRightLogic, 200] call Co2T_fnc_shootRange}, {(shootRangeRightLogic getVariable "distancePosition") != 200}] call ace_interact_menu_fnc_createAction;
_rangeRight300 = ["300", "300 Meters", "", {["-right", shootRangeRightLogic, 300] call Co2T_fnc_shootRange}, {(shootRangeRightLogic getVariable "distancePosition") != 300}] call ace_interact_menu_fnc_createAction;
_rangeRight400 = ["400", "400 Meters", "", {["-right", shootRangeRightLogic, 400] call Co2T_fnc_shootRange}, {(shootRangeRightLogic getVariable "distancePosition") != 400}] call ace_interact_menu_fnc_createAction;
{[sRangeRightInteract, 0, ["ACE_MainActions", "range_right"], _x, true] call ace_interact_menu_fnc_addActionToObject} forEach [_rangeRight100, _rangeRight150, _rangeRight200, _rangeRight300, _rangeRight400];


_rangeLong = ["range_long", "Shooting Range Controls", "", {}, {true}] call ace_interact_menu_fnc_createAction;
[sRangeLongInteract, 0, ["ACE_MainActions"], _rangeLong, true] call ace_interact_menu_fnc_addActionToObject;

_rangeLong400 = ["400", "400 Meters", "", {["--long", shootRangeLongLogic, 400] call Co2T_fnc_shootRange}, {(shootRangeLongLogic getVariable "distancePosition") != 400}] call ace_interact_menu_fnc_createAction;
_rangeLong500 = ["500", "500 Meters", "", {["--long", shootRangeLongLogic, 500] call Co2T_fnc_shootRange}, {(shootRangeLongLogic getVariable "distancePosition") != 500}] call ace_interact_menu_fnc_createAction;
_rangeLong600 = ["600", "600 Meters", "", {["--long", shootRangeLongLogic, 600] call Co2T_fnc_shootRange}, {(shootRangeLongLogic getVariable "distancePosition") != 600}] call ace_interact_menu_fnc_createAction;
_rangeLong700 = ["700", "700 Meters", "", {["--long", shootRangeLongLogic, 700] call Co2T_fnc_shootRange}, {(shootRangeLongLogic getVariable "distancePosition") != 700}] call ace_interact_menu_fnc_createAction;
_rangeLong800 = ["800", "800 Meters", "", {["--long", shootRangeLongLogic, 800] call Co2T_fnc_shootRange}, {(shootRangeLongLogic getVariable "distancePosition") != 800}] call ace_interact_menu_fnc_createAction;
_rangeLong900 = ["900", "900 Meters", "", {["--long", shootRangeLongLogic, 900] call Co2T_fnc_shootRange}, {(shootRangeLongLogic getVariable "distancePosition") != 900}] call ace_interact_menu_fnc_createAction;
_rangeLong1000 = ["1000", "1000 Meters", "", {["--long", shootRangeLongLogic, 1000] call Co2T_fnc_shootRange}, {(shootRangeLongLogic getVariable "distancePosition") != 1000}] call ace_interact_menu_fnc_createAction;
{[sRangeLongInteract, 0, ["ACE_MainActions", "range_long"], _x, true] call ace_interact_menu_fnc_addActionToObject} forEach [_rangeLong400, _rangeLong500, _rangeLong600, _rangeLong700, _rangeLong800, _rangeLong900, _rangeLong1000];

_rangeLongHide = ["range_hide", "Hide Targets", "", {{hideObjectGlobal _x} forEach ((getMissionLayerEntities "--long") select 0)}, {!(isObjectHidden rangeTarget13)}] call ace_interact_menu_fnc_createAction;
[sRangeLongInteract, 0, ["ACE_MainActions"], _rangeLongHide, true] call ace_interact_menu_fnc_addActionToObject;

_rangeLongShow = ["range_show", "Show Targets", "", {{_x hideObjectGlobal false} forEach ((getMissionLayerEntities "--long") select 0)}, {isObjectHidden rangeTarget13}] call ace_interact_menu_fnc_createAction;
[sRangeLongInteract, 0, ["ACE_MainActions"], _rangeLongShow, true] call ace_interact_menu_fnc_addActionToObject;


_rangeClearScore = ["range_clearScore", "Clear Score", "", {
	_player setVariable ["scoreArray", []];
	_player setVariable ["totalScore", [0, 0]];
	systemChat format ["%1 score cleared.", name _player];
}, {true}] call ace_interact_menu_fnc_createAction;
{[_x, 0, ["ACE_MainActions"], _rangeClearScore, true] call ace_interact_menu_fnc_addActionToObject} forEach [sRangeLeftInteract, sRangeMiddleInteract, sRangeRightInteract, sRangeLongInteract];

_rangeShowScore = ["range_showScore", "Show Score", "", {
	if (((_player getVariable "totalScore") select 0) > 0) then {
		[format ["%1 scored %2 points in %4 shots with an average of %3 points per shot.", name _player, (_player getVariable "totalScore") select 0, round (((_player getVariable "totalScore") select 0) / ((_player getVariable "totalScore") select 1)), (_player getVariable "totalScore") select 1]] remoteExec ["systemChat", 0];
	} else {
		systemChat "No score has been logged yet.";
	}
}, {true}] call ace_interact_menu_fnc_createAction;
{[_x, 0, ["ACE_MainActions"], _rangeShowScore, true] call ace_interact_menu_fnc_addActionToObject} forEach [sRangeLeftInteract, sRangeMiddleInteract, sRangeRightInteract, sRangeLongInteract];

//=============MOS Interface Actions=============\\
_toShootRange = ["to_ShootRange", "Teleport to Shooting Range", "", {_player setPosATL (getPosATL sRangeInteract)}, {true}] call ace_interact_menu_fnc_createAction;
_toMarksman = ["to_Marksman", "Teleport to Marksman Range", "", {_player setPosATL (getPosATL sRangeLongInteract)}, {true}] call ace_interact_menu_fnc_createAction;
_toAT = ["to_AT", "Teleport to AT Training", "", {_player setPosATL (getPosATL MOS_ATRangeInteract)}, {true}] call ace_interact_menu_fnc_createAction;

{[MOSInterface, 0, ["ACE_MainActions"], _x, true] call ace_interact_menu_fnc_addActionToObject} forEach [_toShootRange, _toMarksman, _toAT];

_MOSReturn = ["MOS_return", "Return to Base", "", {_player setPosATL (getPosATL MOSInterface)}, {true}] call ace_interact_menu_fnc_createAction;
{[_x, 0, ["ACE_MainActions"], _MOSReturn, true] call ace_interact_menu_fnc_addActionToObject;} forEach MOSTrainingInterfaces;

//=============MOS-AT Range=============\\
_ATSpawnLandTarget = ["AT_spawn_land_target", "Spawn Land Target", "", {[] spawn Co2T_fnc_mosATLand}, {true}] call ace_interact_menu_fnc_createAction;
[MOS_ATRangeInteract, 0, ["ACE_MainActions"], _ATSpawnLandTarget, true] call ace_interact_menu_fnc_addActionToObject;

_ATEnableSmoke = ["AT_enableSmoke", "Enable Smoke", "", {MOS_ATRangeInteract setVariable ["enableSmoke", true]}, {!(MOS_ATRangeInteract getVariable "enableSmoke")}] call ace_interact_menu_fnc_createAction;
[MOS_ATRangeInteract, 0, ["ACE_MainActions"], _ATEnableSmoke, true] call ace_interact_menu_fnc_addActionToObject;

_ATDisableSmoke = ["AT_disableSmoke", "Disable Smoke", "", {MOS_ATRangeInteract setVariable ["enableSmoke", false]}, {MOS_ATRangeInteract getVariable "enableSmoke"}] call ace_interact_menu_fnc_createAction;
[MOS_ATRangeInteract, 0, ["ACE_MainActions"], _ATDisableSmoke, true] call ace_interact_menu_fnc_addActionToObject;

_ATDistance = ["AT_distance", "Max Target Distance", "", {}, {true}] call ace_interact_menu_fnc_createAction;
[MOS_ATRangeInteract, 0, ["ACE_MainActions"], _ATDistance, true] call ace_interact_menu_fnc_addActionToObject;

_ATDistance1500 = ["1500", "1500 Meters", "", {MOS_ATRangeInteract setVariable ["maxDistance", 1500, true]}, {(MOS_ATRangeInteract getVariable "maxDistance") != 1500}] call ace_interact_menu_fnc_createAction;
_ATDistance1250 = ["1250", "1250 Meters", "", {MOS_ATRangeInteract setVariable ["maxDistance", 1250, true]}, {(MOS_ATRangeInteract getVariable "maxDistance") != 1250}] call ace_interact_menu_fnc_createAction;
_ATDistance1000 = ["1000", "1000 Meters", "", {MOS_ATRangeInteract setVariable ["maxDistance", 1000, true]}, {(MOS_ATRangeInteract getVariable "maxDistance") != 1000}] call ace_interact_menu_fnc_createAction;
_ATDistance900 = ["900", "900 Meters", "", {MOS_ATRangeInteract setVariable ["maxDistance", 900, true]}, {(MOS_ATRangeInteract getVariable "maxDistance") != 900}] call ace_interact_menu_fnc_createAction;
_ATDistance800 = ["800", "800 Meters", "", {MOS_ATRangeInteract setVariable ["maxDistance", 800, true]}, {(MOS_ATRangeInteract getVariable "maxDistance") != 800}] call ace_interact_menu_fnc_createAction;
_ATDistance700 = ["700", "700 Meters", "", {MOS_ATRangeInteract setVariable ["maxDistance", 700, true]}, {(MOS_ATRangeInteract getVariable "maxDistance") != 700}] call ace_interact_menu_fnc_createAction;
_ATDistance600 = ["600", "600 Meters", "", {MOS_ATRangeInteract setVariable ["maxDistance", 600, true]}, {(MOS_ATRangeInteract getVariable "maxDistance") != 600}] call ace_interact_menu_fnc_createAction;
_ATDistance500 = ["500", "500 Meters", "", {MOS_ATRangeInteract setVariable ["maxDistance", 500, true]}, {(MOS_ATRangeInteract getVariable "maxDistance") != 500}] call ace_interact_menu_fnc_createAction;
_ATDistance400 = ["400", "400 Meters", "", {MOS_ATRangeInteract setVariable ["maxDistance", 400, true]}, {(MOS_ATRangeInteract getVariable "maxDistance") != 400}] call ace_interact_menu_fnc_createAction;
_ATDistance300 = ["300", "300 Meters", "", {MOS_ATRangeInteract setVariable ["maxDistance", 300, true]}, {(MOS_ATRangeInteract getVariable "maxDistance") != 300}] call ace_interact_menu_fnc_createAction;
_ATDistance200 = ["200", "200 Meters", "", {MOS_ATRangeInteract setVariable ["maxDistance", 200, true]}, {(MOS_ATRangeInteract getVariable "maxDistance") != 200}] call ace_interact_menu_fnc_createAction;
{[MOS_ATRangeInteract, 0, ["ACE_MainActions", "AT_distance"], _x, true] call ace_interact_menu_fnc_addActionToObject;} forEach [_ATDistance200, _ATDistance300, _ATDistance400, _ATDistance500, _ATDistance600, _ATDistance700, _ATDistance800, _ATDistance900, _ATDistance1000, _ATDistance1250, _ATDistance1500];

//=============Vehicle Pools=============\\
_baseVehiclePool = ["base_vehiclePool", "Spawn Vehicles", "", {[[t_landVehicles1, t_landVehicles2, t_landVehicles3], landVehicles] call Co2T_fnc_vehPoolDialogCreate}, {true}] call ace_interact_menu_fnc_createAction;
[vehicleLandPoolInteract, 0, ["ACE_MainActions"], _baseVehiclePool, true] call ace_interact_menu_fnc_addActionToObject;

_baseHeloVehiclePool = ["base_airVehiclePool", "Spawn Vehicles", "", {[[t_heloVehicles1, t_heloVehicles2, t_heloVehicles3, t_heloVehicles4, t_heloVehicles5, t_heloVehicles6, t_heloVehicles7, t_heloVehicles8], (smallAviationVehicles + mediumAviationVehicles)] call Co2T_fnc_vehPoolDialogCreate}, {true}] call ace_interact_menu_fnc_createAction;
[vehicleHeloPoolInteract, 0, ["ACE_MainActions"], _baseHeloVehiclePool, true] call ace_interact_menu_fnc_addActionToObject;

//=============Arsenals=============\\
_arsenalSaveLoadout = ["arsenal_saveLoadout", "Save Loadout", "", {
	_player setVariable ["loadout", getUnitLoadout _player];
	_player setVariable ["customLoadout", true];
	[_player] remoteExec ["Co2T_fnc_loadoutCheck", _player];
}, {true}] call ace_interact_menu_fnc_createAction;
{[_x, 0, ["ACE_MainActions"], _arsenalSaveLoadout, true] call ace_interact_menu_fnc_addActionToObject;} forEach arsenal;

_arsenalFetchLoadout = ["arsenal_fetchLoadout", "Retrieve Loadout", "", {
	private _loadout = _player getVariable ["loadout", getUnitLoadout _player];
	removeAllWeapons _player;
	removeGoggles _player;
	removeHeadgear _player;
	removeVest _player;
	removeUniform _player;
	removeAllAssignedItems _player;
	clearAllItemsFromBackpack _player;
	removeBackpack _player;
	_player setUnitLoadout _loadout;
}, {
	private _loadout = _player getVariable ["loadout", nil];
	!isNil "_loadout"
}] call ace_interact_menu_fnc_createAction;
{[_x, 0, ["ACE_MainActions"], _arsenalFetchLoadout, true] call ace_interact_menu_fnc_addActionToObject;} forEach arsenal;

_arsenalDeleteLoadout = ["arsenal_deleteLoadout", "Delete Saved Loadout", "", {
	_player setVariable ["loadout", nil];
	_player setVariable ["customLoadout", false];
}, {true}] call ace_interact_menu_fnc_createAction;
{[_x, 0, ["ACE_MainActions"], _arsenalDeleteLoadout, true] call ace_interact_menu_fnc_addActionToObject;} forEach arsenal;

//=============Briefing (how to use)=============\\
player createDiarySubject ["areaExp", "Areas Explanation"];

player createDiaryRecord ["Diary", ["Training Map", "Welcome to the Bravo Company, 2nd Marine Raider Battalion training map!"]];

player createDiaryRecord ["areaExp", ["WIP", "This section is work in progress..."]];

//=============Hash Table Setup=============\\
waitUntil {{!isNil _x} forEach ["shootHouseScoreboard", "rogainingScoreboard"]};
_shoothouseStatus = profileNamespace getVariable ["shootHouseStatus", [0, 0, 0, 0]];
_rogainingStatus = profileNamespace getVariable ["rogainingStatus", [0, 0, 0]]; 
shootHouseScoreboard set [getPlayerUID player, _shoothouseStatus]; 
rogainingScoreboard set [getPlayerUID player, _rogainingStatus]; 
{publicVariable _x} forEach ["shootHouseScoreboard", "rogainingScoreboard"]; // this is most probably going to break because of requests being put in at the same time

waitUntil {getClientStateNumber == 9};
systemChat "Training Map Version 0.3.0 Initialized Successfully.";

[] spawn {
	while {true} do {
		waitUntil {player inArea t_arsenalCheck};
		waitUntil {!(player inArea t_arsenalCheck)};
		[player] remoteExec ["Co2T_fnc_loadoutCheck", player];
	};
};