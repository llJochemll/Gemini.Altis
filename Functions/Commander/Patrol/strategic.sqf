/////////////////////////
//Script made by Jochem//
/////////////////////////
params["_group"];

//No vehicles as they can't manage to drive past infantry
_vehicle = false;
{
    if(!isNull (objectParent _x))exitWith{
        _vehicle = true;
    };
} forEach (units _group);

if(_vehicle)exitWith{};

_id = _group getVariable["groupID",-1];
_assigned = (assignedArray select {(_x select 0) == _id}) select 0;

_strategic = strategicArray select (_assigned select 1);
_pos = _strategic select 0;
_size = _strategic select 1;

if(_size < 300)then{
    _size = 300;
};

[_group,_pos,_size,"SAFE"]call JOC_cmdPatrolArea;