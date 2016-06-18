comment "Exported from Arsenal by Jochem";

comment "Remove existing items";
removeAllWeapons this;
removeAllItems this;
removeAllAssignedItems this;
removeUniform this;
removeVest this;
removeBackpack this;
removeHeadgear this;
removeGoggles this;

comment "Add containers";
this forceAddUniform "rhs_uniform_FROG01_wd";
for "_i" from 1 to 2 do {this addItemToUniform "rhsusf_mag_15Rnd_9x19_JHP";};
for "_i" from 1 to 2 do {this addItemToUniform "rhs_mag_30Rnd_556x45_M855A1_Stanag_No_Tracer";};
this addVest "V_PlateCarrier1_rgr";
for "_i" from 1 to 20 do {this addItemToVest "ACE_packingBandage";};
for "_i" from 1 to 10 do {this addItemToVest "ACE_elasticBandage";};
for "_i" from 1 to 5 do {this addItemToVest "ACE_fieldDressing";};
for "_i" from 1 to 5 do {this addItemToVest "ACE_quikclot";};
for "_i" from 1 to 8 do {this addItemToVest "rhs_mag_30Rnd_556x45_M855A1_Stanag_No_Tracer";};
for "_i" from 1 to 3 do {this addItemToVest "rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red";};
this addBackpack "B_Carryall_mcamo";
 "ACE_wirecutter";
 "ACE_Tripod";
 "ACE_SpottingScope";
 "ACE_SpareBarrel";
 "ACE_Sandbag_empty";
 "ACE_EntrenchingTool";
 "ACE_EarPlugs";
 "ACE_SpraypaintBlue";
 "ACE_SpraypaintGreen";
 "ACE_SpraypaintRed";
 "ACE_RangeTable_82mm";
 "ACE_CableTie";
 "ACE_Flashlight_MX991";
 "ACE_Flashlight_XL50";
 "ACE_MapTools";
 "rhs_mag_m18_green";
 "rhs_mag_m18_purple";
 "rhs_mag_m18_red";
 "rhs_mag_m18_yellow";
 "rhs_mag_m67";
 "rhs_mag_an_m8hc";
 "rhs_mag_an_m14_th3";
this addHeadgear "H_HelmetSpecB";

comment "Add weapons";
this addWeapon "rhs_weap_mk18_KAC";
this addPrimaryWeaponItem "rhsusf_acc_rotex5_grey";
this addPrimaryWeaponItem "rhsusf_acc_anpeq15side_bk";
this addPrimaryWeaponItem "rhsusf_acc_SpecterDR_3d";
this addWeapon "rhs_weap_m72a7";
this addWeapon "rhsusf_weap_m9";

comment "Add items";
this linkItem "ItemMap";
this linkItem "ItemCompass";
this linkItem "ItemWatch";
this linkItem "ItemRadioAcreFlagged";
this linkItem "ItemGPS";
this linkItem "rhsusf_ANPVS_15";

comment "Set identity";
this setFace "WhiteHead_15";
this setSpeaker "ACE_NoVoice";
