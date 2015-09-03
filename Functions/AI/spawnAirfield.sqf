/////////////////////////
//Script made by Jochem//
/////////////////////////
_marker = _this select 0;
_id = _this select 1;
_location = getMarkerPos _marker;
_size = getMarkerSize _marker;

//Create activation trigger
_trg = createTrigger ["EmptyDetector",_location,true];
_trg setTriggerArea [(_size select 0)*4,(_size select 1)*4,1200,false];
_trg setTriggerActivation ["WEST","PRESENT", false];
_trg setTriggerStatements ["this","[getPos thisTrigger,1600,[11,true],[4,false],[0,false],[3,false],[2,false],[0,false,""cas""],[0,false]] call JOC_spawnZone;deleteVehicle thisTrigger;",""];
_trg setTriggerTimeout [5,5,5,true];
_trg setDir (markerDir _marker);

//Spawn AA-defences
_ok = 0;
_count = 0;
while{_ok == 0}do{
	_marker = format["mrk_airfield_%1_aa_%2",_id,_count];
	markerT = _marker;
	if(getMarkerColor _marker == "")then{
		_ok = 1;
	}else{
		_aa = [getMarkerPos _marker,"O_APC_Tracked_02_AA_F",0,(markerDir _marker)] call Zen_SpawnVehicle;
		[_aa,east] call Zen_SpawnVehicleCrew;
		_aa setFuel 0;
		sleep 2;
		[_aa] joinSilent airfieldGroup;
		(crew _aa) joinSilent airfieldGroup;
		zeusMod addCuratorEditableObjects [[_aa],false];
		zeusMod addCuratorEditableObjects [(crew _aa),false];
	};
	_count = _count + 1;
};

//Spawn empty helicopter-jets
_ok = 0;
_count = 0;
while{_ok == 0}do{
	_marker = format["mrk_airfield_%1_hangar_%2",_id,_count];
	markerT = _marker;
	if(getMarkerColor _marker == "")then{
		_ok = 1;
	}else{
		_heli = [getMarkerPos _marker,((airPool + casPool) call BIS_fnc_selectRandom),1,(markerDir _marker)] call Zen_SpawnVehicle;
		_heli enableSimulationGlobal false;
		_heli allowDamage false;
		sleep 2;
		_heli enableSimulationGlobal true;
		_heli allowDamage true;
		zeusMod addCuratorEditableObjects [[_heli],false];
	};
	_count = _count + 1;
};

//Create activation trigger
_trgO = createTrigger ["EmptyDetector",_location,true];
_trgO setTriggerArea [(_size select 0),(_size select 1),1200,false];
_trgO setTriggerActivation ["EAST","PRESENT", false];
_trgO setTriggerStatements ["this","",""];
_trgO setTriggerTimeout [5,5,5,true];
_trgO setDir (markerDir _marker);

waitUntil{sleep 30;list _trgO >= 1};
waitUntil{sleep 30;list _trgO <= 5};

deleteMarker _trgO;

[airfieldOccup,_id,true] call Zen_ArrayInsert;