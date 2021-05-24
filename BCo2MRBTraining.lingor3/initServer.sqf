enemyGroup = createGroup east; // for enemies in shoothouse.

//=============Variables=============\\
//shootHouseSpectatorInterfaces = [spectateInterface, pitNorthSpectator, pitSouthSpectator, sh1EastSpectator, sh1WestSpectator, sh2EastSpectator, sh2WestSpectator];
shootHousePlayerInterfaces = [pitInteraction, shoothouse1Interaction, shoothouse2Interaction];
shootingRangeTargets = [rangeTarget1, rangeTarget2, rangeTarget3, rangeTarget4, rangeTarget5, rangeTarget6, rangeTarget7, rangeTarget8, rangeTarget9, rangeTarget10, rangeTarget11, rangeTarget12];
diff = "Normal";
amount = 10;
//MOSTrainingInterfaces = [ATRange, marksmanRange];
landVehicles = [["Unarmed HMMWV", "rhsusf_m1025_w_s"], ["Transport HMMWV", "rhsusf_m998_w_s_2dr_halftop"], ["HMMWV (M2)", "rhsusf_m1025_w_s_m2"], ["HMMWV (Mk19)", "rhsusf_m1025_w_s_Mk19"], ["HMMWV (M134D, x2 M240)", "rhsusf_m1165a1_gmv_m134d_m240_socom_d", "rhs_sofwoodland"], ["HMMWV (M2, x2 M240)", "rhsusf_m1165a1_gmv_m2_m240_socom_d", "rhs_sofwoodland"], ["HMMWV (Mk19, x2 M240)", "rhsusf_m1165a1_gmv_mk19_m240_socom_d", "rhs_sofwoodland"], ["MRZR 4", "rhsusf_mrzr4_d", "Olive"], ["Olive Unarmed Jeep Wrangler", "I_C_Offroad_02_unarmed_F", "Olive"], ["Olive Jeep Wrangler (LMG)", "I_C_Offroad_02_LMG_F", "Olive"], ["Olive Jeep Wrangler (SPG-9)", "I_C_Offroad_02_AT_F", "Olive"], ["Unarmed MRAP", "rhsusf_m1240a1_usmc_wd"], ["MRAP (M240)", "rhsusf_m1240a1_m240_usmc_wd"], ["MRAP (M2)", "rhsusf_m1240a1_m2_usmc_wd"], ["MRAP (Mk19)", "rhsusf_m1240a1_mk19_usmc_wd"], ["MRAP (CROWS M2)", "rhsusf_m1240a1_m2crows_usmc_wd"], ["MRAP (CROWS Mk19)", "rhsusf_m1240a1_mk19crows_usmc_wd"], ["MRAP 6x6 (M2)", "rhsusf_M1232_MC_M2_usmc_wd"], ["MRAP 6x6 (Mk19)", "rhsusf_M1232_MC_MK19_usmc_wd"]];

seaVehicles = [["Assault Boat", "B_Boat_Transport_01_F"], ["RHIB", "rhsgref_hidf_rhib"], ["Speedboat Minigun", "B_Boat_Armed_01_minigun_F"], ["Mk.V SOC", "rhsusf_mkvsoc"]];
smallAviationVehicles = [["Unarmed UH-1Y", "RHS_UH1Y_UNARMED"], ["UH-1Y (Rockets)", "RHS_UH1Y_FFAR"], ["UH-1Y (Rockets & Guns)", "RHS_UH1Y"], ["Unarmed Little Bird", "RHS_MELB_H6M"], ["Transport Little Bird", "RHS_MELB_MH6M"], ["Little Bird (Rockets & Guns)", "RHS_MELB_AH6M"], ["MH-60M", "Dpy_mh60L"]];
mediumAviationVehicles = [["CH-53E", "rhsusf_CH53E_USMC"], ["CH-53E (Cargo)", "rhsusf_CH53e_USMC_cargo"], ["CH-53E (GAU-21)", "rhsusf_CH53E_USMC_GAU21"]];
largeAviationVehicles = [["AV-8B Harrier II (1)", "FIR_AV8B_VMA214_01"], ["AV-8B Harrier II (2)", "FIR_AV8B_VMA214_02"], ["AV-8B Harrier II (3)", "FIR_AV8B_VMA214_03"], ["AV-8B Harrier II (4)", "FIR_AV8B_VMA214_04"], ["AV-8B Harrier II (5)", "FIR_AV8B_VMA214_05"], ["AV-8B Harrier II (6)", "FIR_AV8B_VMA214_06"], ["AV-8B Harrier II (7)", "FIR_AV8B_VMA214_07"], ["AV-8B Harrier II (8)", "FIR_AV8B_VMA214_08"], ["AV-8B Harrier II (9)", "FIR_AV8B_VMA214_09"], ["AV-8B Harrier II (11)", "FIR_AV8B_VMA214_11"], ["AV-8B Harrier II (12)", "FIR_AV8B_VMA214_12"], ["AV-8B Harrier II (15)", "FIR_AV8B_VMA214_15"], ["AV-8B Harrier II (20)", "FIR_AV8B_VMA214_20"], ["AV-8B Harrier II (22)", "FIR_AV8B_VMA214_22"]];

{publicVariable _x} forEach ["shootHousePlayerInterfaces","diff", "amount", "landVehicles", "seaVehicles", "smallAviationVehicles", "mediumAviationVehicles", "largeAviationVehicles", "shootingRangeTargets"];
// deleted vars: "shootHouseSpectatorInterfaces", "MOSTrainingInterfaces",

pitSpawn setVariable ["triggerName", t_Pit, true];
sh1Spawn setVariable ["triggerName", t_SH1, true];
sh2Spawn setVariable ["triggerName", t_SH2, true];
consulateSpawn setVariable ["triggerName", t_Consulate, true];

shootRangeLeftLogic setVariable ["distancePosition", 100, true];
shootRangeMiddleLogic setVariable ["distancePosition", 100, true];
shootRangeRightLogic setVariable ["distancePosition", 100, true];

{_x setVariable ["inProgress", false, true];} forEach [pitSpawn, sh1Spawn, sh2Spawn, consulateSpawn, srt_rogain];
{
	_x addEventHandler ["HitPart", {
		private _shooter = (_this select 0 select 1);
		private _position = (_this select 0 select 3);
		private _scoreArray = _shooter getVariable "scoreArray"; // sets the target that got shot, the person who shot and their current score info, and where the bullet hit.

		private _bullet = (_this select 0 select 0) worldToModel (ASLToATL _position);
		private _axisX = abs (((_bullet select 0) * 100)) + 0.1108644;
		private _axisY = abs (((_bullet select 2) * 100) + 2.3956); // need to find the offset for where the center of the target is.
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
		systemChat format ["X:%1,Y:%2",_axisX,_axisY];
		systemChat format ["sqr:%1",_sqr];
		systemChat format ["score:%1",_score];
		
		//_scoreArray set [(count _array), _score];

		{
			_shooter setVariable ["totalScore", [(((_shooter getVariable "totalScore") select 0) + _score),(((_shooter getVariable "totalScore") select 1) + 1)], true];
			_shooter setVariable ["scoreArray", _scoreArray, true];
		} remoteExec ["call"];
	}];
} forEach shootingRangeTargets;
/*
5 = 0-2.5
4 = 2.5 - 5
3 = 5 - 11
2 = 11 - 17
1 = 17 - 23
0 = 23+
*/

// 5.02014 >> 5.857 Y