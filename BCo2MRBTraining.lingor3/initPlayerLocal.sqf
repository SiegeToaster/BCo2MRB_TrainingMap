waitUntil {!isNil "formationControllers" && !isNil "shootHousePlayerInterfaces" && !isNil "shootHouseSpectatorInterfaces" && !isNil "shootingRangeTargets" && !isNil "MOSTrainingInterfaces"};

//=============Player Variables=============\\

player setVariable ["scoreArray",[]];
player setVariable ["totalScore",[0,0]];
player setVariable ["loadout", nil];
player setVariable ["customLoadout", false];

//=============ACE Interactions=============\\

//=============Shoothouse Interactions=============\\
_start = ["start_root", "Start Shoot Houses", "", {}, {true}] call ace_interact_menu_fnc_createAction;
[startInterface, 0, ["ACE_MainActions"], _start, true] call ace_interact_menu_fnc_addActionToObject;

_startPit = ["start_pit", "Start The Pit", "", {location = pitSpawn; publicVariable "location"; ["scripts\shootHouse.sqf"] remoteExec ["execVM", 2];}, {!(pitSpawn getVariable "inProgress")}] call ace_interact_menu_fnc_createAction;
[startInterface, 0, ["ACE_MainActions", "start_root"], _startPit, true] call ace_interact_menu_fnc_addActionToObject;

_startConsulate = ["start_consulate", "Start Consulate", "", {location = consulateSpawn; publicVariable "location"; ["scripts\shootHouse.sqf"] remoteExec ["execVM", 2];}, {!(consulateSpawn getVariable "inProgress")}] call ace_interact_menu_fnc_createAction;
[startInterface, 0, ["ACE_MainActions", "start_root"], _startConsulate, true] call ace_interact_menu_fnc_addActionToObject;

_startSH1 = ["start_sh1", "Start Shoot House 1", "", {location = sh1Spawn; publicVariable "location"; ["scripts\shootHouse.sqf"] remoteExec ["execVM", 2];}, {!(sh1Spawn getVariable "inProgress")}] call ace_interact_menu_fnc_createAction;
[startInterface, 0, ["ACE_MainActions", "start_root"], _startSH1, true] call ace_interact_menu_fnc_addActionToObject;

_startSH2 = ["start_sh2", "Start Shoot House 2", "", {location = sh2Spawn; publicVariable "location"; ["scripts\shootHouse.sqf"] remoteExec ["execVM", 2];}, {!(sh2Spawn getVariable "inProgress")}] call ace_interact_menu_fnc_createAction;
[startInterface, 0, ["ACE_MainActions", "start_root"], _startSH2, true] call ace_interact_menu_fnc_addActionToObject;

_return = ["return", "Return to Base", "", {_player setPosATL (getPosATL startArea); [objNull, _player] call ace_medical_treatment_fnc_fullHeal;}, {true}] call ace_interact_menu_fnc_createAction;
{[_x, 0, ["ACE_MainActions"], _return, true] call ace_interact_menu_fnc_addActionToObject;} forEach shootHousePlayerInterfaces;
/*
//=============Shoothouse Spectator Actions=============\\
_spectate = ["spectate_root", "Spectate", "", {}, {true}] call ace_interact_menu_fnc_createAction;
{[_x, 0, ["ACE_MainActions"], _spectate, true] call ace_interact_menu_fnc_addActionToObject;} forEach shootHouseSpectatorInterfaces;

_spectatePit = ["spectate_pit", "Spectate The Pit", "", {}, {true}] call ace_interact_menu_fnc_createAction;
{[_x, 0, ["ACE_MainActions", "spectate_root"], _spectatePit, true] call ace_interact_menu_fnc_addActionToObject;} forEach [spectateInterface, pitNorthSpectator, pitSouthSpectator];

_spectatePitNorth = ["spectate_pit_north", "North", "", {_player setCaptive true; _player allowDamage false; _player setPosATL (getPosATL pitNorthSpectator);}, {true}] call ace_interact_menu_fnc_createAction;
{[_x, 0, ["ACE_MainActions", "spectate_root", "spectate_pit"], _spectatePitNorth, true] call ace_interact_menu_fnc_addActionToObject;} forEach [spectateInterface, pitSouthSpectator];

_spectatePitSouth = ["spectate_pit_south", "South", "", {_player setCaptive true; _player allowDamage false; _player setPosATL (getPosATL pitSouthSpectator);}, {true}] call ace_interact_menu_fnc_createAction;
{[_x, 0, ["ACE_MainActions", "spectate_root", "spectate_pit"], _spectatePitSouth, true] call ace_interact_menu_fnc_addActionToObject;} forEach [spectateInterface, pitNorthSpectator];

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

_spectateReturn = ["spectate_return", "Return to Base", "", {_player setCaptive false; _player allowDamage true; _player setPosATL (getPosATL spectateInterface)}, {true}] call ace_interact_menu_fnc_createAction;
{[_x, 0, ["ACE_MainActions", "spectate_root"], _spectateReturn, true] call ace_interact_menu_fnc_addActionToObject;} forEach shootHouseSpectatorInterfaces - [spectateInterface];

*///=============Rogaining Actions=============\\
_rogain = ["rogain_root", "Rogaining", "", {}, {true}] call ace_interact_menu_fnc_createAction;
[rogaineInterface, 0, ["ACE_MainActions"], _rogain, true] call ace_interact_menu_fnc_addActionToObject;

_rogainStart = ["rogain_start", "Start", "", {["scripts\rogaining.sqf"] remoteExec ["execVM", 2];}, {!(srt_rogain getVariable "inProgress")}] call ace_interact_menu_fnc_createAction;
[rogaineInterface, 0, ["ACE_MainActions", "rogain_root"], _rogainStart, true] call ace_interact_menu_fnc_addActionToObject;

_difficulty = ["difficulty_root", "Difficulty", "", {}, {!(srt_rogain getVariable "inProgress")}] call ace_interact_menu_fnc_createAction;
[rogaineInterface, 0, ["ACE_MainActions", "rogain_root"], _difficulty, true] call ace_interact_menu_fnc_addActionToObject;

_difficultyEasy = ["difficulty_easy", "Easy", "", {diff = "Easy"; publicVariable "diff";}, {true}] call ace_interact_menu_fnc_createAction;
[rogaineInterface, 0, ["ACE_MainActions", "rogain_root", "difficulty_root"], _difficultyEasy, true] call ace_interact_menu_fnc_addActionToObject;

_difficultyNormal = ["difficulty_normal", "Normal", "", {diff = "Normal"; publicVariable "diff";}, {true}] call ace_interact_menu_fnc_createAction;
[rogaineInterface, 0, ["ACE_MainActions", "rogain_root", "difficulty_root"], _difficultyNormal, true] call ace_interact_menu_fnc_addActionToObject;

_difficultyHard = ["difficulty_normal", "Hard", "", {diff = "Hard"; publicVariable "diff";}, {true}] call ace_interact_menu_fnc_createAction;
[rogaineInterface, 0, ["ACE_MainActions", "rogain_root", "difficulty_root"], _difficultyHard, true] call ace_interact_menu_fnc_addActionToObject;

/*//=============50-150 Shooting Range Actions=============\\
rangeHideLeftFunction = {{hideObject _x} forEach ((getMissionLayerEntities "LeftClose") select 0) + ((getMissionLayerEntities "LeftMedium") select 0) + ((getMissionLayerEntities "LeftFar") select 0)};
rangeHideMiddleFunction = {{hideObject _x} forEach ((getMissionLayerEntities "MiddleClose") select 0) + ((getMissionLayerEntities "MiddleMedium") select 0) + ((getMissionLayerEntities "MiddleFar") select 0)};
rangeHideRightFunction = {{hideObject _x} forEach ((getMissionLayerEntities "RightClose") select 0) + ((getMissionLayerEntities "RightMedium") select 0) + ((getMissionLayerEntities "RightFar") select 0)};
{_x remoteExec ["call", 0, true];} forEach [rangeHideLeftFunction, rangeHideMiddleFunction, rangeHideRightFunction];

_rangeLeft = ["range_left_root", "Shooting Range", "", {}, {true}] call ace_interact_menu_fnc_createAction;
[sRangeLeftInteract, 0, ["ACE_MainActions"], _rangeLeft, true] call ace_interact_menu_fnc_addActionToObject;

_rangeLeftHide = ["range_left_hide", "Hide All", "", {rangeHideLeftFunction remoteExec ["call", 0, true];}, {true}] call ace_interact_menu_fnc_createAction;
[sRangeLeftInteract, 0, ["ACE_MainActions", "range_left_root"], _rangeLeftHide, true] call ace_interact_menu_fnc_addActionToObject;

_rangeLeftClose = ["range_left_close", "50 Meter Target", "", {
	rangeHideLeftFunction remoteExec ["call", 0, true];

	{{_x hideObject false} forEach ((getMissionLayerEntities "LeftClose") select 0)} remoteExec ["call", 0, true];
}, {true}] call ace_interact_menu_fnc_createAction;
[sRangeLeftInteract, 0, ["ACE_MainActions", "range_left_root"], _rangeLeftClose, true] call ace_interact_menu_fnc_addActionToObject;

_rangeLeftMedium = ["range_left_medium", "100 Meter Target", "", {
	rangeHideLeftFunction remoteExec ["call", 0, true];

	{{_x hideObject false} forEach ((getMissionLayerEntities "LeftMedium") select 0)} remoteExec ["call", 0, true];
}, {true}] call ace_interact_menu_fnc_createAction;
[sRangeLeftInteract, 0, ["ACE_MainActions", "range_left_root"], _rangeLeftMedium, true] call ace_interact_menu_fnc_addActionToObject;

_rangeLeftFar = ["range_left_far", "200 Meter Target", "", {
	rangeHideLeftFunction remoteExec ["call", 0, true];

	{{_x hideObject false} forEach ((getMissionLayerEntities "LeftFar") select 0)} remoteExec ["call", 0, true];
}, {true}] call ace_interact_menu_fnc_createAction;
[sRangeLeftInteract, 0, ["ACE_MainActions", "range_left_root"], _rangeLeftFar, true] call ace_interact_menu_fnc_addActionToObject;


_rangeMiddle = ["range_middle_root", "Shooting Range", "", {}, {true}] call ace_interact_menu_fnc_createAction;
[sRangeMiddleInteract, 0, ["ACE_MainActions"], _rangeMiddle, true] call ace_interact_menu_fnc_addActionToObject;

_rangeMiddleHide = ["range_middle_hide", "Hide All", "", {rangeHideMiddleFunction remoteExec ["call", 0, true];}, {true}] call ace_interact_menu_fnc_createAction;
[sRangeMiddleInteract, 0, ["ACE_MainActions", "range_middle_root"], _rangeMiddleHide, true] call ace_interact_menu_fnc_addActionToObject;

_rangeMiddleClose = ["range_middle_close", "50 Meter Target", "", {
	rangeHideMiddleFunction remoteExec ["call", 0, true];

	{{_x hideObject false} forEach ((getMissionLayerEntities "MiddleClose") select 0)} remoteExec ["call", 0, true];
}, {true}] call ace_interact_menu_fnc_createAction;
[sRangeMiddleInteract, 0, ["ACE_MainActions", "range_middle_root"], _rangeMiddleClose, true] call ace_interact_menu_fnc_addActionToObject;

_rangeMiddleMedium = ["range_middle_medium", "100 Meter Target", "", {
	rangeHideMiddleFunction remoteExec ["call", 0, true];

	{{_x hideObject false} forEach ((getMissionLayerEntities "MiddleMedium") select 0)} remoteExec ["call", 0, true];
}, {true}] call ace_interact_menu_fnc_createAction;
[sRangeMiddleInteract, 0, ["ACE_MainActions", "range_middle_root"], _rangeMiddleMedium, true] call ace_interact_menu_fnc_addActionToObject;

_rangeMiddleFar = ["range_middle_far", "200 Meter Target", "", {
	rangeHideMiddleFunction remoteExec ["call", 0, true];

	{{_x hideObject false} forEach ((getMissionLayerEntities "MiddleFar") select 0)} remoteExec ["call", 0, true];
}, {true}] call ace_interact_menu_fnc_createAction;
[sRangeMiddleInteract, 0, ["ACE_MainActions", "range_middle_root"], _rangeMiddleFar, true] call ace_interact_menu_fnc_addActionToObject;


_rangeRight = ["range_right_root", "Shooting Range", "", {}, {true}] call ace_interact_menu_fnc_createAction;
[sRangeRightInteract, 0, ["ACE_MainActions"], _rangeRight, true] call ace_interact_menu_fnc_addActionToObject;

_rangeRightHide = ["range_right_hide", "Hide All", "", {rangeHideRightFunction remoteExec ["call", 0, true];}, {true}] call ace_interact_menu_fnc_createAction;
[sRangeRightInteract, 0, ["ACE_MainActions", "range_right_root"], _rangeRightHide, true] call ace_interact_menu_fnc_addActionToObject;

_rangeRightClose = ["range_right_close", "50 Meter Target", "", {
	rangeHideRightFunction remoteExec ["call", 0, true];

	{{_x hideObject false} forEach ((getMissionLayerEntities "RightClose") select 0)} remoteExec ["call", 0, true];
}, {true}] call ace_interact_menu_fnc_createAction;
[sRangeRightInteract, 0, ["ACE_MainActions", "range_right_root"], _rangeRightClose, true] call ace_interact_menu_fnc_addActionToObject;

_rangeRightMedium = ["range_right_medium", "100 Meter Target", "", {
	rangeHideRightFunction remoteExec ["call", 0, true];

	{{_x hideObject false} forEach ((getMissionLayerEntities "RightMedium") select 0)} remoteExec ["call", 0, true];
}, {true}] call ace_interact_menu_fnc_createAction;
[sRangeRightInteract, 0, ["ACE_MainActions", "range_right_root"], _rangeRightMedium, true] call ace_interact_menu_fnc_addActionToObject;

_rangeRightFar = ["range_right_far", "200 Meter Target", "", {
	rangeHideRightFunction remoteExec ["call", 0, true];

	{{_x hideObject false} forEach ((getMissionLayerEntities "RightFar") select 0)} remoteExec ["call", 0, true];
}, {true}] call ace_interact_menu_fnc_createAction;
[sRangeRightInteract, 0, ["ACE_MainActions", "range_right_root"], _rangeRightFar, true] call ace_interact_menu_fnc_addActionToObject;


_rangeClearScore = ["range_clearScore", "Clear Score", "", {
	_player setVariable ["scoreArray", []];
	_player setVariable ["totalScore", [0, 0]];
	systemChat format ["%1 score cleared.", name _player];
}, {true}] call ace_interact_menu_fnc_createAction;
[sRangeLeftInteract, 0, ["ACE_MainActions", "range_left_root"], _rangeClearScore, true] call ace_interact_menu_fnc_addActionToObject;
[sRangeMiddleInteract, 0, ["ACE_MainActions", "range_middle_root"], _rangeClearScore, true] call ace_interact_menu_fnc_addActionToObject;
[sRangeRightInteract, 0, ["ACE_MainActions", "range_right_root"], _rangeClearScore, true] call ace_interact_menu_fnc_addActionToObject;

_rangeShowScore = ["range_showScore", "Show Score", "", {
	if (((_player getVariable "totalScore") select 0) > 0) then {
		[format ["%1 scored %2 points in %4 shots with an average of %3 points per shot.", name _player, (_player getVariable "totalScore") select 0, round (((_player getVariable "totalScore") select 0) / ((_player getVariable "totalScore") select 1)), (_player getVariable "totalScore") select 1]] remoteExec ["systemChat", 0];
	} else {
		systemChat "No score has been logged yet.";
	}
}, {true}] call ace_interact_menu_fnc_createAction;
[sRangeLeftInteract, 0, ["ACE_MainActions", "range_left_root"], _rangeShowScore, true] call ace_interact_menu_fnc_addActionToObject;
[sRangeMiddleInteract, 0, ["ACE_MainActions", "range_middle_root"], _rangeShowScore, true] call ace_interact_menu_fnc_addActionToObject;
[sRangeRightInteract, 0, ["ACE_MainActions", "range_right_root"], _rangeShowScore, true] call ace_interact_menu_fnc_addActionToObject;

//=============MOS Interface Actions=============\\
_toAT = ["to_AT", "Teleport to AT Training", "", {_player setPosATL (getPosATL ATRange)}, {true}] call ace_interact_menu_fnc_createAction;
[MOSInterface, 0, ["ACE_MainActions"], _toAT, true] call ace_interact_menu_fnc_addActionToObject;

_toMarksman = ["to_Marksman", "Teleport to Marksman Range (WiP!)", "", {_player setPosATL (getPosATL marksmanRange)}, {true}] call ace_interact_menu_fnc_createAction;
[MOSInterface, 0, ["ACE_MainActions"], _toMarksman, true] call ace_interact_menu_fnc_addActionToObject;

_MOSReturn = ["MOS_return", "Return to Base", "", {_player setPosATL (getPosATL MOSInterface)}, {true}] call ace_interact_menu_fnc_createAction;
{[_x, 0, ["ACE_MainActions"], _MOSReturn, true] call ace_interact_menu_fnc_addActionToObject;} forEach MOSTrainingInterfaces;

//=============Vehicle Pools=============\\
_baseVehiclePool = ["base_vehiclePool", "Spawn Vehicles", "", {[[t_infBaseSpawn1, t_infBaseSpawn2], landVehicles] call Co2T_fnc_vehPoolDialogCreate}, {true}] call ace_interact_menu_fnc_createAction;
[vehiclePoolInteract, 0, ["ACE_MainActions"], _baseVehiclePool, true] call ace_interact_menu_fnc_addActionToObject;

_baseAirVehiclePool = ["base_airVehiclePool", "Spawn Vehicles", "", {[[t_infBaseAirSpawn], (smallAviationVehicles + mediumAviationVehicles)] call Co2T_fnc_vehPoolDialogCreate}, {true}] call ace_interact_menu_fnc_createAction;
[vehicleAirPoolInteract, 0, ["ACE_MainActions"], _baseAirVehiclePool, true] call ace_interact_menu_fnc_addActionToObject;

_destroyerAirVehiclePool = ["destroyer_airVehiclePool", "Spawn Vehicles", "", {[[t_libertySpawn], smallAviationVehicles] call Co2T_fnc_vehPoolDialogCreate}, {true}] call ace_interact_menu_fnc_createAction;
[destroyerAirPoolInteract, 0, ["ACE_MainActions"], _destroyerAirVehiclePool, true] call ace_interact_menu_fnc_addActionToObject;


//=============MOS-AT Range=============\\
_ATSpawnLandTarget = ["AT_spawn_land_target", "Spawn Land Target", "", {["scripts\MOS\ATLand.sqf"] remoteExec ["execVM", 2];}, {true}] call ace_interact_menu_fnc_createAction;
[ATRange, 0, ["ACE_MainActions"], _ATSpawnLandTarget, true] call ace_interact_menu_fnc_addActionToObject;

*///=============Briefing (how to use)=============\\
player createDiarySubject ["areaExp", "Areas Explanation"];

player createDiaryRecord ["Diary", ["Training Map", "This is a general tutorial for all of the things unique to this mission.  An in depth explanation of all areas can be found in the 'Areas Explanation' Tab.<br></br><br></br>The infantry base is located at the Pyrgos military base.  There are connections to the airbase (WIP), aircraft carrier (WIP), and LHD (WIP).  From here, you can access all of the facilities that are offered on the island such as the shoothouse, MOS training areas (WIP), and rogaining course.<br></br>To use any of the display panels, you must use your ACE interaction key (windows key by default), hover over the display panel, and select the option you want.  All display panels will be about chest height on 2 legs with a white display.<br></br><br></br>There are 3 shoothouses, 2 ordinary ones and 1 resembles a city street.  The two ordinary shoothouses are called 'Shoothouse 1' and 'Shoothouse 2,' while the city street is called 'The Pit.'  Both ordinary shoothouses can hold up to 6 players, while The Pit can hold 9.  All of the shoothouses have 2 spectator buildings on either side that can hold as many people as can fit inside.<br></br>The formations area has 11 slots (including the formation leader) for all formations.  It has the wedge, line, column/file, and staggered column formations.<br></br>The rogaining area is a land navigation course with 10 waypoints.  The objective is to navigate you and your team (should you choose to have one) through the entire course.  A checkpoint will never be more than 1 kilometer away from the previous one. It can accommodate as many people as can fit inside of the activation circle.<br></br><br></br>More to come! I hope you enjoy.<br></br><br></br><img image='images\insignia.paa' width='200' height='200'/>"]];

player createDiaryRecord ["areaExp", ["WIP", "This section is work in progress..."]];