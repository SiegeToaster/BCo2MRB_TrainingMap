enemyGroup = createGroup east; // for enemies in shoothouse.

//=============Ace Action Variables=============\\
shootHouseSpectatorInterfaces = [spectateInterface, pitNorthSpectator, pitSouthSpectator];
// deleted vars ^ = sh1EastSpectator, sh1WestSpectator, sh2EastSpectator, sh2WestSpectator
shootHousePlayerInterfaces = [pitInteraction, shoothouse1Interaction, shoothouse2Interaction, shoothouse3Interaction];
MOSTrainingInterfaces = [sRangeInteract, sRangeLongInteract, MOS_ATRangeInteract];

//=============Settings Variables=============\\
ATLandDistance = 1500;
shootHouseMode = "this disableAI 'PATH';";
shootHouseDifficulty = "medium";

//=============Vehicle Spawner Vehicles=============\\
landVehicles = [["Unarmed HMMWV", "rhsusf_m1025_w_s"], ["Transport HMMWV", "rhsusf_m998_w_s_2dr_halftop"], ["HMMWV (M2)", "rhsusf_m1025_w_s_m2"], ["HMMWV (Mk19)", "rhsusf_m1025_w_s_Mk19"], ["HMMWV (M134D, x2 M240)", "rhsusf_m1165a1_gmv_m134d_m240_socom_d", "rhs_sofwoodland"], ["HMMWV (M2, x2 M240)", "rhsusf_m1165a1_gmv_m2_m240_socom_d", "rhs_sofwoodland"], ["HMMWV (Mk19, x2 M240)", "rhsusf_m1165a1_gmv_mk19_m240_socom_d", "rhs_sofwoodland"], ["MRZR 4", "rhsusf_mrzr4_d", "Olive"], ["Olive Unarmed Jeep Wrangler", "I_C_Offroad_02_unarmed_F", "Olive"], ["Olive Jeep Wrangler (LMG)", "I_C_Offroad_02_LMG_F", "Olive"], ["Olive Jeep Wrangler (SPG-9)", "I_C_Offroad_02_AT_F", "Olive"], ["Unarmed MRAP", "rhsusf_m1240a1_usmc_wd"], ["MRAP (M240)", "rhsusf_m1240a1_m240_usmc_wd"], ["MRAP (M2)", "rhsusf_m1240a1_m2_usmc_wd"], ["MRAP (Mk19)", "rhsusf_m1240a1_mk19_usmc_wd"], ["MRAP (CROWS M2)", "rhsusf_m1240a1_m2crows_usmc_wd"], ["MRAP (CROWS Mk19)", "rhsusf_m1240a1_mk19crows_usmc_wd"], ["MRAP 6x6 (M2)", "rhsusf_M1232_MC_M2_usmc_wd"], ["MRAP 6x6 (Mk19)", "rhsusf_M1232_MC_MK19_usmc_wd"]];
seaVehicles = [["Assault Boat", "B_Boat_Transport_01_F"], ["RHIB", "rhsgref_hidf_rhib"], ["Speedboat Minigun", "B_Boat_Armed_01_minigun_F"], ["Mk.V SOC", "rhsusf_mkvsoc"]];
smallAviationVehicles = [["Unarmed UH-1Y", "RHS_UH1Y_UNARMED"], ["UH-1Y (Rockets)", "RHS_UH1Y_FFAR"], ["UH-1Y (Rockets & Guns)", "RHS_UH1Y"], ["Unarmed Little Bird (OH-6M)", "RHS_MELB_H6M"], ["Transport Little Bird (MH-6M)", "RHS_MELB_MH6M"], ["Little Bird (Rockets & Guns) (AH-6M)", "RHS_MELB_AH6M"], ["MH-60M", "Dpy_mh60L"], ["HH-60G/M Pavehawk (Grey)", "vtx_HH60"], ["MH-60M (Black)", "vtx_MH60M"], ["MH-60M DAP (Armed)", "vtx_MH60M_DAP"], ["MH-60S Knighthawk", "vtx_MH60S"], ["MH-60S Knighthawk (GAU-21)", "vtx_MH60S_GAU21L"], ["MH-60S Knighthawk (Armed)", "vtx_MH60S_Pylons"], ["UH-60M Blackhawk", "vtx_UH60M"], ["UH-60M (Unarmed)", "vtx_UH60M_SLICK"]];
mediumAviationVehicles = [["CH-53E", "rhsusf_CH53E_USMC"], ["CH-53E (Cargo)", "rhsusf_CH53e_USMC_cargo"], ["CH-53E (GAU-21)", "rhsusf_CH53E_USMC_GAU21"], ["CH-47F", "RHS_CH_47F_10"], ["CH-47F (Cargo)", "RHS_CH_47F_10_cargo"], ["MH-47E", "kyo_MH47E_base"], ["MH-47G", "kyo_MH47E_HC"]];

//=============Consecutive Object Variable Arrays=============\\
sh1Pos = [];
sh2Pos = [];
sh3Pos = [];
sh3TurretPos = [];
pitPos = [];
consulatePos = [];
{
	private _i = 1;
	private _array = missionNamespace getVariable _x;

	while {!(isNil {missionNamespace getVariable format ["%1_%2", _x, _i]})} do {
		private _unit = missionNamespace getVariable format ["%1_%2", _x, _i];
		_array pushBack _unit;
		_i = _i + 1;
	};
} forEach ["sh1Pos", "sh2Pos", "sh3Pos", "sh3TurretPos", "pitPos", "consulatePos"];
shootingRangeTargets = [rangeTarget1, rangeTarget2, rangeTarget3, rangeTarget4, rangeTarget5, rangeTarget6, rangeTarget7, rangeTarget8, rangeTarget9, rangeTarget10, rangeTarget11, rangeTarget12, rangeTarget13, rangeTarget14, rangeTarget15, rangeTarget16];

{publicVariable _x} forEach ["shootHouseSpectatorInterfaces", "shootHousePlayerInterfaces", "MOSTrainingInterfaces", "diff", "amount", "ATLandDistance", "shootHouseMode", "shootHouseDifficulty", "landVehicles", "seaVehicles", "smallAviationVehicles", "mediumAviationVehicles", "shootingRangeTargets", "sh1Pos", "sh2Pos", "sh3Pos", "sh3TurretPos"];

pitSpawn setVariable ["triggerName", t_Pit, true];
pitSpawn setVariable ["spawnPoints", pitPos, true];
sh1Spawn setVariable ["triggerName", t_SH1, true];
sh1Spawn setVariable ["spawnPoints", sh1Pos, true];
sh2Spawn setVariable ["triggerName", t_SH2, true];
sh2Spawn setVariable ["spawnPoints", sh2Pos, true];
sh3Spawn setVariable ["triggername", [[6904.54,9330.45,0],[6885.79,9314.8,0],[6878.09,9323.49,0],[6876.79,9320.19,0],[6800.65,9254.09,0],[6791.77,9264.14,0],[6779.66,9255.15,0],[6771.6,9264.56,0],[6767.85,9261.62,0],[6771.72,9256.96,0],[6763.94,9250.98,0],[6760.39,9255.39,0],[6751.43,9247.95,0],[6725.14,9277.91,0],[6731.1,9282.65,0],[6728.81,9285.7,0],[6747.73,9301.26,0],[6746.51,9303.15,0],[6758.93,9313.84,0],[6746.6,9327.56,0],[6709.88,9330.3,0],[6711.75,9380.28,0],[6767.13,9378.93,0],[6766.8,9363.62,0],[6763.6,9340.44,0],[6775.77,9327.2,0],[6788.26,9338.57,0],[6807.79,9351.79,0],[6815.17,9354.79,0],[6830.49,9358.64,0],[6834.73,9358.86,0],[6838.4,9356.09,0],[6854.09,9334.95,0],[6880.52,9357.82,0]], true];
sh3Spawn setVariable ["spawnPoints", sh3Pos, true];
sh3Spawn setVariable ["turretSpawnPoints", sh3TurretPos, true];
consulateSpawn setVariable ["triggerName", t_Consulate, true];
consulateSpawn setVariable ["spawnPoints", consulatePos, true];

shootRangeLeftLogic setVariable ["distancePosition", 100, true];
shootRangeMiddleLogic setVariable ["distancePosition", 100, true];
shootRangeRightLogic setVariable ["distancePosition", 100, true];
shootRangeLongLogic setVariable ["distancePosition", 400, true];

MOS_ATRangeInteract setVariable ["enableSmoke", true, true];

{_x setVariable ["inProgress", false, true];} forEach [pitSpawn, sh1Spawn, sh2Spawn, sh3Spawn, consulateSpawn, srt_rogain];
{
	_x addEventHandler ["HitPart", {
		private _shooter = (_this select 0 select 1);
		private _position = (_this select 0 select 3);
		private _scoreArray = _shooter getVariable "scoreArray"; // sets the target that got shot, the person who shot and their current score info, and where the bullet hit.

		private _bullet = (_this select 0 select 0) worldToModel (ASLToATL _position);
		private _axisX = abs (((_bullet select 0) * 100)) + 0.1108644;
		private _axisY = abs (((_bullet select 2) * 100) + 2.3956);
		private _sqr = sqrt ((_axisX ^ 2) + (_axisY ^ 2));
		
		if (_sqr < 28) then {
			[_position] spawn {
				_marker = "Sign_Sphere10cm_F" createVehicle [0,0,0];
				_marker setObjectScale 0.5;
				_marker setPosASL (_this select 0);
				sleep 5;
				deleteVehicle _marker;
			}; // creates marker where the bullet hits if it hits the target.
		};
		private _score = 0;

		if (_sqr < 28) then {
			if (_sqr < 2.5) then {
				_score = 5;
			} else {
				if (_sqr < 6) then {
					_score = 4;
				} else {
					if (_sqr < 13) then {
						_score = 3;
					} else {
						if (_sqr < 20) then {
							_score = 2;
						} else {
							if (_sqr < 26) then {
								_score = 1;
							};
						};
					};
				};
			};
		};

		// debug info:
		// systemChat format ["X: %1, Y: %2",_axisX,_axisY];
		// systemChat format ["sqr: %1",_sqr];
		systemChat format ["score: %1",_score];
		
		_scoreArray set [(count _array), _score];
		_shooter setVariable ["totalScore", [(((_shooter getVariable "totalScore") select 0) + _score), (((_shooter getVariable "totalScore") select 1) + 1)], true];
		_shooter setVariable ["scoreArray", _scoreArray, true]; // there is no way this will actually work
	}];
} forEach shootingRangeTargets;

addMissionEventHandler ["Map", {
	_map ctrlAddEventHandler ["Draw", {
		params ["_map"];
		(findDisplay 12 displayCtrl 51) drawPolygon [[[6660,9344.07,0], [6797.27,9463.57,0], [6906.24,9329.57,0], [6768.02,9219.86,0]], [1,0,0,0.5]]
	}];
}];