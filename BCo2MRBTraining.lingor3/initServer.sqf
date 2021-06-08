enemyGroup = createGroup east; // for enemies in shoothouse.

//=============Variables=============\\
shootHouseSpectatorInterfaces = [spectateInterface, pitNorthSpectator, pitSouthSpectator];
// deleted vars ^ = sh1EastSpectator, sh1WestSpectator, sh2EastSpectator, sh2WestSpectator
shootHousePlayerInterfaces = [pitInteraction, shoothouse1Interaction, shoothouse2Interaction];
shootingRangeTargets = [rangeTarget1, rangeTarget2, rangeTarget3, rangeTarget4, rangeTarget5, rangeTarget6, rangeTarget7, rangeTarget8, rangeTarget9, rangeTarget10, rangeTarget11, rangeTarget12, rangeTarget13, rangeTarget14, rangeTarget15, rangeTarget16];
diff = "Normal";
amount = 10;
ATLandDistance = 1500;
MOSTrainingInterfaces = [sRangeInteract, sRangeLongInteract, MOS_ATRangeInteract];

landVehicles = [["Unarmed HMMWV", "rhsusf_m1025_w_s"], ["Transport HMMWV", "rhsusf_m998_w_s_2dr_halftop"], ["HMMWV (M2)", "rhsusf_m1025_w_s_m2"], ["HMMWV (Mk19)", "rhsusf_m1025_w_s_Mk19"], ["HMMWV (M134D, x2 M240)", "rhsusf_m1165a1_gmv_m134d_m240_socom_d", "rhs_sofwoodland"], ["HMMWV (M2, x2 M240)", "rhsusf_m1165a1_gmv_m2_m240_socom_d", "rhs_sofwoodland"], ["HMMWV (Mk19, x2 M240)", "rhsusf_m1165a1_gmv_mk19_m240_socom_d", "rhs_sofwoodland"], ["MRZR 4", "rhsusf_mrzr4_d", "Olive"], ["Olive Unarmed Jeep Wrangler", "I_C_Offroad_02_unarmed_F", "Olive"], ["Olive Jeep Wrangler (LMG)", "I_C_Offroad_02_LMG_F", "Olive"], ["Olive Jeep Wrangler (SPG-9)", "I_C_Offroad_02_AT_F", "Olive"], ["Unarmed MRAP", "rhsusf_m1240a1_usmc_wd"], ["MRAP (M240)", "rhsusf_m1240a1_m240_usmc_wd"], ["MRAP (M2)", "rhsusf_m1240a1_m2_usmc_wd"], ["MRAP (Mk19)", "rhsusf_m1240a1_mk19_usmc_wd"], ["MRAP (CROWS M2)", "rhsusf_m1240a1_m2crows_usmc_wd"], ["MRAP (CROWS Mk19)", "rhsusf_m1240a1_mk19crows_usmc_wd"], ["MRAP 6x6 (M2)", "rhsusf_M1232_MC_M2_usmc_wd"], ["MRAP 6x6 (Mk19)", "rhsusf_M1232_MC_MK19_usmc_wd"]];
seaVehicles = [["Assault Boat", "B_Boat_Transport_01_F"], ["RHIB", "rhsgref_hidf_rhib"], ["Speedboat Minigun", "B_Boat_Armed_01_minigun_F"], ["Mk.V SOC", "rhsusf_mkvsoc"]];
smallAviationVehicles = [["Unarmed UH-1Y", "RHS_UH1Y_UNARMED"], ["UH-1Y (Rockets)", "RHS_UH1Y_FFAR"], ["UH-1Y (Rockets & Guns)", "RHS_UH1Y"], ["Unarmed Little Bird", "RHS_MELB_H6M"], ["Transport Little Bird", "RHS_MELB_MH6M"], ["Little Bird (Rockets & Guns)", "RHS_MELB_AH6M"], ["MH-60M", "Dpy_mh60L"], ["HH-60G/M Pavehawk (Grey)", "vtx_HH60"], ["MH-60M (Black)", "vtx_MH60M"], ["MH-60M DAP (Armed)", "vtx_MH60M_DAP"], ["MH-60S Knighthawk", "vtx_MH60S"], ["MH-60S Knighthawk (GAU-21)", "vtx_MH60S_GAU21L"], ["MH-60S Knighthawk (Armed)", "vtx_MH60S_Pylons"], ["UH-60M Blackhawk", "vtx_UH60M"], ["UH-60M (Unarmed)", "vtx_UH60M_SLICK"]];
mediumAviationVehicles = [["CH-53E", "rhsusf_CH53E_USMC"], ["CH-53E (Cargo)", "rhsusf_CH53e_USMC_cargo"], ["CH-53E (GAU-21)", "rhsusf_CH53E_USMC_GAU21"]];

shootHouseMode = "this disableAI 'PATH';";

{publicVariable _x} forEach ["shootHousePlayerInterfaces", "shootHouseSpectatorInterfaces", "shootingRangeTargets", "diff", "amount", "ATLandDistance", "MOSTrainingInterfaces", "landVehicles", "seaVehicles", "smallAviationVehicles", "mediumAviationVehicles", "largeAviationVehicles", "shootHouseMode"];

pitSpawn setVariable ["triggerName", t_Pit, true];
sh1Spawn setVariable ["triggerName", t_SH1, true];
sh2Spawn setVariable ["triggerName", t_SH2, true];
consulateSpawn setVariable ["triggerName", t_Consulate, true];

shootRangeLeftLogic setVariable ["distancePosition", 100, true];
shootRangeMiddleLogic setVariable ["distancePosition", 100, true];
shootRangeRightLogic setVariable ["distancePosition", 100, true];
shootRangeLongLogic setVariable ["distancePosition", 400, true];

MOS_ATRangeInteract setVariable ["enableSmoke", true];

{_x setVariable ["inProgress", false, true];} forEach [pitSpawn, sh1Spawn, sh2Spawn, consulateSpawn, srt_rogain];
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