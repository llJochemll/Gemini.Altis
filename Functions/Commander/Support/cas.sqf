/////////////////////////
//Script made by Jochem//
/////////////////////////
params["_array"];

//Find airfield
_airfield = [_array select 0, "airfield", [1000, 99999]] call JOC_cmdMiscGetNearestStrategic;
if ((count _airfield) == 0) exitWith {[]};
_airfieldPos = _airfield select 0;

//Spawn jet
JOC_pauseCache = true;

_list = nearestObjects [_airfieldPos, ["LocationRespawnPoint_F"], 1000];
_pos = getPos (_list select 0);
_jet = (selectRandom poolJetAG) createVehicle _pos;
_jet setDir (direction (_list select 0));
createVehicleCrew _jet;
_group = (group ((crew _jet) select 0));
[_group] call JOC_coreSetID;
(_group) setVariable ["JOC_caching_disabled", true];

JOC_pauseCache = false;

_wp1 = _group addWaypoint [(_array select 0), 0];
_wp1 setWaypointType "SAD";

_scriptArray = [
["fuel (vehicle (leader (_this select 1))) < 0.1 || damage (vehicle (leader (_this select 1))) > 0.5 || (strategicArray select ((_this select ) select 5)) select 4 == 1", "_airfieldPos = ([getPos ((_this select 0) select 0), ""airfield"", [1000, 99999]] call JOC_cmdMiscGetNearestStrategic) select 0; _wp1 = (_this select 1) addWaypoint [_airfieldPos, 0];_wp1 setWaypointType ""GETOUT"";"], 
["(count (waypoints (_this select 1)) <= currentWaypoint (_this select 1))", "(_this select 1) setVariable [""JOC_caching_disabled"", false, true];(_this select 1) setVariable [""JOC_cleanUp"", true , true]"]
];

_order = [[[1, 1], _array, ([_group] call JOC_coreSetId), _scriptArray]];

_order
