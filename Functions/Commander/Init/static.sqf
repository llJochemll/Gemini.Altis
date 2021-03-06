/////////////////////////
//Script made by Jochem//
/////////////////////////
_roofBuildings = nearestObjects [(getMarkerPos "mrk_area"), poolRoof, worldSize*2.0^0.5];

_groups = [];
_newGroup = [];
_refBuilding = _roofBuildings select 0;
{

    if (_x distance2D _refBuilding < 300) then {
        _newGroup pushBackUnique _x;
    } else {
        _newGroup call BIS_fnc_arrayShuffle;
        _groups pushBack _newGroup;
        _refBuilding = _x;
        _newGroup = [_x];
    };
} forEach _roofBuildings;

_chance = 0.75;
{
    _amount = _chance * count _x;
    if (_amount < 1) then {
        _i = 0;
        {
            if (random 1 < _chance) then {
                _building = _x;
                [[0, 0, 0], selectMin [10, ceil((count (_building buildingPos - 1)) * 0.5)], 0, [true, _building], 0.6] call JOC_spawnGroup;
                _posArr = _building buildingPos -1;
                _static = createVehicle [selectRandom poolStaticAA, _posArr select (count _posArr - 1), [], 0, "CAN_COLLIDE"];
                _static setPosATL (_posArr select (count _posArr - 1));
                createVehicleCrew _static;
            };
        } forEach _x;
    } else {
        _i = 0;
        for "_i" from 0 to _amount step 1 do {
            _building = _x select _i;
            [[0, 0, 0], selectMin [10, ceil((count (_building buildingPos - 1)) * 0.5)], 0, [true, _building], 0.6] call JOC_spawnGroup;
            _posArr = _building buildingPos -1;
            _static = createVehicle [selectRandom poolStaticAA, _posArr select (count _posArr - 1), [], 0, "CAN_COLLIDE"];
            _static setPosATL (_posArr select (count _posArr - 1));
            createVehicleCrew _static;
            _i = _i + 1;
        };
    };
} forEach _groups;

