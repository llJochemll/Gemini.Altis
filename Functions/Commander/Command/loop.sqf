/////////////////////////
//Script made by Jochem//
/////////////////////////
//Check for AA intercept
if((count jetTargets > 0 || count heliTargets > 1) && !jetActive)then{
    jetActive = true;
    jetReady = false;
    [[3,3],_pos,-1,true]call JOC_cmdCmdRequest;
};

if(!jetReady && !jetActive)then{
    [{jetReady = true;}, [], 7200] call CBA_fnc_waitAndExecute;
};

//Find concentration of known blufor
_playersKnown = [];
{
    if(east knowsAbout _x > 2)then{
        _playersKnown pushBack _x;
    };
} forEach allPlayers;

_motor = [];
_armor = [];
_groups = [];
_newGroup = [];
_refPlayer = _playersKnown select 0;
{

    if(_x distance2D _refPlayer < 100)then{
        _newGroup pushBackUnique _x;
    }else{
        _newGroup call BIS_fnc_arrayShuffle;
        if(count _newGroup > 4)then{
            _groups pushBack _newGroup;
        };
        _refPlayer = _x;
        _newGroup = [_x];
    };
} forEach _playersKnown;

{
    //Call in arty
    if(count _x > 10)then{

        _absDir = 0;
        _absSpeed = 0;
        {
            _dir = getDir _x;
            if(_dir > 180)then{
                _dir = _dir - 360;
            };
            _absDir = _absDir + _dir;
            _absSpeed = _absSpeed + getDir _x;
        } forEach _x;

        _positions = [];
        {
            _positions pushBack (getPos _x);
        } forEach _x;

        _pos = [_positions]call JOC_findCenter;

        _dir = _absDir / (count _x);
        _speed = _absSpeed / (count _x);
        _pos = [_pos,_speed / 70,_dir] call Zen_ExtendPosition;
        [[3,1],_pos,_forEachIndex,false]call JOC_cmdCmdRequest;
    };
} forEach _groups;

//Check strategicarray
{
    switch(_x select 4)do{
        //No side cheking
        if(_x select 2 in ["radar","radio"])then{
            _objects = nearestObjects [(_x select 0),["Land_Radar_F","Land_Radar_Small_F","Land_TTowerBig_1_F","Land_TTowerBig_2_F"],20];
            if(count _objects == 0)then{
                (strategicArray select _forEachIndex) set [4,4];
            };
        };

        //Side cheking
        case 0:{
            if(_x select 2 in ["aa","arty","camp"])then{
                (strategicArray select _forEachIndex) set [4,4];
            };
        };
        case 1:{
            //Check if under attack
            if(count ([(_x select 0),(_x select 1),["air"],[true,west]]call JOC_nearestPlayers) > 0)then{
                (strategicArray select _forEachIndex) set [4,2];
            }else{
                //Check if vehicles need ammo
                if(_x select 2 in ["aa","arty"])then{
                    _vehicles = (_x select 0) nearEntities [[aaClass,artyClass],(_x select 1)];
                    _ammo = _vehicles select {_x ammo (currentWeapon _x) < 0.3};
                    if(count _ammo > 0)then{
                        [[2,0],_x,_forEachIndex,false]call JOC_cmdCmdRequest;
                    };
                };
            };
        };
    };
} forEach strategicArray;


_strategicWest = strategicArray select {(_x select 4) == 0};
_strategicEast = strategicArray select {(_x select 4) == 1};
_strategicDefend = strategicArray select {(_x select 4) == 2};
_strategicAttack = strategicArray select {(_x select 4) == 3};

_strengthEast = (count _strategicEast) / (count strategicArray);
_strenghtWest = (count _strategicWest) / (count strategicArray);

{
    _array = _x;
    _index = _array select 5;
    switch(true)do{
        case(_array select 1 >= 1000):{
            [[3,2],_array,_index,false]call JOC_cmdCmdRequest;
            if(random 2 >= 1)then{
                [[1,0],[_array,4],_index,false]call JOC_cmdCmdRequest;
            }else{
                [[1,1],[_array,4],_index,false]call JOC_cmdCmdRequest;
            };
        };
        case(_array select 1 >= 800 && _array select 1 < 1000):{
            [[3,2],_array,_index,false]call JOC_cmdCmdRequest;
            if(random 2 >= 1)then{
                [[1,0],[_array,3],_index,false]call JOC_cmdCmdRequest;
            }else{
                [[1,1],[_array,3],_index,false]call JOC_cmdCmdRequest;
            };
        };
        case(_array select 1 >= 600 && _array select 1 < 800):{
            if(_strengthEast > 0.2)then{
                if(_strengthEast > 0.4)then{
                    [[1,0],[_array,2.5],_index,false]call JOC_cmdCmdRequest;
                }else{
                    [[1,0],[_array,1.5],_index,false]call JOC_cmdCmdRequest;
                };
            };
        };
        case(_array select 1 >= 400 && _array select 1 < 600):{
            if(_strengthEast > 0.25)then{
                if(_strengthEast > 0.5)then{
                    [[1,0],[_array,2],_index,false]call JOC_cmdCmdRequest;
                }else{
                    [[1,0],[_array,1],_index,false]call JOC_cmdCmdRequest;
                };
            };
        };
        case(_array select 1 >= 200 && _array select 1 < 400):{
            if(_strengthEast > 0.3)then{
                if(_strengthEast > 0.6)then{
                    [[1,0],[_array,1.5],_index,false]call JOC_cmdCmdRequest;
                }else{
                    [[1,0],[_array,0.5],_index,false]call JOC_cmdCmdRequest;
                };
            };
        };
        case(_array select 1 >= 100 && _array select 1 < 200):{
            if(_strengthEast > 0.6)then{
                [[1,0],[_array,1],_index,false]call JOC_cmdCmdRequest;
            };
        };
        case(_array select 1 >= 0 && _array select 1 < 100): {

        };
    };
} forEach _strategicDefend;


//new
//request = [categoryArray,params,canIgnore]
//order = [categoryArray,params,groupID,scriptArray]
//categoryArray = [category,subcategory,...]
//scriptArray = [[condition,code],[condition,code],...]

//The brain of the ai commander
_realGroups = [];
_usedGroups = [];
{
    if((side _x) != west)then{
        //Another failsafe for groupID
        if((_x getVariable ["groupID", -1]) == -1)then{
            [_x]call JOC_setGroupID;
        };

        _id = (_x getVariable ["groupID", -1]);
        _realGroups pushBack _id;
    };
} forEach allGroups;


{
    _request = _x;
    _order = [];

    //If request hasn't been processed yet, do that
    if(!((_request select 3) select 1))then{
        switch((_request select 0) select 0)do{
            //Attack
            case (0): {

            };
            //Defend
            case (1): {
                switch((_request select 0) select 1)do{
                    //Convoy
                    case (0): {
                        _order = (_request select 1)call JOC_cmdDefConvoy;
                    };
                    //Heli
                    case (1): {
                        _order = (_request select 1)call JOC_cmdDefHeli;
                    };
                    //Near
                    case (2): {
                        //_order = (_request select 1)call JOC_cmdDefNear;
                    };
                    //Retreat
                    case (3): {
                        //_order = (_request select 1)call JOC_cmdDefRetreat;
                    };
                };
            };
            //Logistics
            case (2): {
                switch((_request select 0) select 1)do{
                    //Ammo supply
                    case (0): {
                        _order = (_request select 1)call JOC_cmdLogAmmo;
                    };
                    //Repair
                    case (1): {
                        //_order = (_request select 1)call JOC_cmdLogRepair;
                    };
                };
            };
            //Support
            case (3): {
                switch((_request select 0) select 1)do{
                    //Arty support
                    case (1): {
                        //_order = (_request select 1)call JOC_cmdLogAmmo;
                    };
                    //Intercept
                    case (3): {
                        _order = (_request select 1)call JOC_cmdSupportIntercept;
                    };
                };
            };
        };

        //If order didn't fail to start, start execution of order
        if(count _order != 0)then{
            {
                orderArray pushBack [_order,currentRequestID];
            } forEach _order;

            (requestArray select _forEachIndex) set [3,[currentRequestID,true]];
            currentRequestID = currentRequestID + 1;
        };
    }else{
        //If order that was activated by request is complete, delete request
        _existArr = orderArray select {_x select 1 == ((_request select 3) select 0)};
        if(count _existArr == 0)then{
            requestArray deleteAt _forEachIndex;
        };
    };
} forEach requestArray;


{
    _order = _x select 0;

    //If no more conditions or group is destoyed, delete from orderarray
    if(isNil{(((_order select 3) select 0) select 0)} || !([_order select 2]call JOC_groupExists))then{
        orderArray deleteAt _forEachIndex;
    }else{
        //If group isn't virtuaized, evaluate condition
        if(_order select 2 in _realGroups)then{
            _usedGroups pushBack (_order select 2);
            _group = [_order select 2]call JOC_getGroup;
            //If condition is true, execute code and delete part from order
            if([_order select 1, _group]call (compile (((_order select 3) select 0) select 0)))then{
                [_order select 1, _group]call (compile (((_order select 3) select 0) select 1));
                ((_order select 3) select 0) deleteAt 0;
            };
        };
    };
} forEach orderArray;

//Patrol
{
    _group = [_x]call JOC_getGroup;
    if((count (waypoints _group) <= currentWaypoint _group) && !(_x in _usedGroups) && !(_group getVariable["JOC_caching_disabled",false]) && !(_group getVariable["garrisoned",false]) && (combatMode _group != "COMBAT"))then{
        [_group]call JOC_cmdPatrolStrategic;
    };
} forEach _realGroups;
