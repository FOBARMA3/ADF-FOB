![ADF - Arma Mission Development Framework](Core/I/ADF_logo.png)
================================================================

### Index

-   [New Features](https://github.com/whiztler/ADF/blob/beta10/README.md#new-features-139)
-   [Changelog](https://github.com/whiztler/ADF/blob/beta10/README.md#changelog)
-   [Introduction](https://github.com/whiztler/ADF/blob/beta10/README.md#introduction)
-   [Mission Development](https://github.com/whiztler/ADF/blob/beta10/README.md#mission-development)
-   [Configuring your mission](https://github.com/whiztler/ADF/blob/beta10/README.md#configuring-your-mission)
    -   [description.ext](https://github.com/whiztler/ADF/blob/beta10/README.md#descriptionext)
    -   [ADF\_init\_config.sqf](https://github.com/whiztler/ADF/blob/beta10/README.md#adf_init_configsqf)
-   [Advanced Editing](https://github.com/whiztler/ADF/blob/beta10/README.md#advanced-editing---scripting-spawning-of-units)
-   [Legal](https://github.com/whiztler/ADF/blob/beta10/README.md#legal)

### Current version

version: 1.39
build: Beta 10

New Features 1.39
-----------------

ADF 1.39 is a major change release that comprises of script optimization and new features such as:

-   **Support for multiple Headless Clients with automatic Load Balancing** - ADF 1.39 offers up to three HC's that should be named ADF\_HC1, ADF\_HC2, ADF\_HC3. The mission maker can enable/disable load balancing. When enabled ADF transfers AI groups across available HC's (Round Robin method). See 'Core\\ADF\_HC.sqf' for more information.
-   **ACE3 support** - ADF 1.39 automatically detects the ACE3 mod (and cTAB, TFAR, ACRE2) on both clients and the server and applies loadout/supplies to personnel and vehicles where needed.
-   **Clan presets** - ADF 1.39 offers presets for call signs and radio configuration. Preconfigured presets are available for Nopryl, SHAPE, Wolfpack and custom. Mission makers can edit the presets to enable their own group call signs (Fox, Wolf, etc) and radio frequency/channel plan.
-   **Extended debug information** - when ADF\_debug is enabled an extensive log of debug information is show on screen and written to the server RPT file. Note that the debug function influencies FPS by a few frames.
-   **Extended Loadout options** - Predefined (ADF) loadout, Vanilla + ACE/CTAB/TFAR/ACRE loadout, No Loadout (for third party loadout mods)

Due to the many changes 1.39 is **not compatible** with missions made with previous ADF versions.

### Changelog

#### 1.38 - 1.39

-   ADDED: Preliminary GitHub support [https://github.com/whiztler/ADF/tree/master]
-   ADDED: Debug function: OpFor Detection
-   ADDED: ACE3 mod support (auto detect)
-   ADDED: Support for up to 3 HC's with load balancing
-   ADDED: BIS DLC support (auto detect premium DLC)
-   ADDED: Custom call signs configuration (Fox, Wolf, etc)
-   ADDED: Call Signs and Radio Freq's/Channels presets (Nopryl, SHAPE, Wolfpack, Custom, Default)
-   ADDED: Debug feedback (both system chat and RPT log). ADF\_Debug needs to be set to 'true' for it to work.
-   ADDED: Marksman DLC items
-   UPDATED: cTAB now auto detected. cTAB does not re-initialize preset call signs!
-   UPDATED: ADF\_fnc\_LoadoutWest.sqf
    -   Replaced: AGM components with ACE3 components
    -   Added: ACE3 components where applicable
    -   Added: MG role to INF
    -   Added: MicroDAGR (TFAR, ACE3, cTAB - ACE3 prevails when both cTAB and ACE3 are selected)
    -   Updated: SOR/SOD loadouts (black uniforms and small optimization)
    -   Updated: SOR Sniper Teams (DLC dependent)
-   UPDATED: init.sqf
    -   Updated: execution order re HC vs ZBE Caching. With HC active server caching is deactivated
    -   Script optimization
-   UPDATED: ADF\_init\_config.sqf
    -   Added: enhanced ACRE2 functionalities (WIP)
    -   Added: Dev Build version management
    -   Added: NoLoadout option for loadout MOD's or plain vanilla loadout
    -   Added: Call Signs option
    -   Added: Presets option (call signs and radio freqs/channels)
    -   Added: Dynamic AI Creator (DAC) option (WIP)
    -   Changed: \_ADF\_HC\_init\_ option set to 'true' by default
-   UPDATED: ADF\_HC.sqf
    -   Added support for multiple HC's
    -   Added load balacing across multiple HC's (can be switched on/off in ADF\_init\_config
    -   Script optimization
-   UPDATED: ADF\_init\_vars.sqf
    -   Added ACE3 support
    -   Added DLC support
    -   Added Debug write function
    -   Script optimization
-   UPDATED: All crate & vehicle scrips (ACE3 support and optimizations)
-   UPDATED: updated and optimized all scripts
-   REMOVED: AGM mod support
-   REMOVED: Various obsolete scripts

Introduction
------------

ADF has been set-up for mission developers to created complex missions in \< 1 hour. The framework offers a full joint operations company with various pre-configured presets for Nopryl, SHAPE, Wolfpack, etc. Crates and vehicle loadout is pre-configured according to the role of the team that is using the crate/vehicle.

At first glance, the ADF seems complex, but you'll probably need to work with only two files: **description.ext** and **ADF\_init\_config.sqf**. Once you get the hang of ADF you'll be able to do more advanced things such as [scripting units](https://github.com/whiztler/ADF/blob/beta10/README.md#advanced-editing---scripting-spawning-of-units) to spawn after the mission has started. All scripts and files have been well documented. Please use a dedicated editor such as [Notepad++](https://notepad-plus-plus.org/news/notepad-plus-plus-on-github.html) to work with mission files. Once you have installed the Notepad++ editor, download and install the SQF plugin from [Armaholic](http://www.armaholic.com/page.php?id=8680).

### Performance

ADF has been optimized for multiplayer coop missions. All required (and user configured) scripts and options load during the mission init. There are NO loops exccept:

-   **Headless Client loadbalacing** (when enabled). Will transfer units to the HC's every 30 seconds
-   **GM / Zeus**. Will transfer server/client items to Curators every 10 seconds
-   **Performance reporting** (FPS). Every 60 seconds server performance is stamped into the RPT. If the server FPS drops than the function stamps the server performance more frequently (FPS < 40, every 15 secs | FPS < 30, every 10 secs | FPS < 20, every 5 secs | FPS < 15, every second).

Above functions are as much optimized as possible and will not affect game play performance.

Performance could be further optimized but this means that most functionality of ADF would be rewriten as functions. This will make it a lot harden for beginner (and semi advanced) mission makers. Therefore the choice was made to balance 'easy of use' with performance.

Mission Development
-------------------

To really use ADF to the fullest I recommend that you read/study-up on a few existing mission development tuts/pages. More information: [http://www.nopryl.no/smfprod/index.php?topic=5723.0](http://www.nopryl.no/smfprod/index.php?topic=5723.0)

Excellent scripting tutorials are:

[Fockers Arma3 Scripting Tutorials](http://forums.bistudio.com/showthread.php?154047-Arma-3-Scripting-Tutorial-For-Noobs)
[Killzone Kid](http://killzonekid.com)

### ADF Template

The ADF template mission is a starting point for rapid mission creating. The template mission features 114 pre-defined units:

Command element

Infantry platoon

-   Platoon Command
-   2 Rifle Squads
    -   2 fire teams per squad
-   1 Weapons Squad
    -   1 Weapons Team
    -   1 Heavy Weapons Team

Cavalry Battery

-   Battery Command (DC)
-   1 APC Squadron
-   1 MBT Squadron
-   2 Artillery units

Air Wing

-   Wing Command
-   1 AH99
-   1 AH9
-   2 x UH-80
-   1 x CH-67
-   2 x A164

Special Operations Squadron

-   SO Command
-   1 SpecOp AssaultTeam
-   1 Demo Team
-   1 Recon Team
-   1 Frogman Team
-   2 Sniper Teams
-   1 JTAC

The units have specific names that **cannot** be changed else the framework cannot perform loadout / radio/ callsign configuration. You **can** change however the unit 'Description'. All units get their loadout as defined (by the mission maker) in the ADF\_init\_config.sqf ([see below](#initcfg)).

Note that the template mission also features vehicles. The vehicles are named so that you know which vehicle belongs to which group/unit. All vehicles are supplied with kit according to the role of the group they belong to. Same goes for the various crates.

Configuring your mission
------------------------

Start with opening the ADF template mission in the mission editor. Please note that if you save it with a new name that you should copy the script/template files from the ADF folder to your mission folder.

### description.ext

With Notepad++ open description.ext which can be found in the mission root folder.

1.  Change `maxPlayers =**117**;` into the number of playable slots. E.g. maxPlayers = **32**; This number needs to match the number of playable slots exactly. This number should include all HC's!
2.  Change `respawn = "**BASE**";` into the method of respawn. When no respawn is allowed than use BIRD. E.g. respawn = "**BIRD**";
3.  Change `respawnDelay = **30**;` into the number of seconds the player waits for respawn (respawn timer). If you you have 'respawn = "BIRD";` (no respawn) then respawnDelay has no effect at all.
4.  Change `author = "**Whiztler**";` into the name of the mission developer (you). E.g. author = "**John**"; (free text without formatting)
5.  Change `overviewText = "**ADF by Whiztler**";` into a short mission description/name. E.g. overviewText = "**Operation Red Thunder by John**"; (free text without formatting)
6.  Change `onLoadName = "**A D F**";` into your mission name. E.g. onLoadName = "**Operation Red Thunder**"; This appears in the mission loading screen before the mission briefing and is displayed with the mission_intro picture. (free text without formatting)
7.  Change `onLoadMission = "**Arma Mission Development Framework**";` into a 1 paragraph mission description. E.g. onLoadMission = "**Assault Delta Hill and the Power Station and wait for further orders.**"; This appears in the mission loading screen before the mission briefing and is displayed with the mission_intro picture. (free text without formatting)
8.  Change `loadScreen = "**img\mission_intro_ADF.paa**";` This is the mission intro picture that is show while the mission is loading. SHAPE/Nopryl/etc. pictures can be found in the /Img folder. E.g. loadScreen = "**img\mission_intro_Nopryl.paa**"; You can create your own mission intro image to give your mission some extra sauce.
9.  Change `onLoadIntro = "**Powered by ADF**";` into some additional information you might want your players to know about. (free text without formatting)
10. Save and close.

### ADF_init_config.sqf

With Notepad++ open ADF_init_config.sqf which can be found in the mission root folder. This is your main mission configuration. Basically everything, from loadout to radio/call sign presets can be configured here. **If you are not sure if you need to change a value then best leave it as is**. Make sure to test your mission in between changes, else you might loose track of your mission development process.

#### General

1.  Change `_ADF_mission_version = **1.0**;` into your current mission version. I high recommend you use version management to keep track of development progress/changes. When using e.g. _ADF_mission_version = 3; than save you mission as e.g. '**myMission_version_3**'
2.  Change `_ADF_mission_init_time = **30**;` into the number of seconds the mission needs to initialize. With COOP missions it is important that the server (and clients) get enough time to initialize properly. Rule of the thumb is minimum 30 secs and add 1 sec per 2 players. 30 players = 45 seconds. The maximum should be 90 seconds (for 50+ players).
3.  Change `_ADF_HC_init = **true**;` to **true** or **false**. If you do not want to use the HC and the HC is active on the server then set this to false else leave as is as the script will automatically detect HC presence.
4.  Change `_ADF_HCLB_enable = **false**;` to **true** or **false**. Set to true when using multiple HC's to enable load balancing of AI group's across the HC's.
5.  Change `ADF_playerSide = WEST;` to **WEST** or **EAST** or **GUER** or **CIV**. Set to the side that playable units are on. *Please note that only WEST loadout presets exist in the ADF template.*
6.  Change `ADF_debug = **false**;` to **true** of **false**. If you need to debug your mission then set to true. Debug information is displayed on screen and written to the mission RPT. Please note that debug can be resource heavy so FPS might be considerably lower. Don't enable ADF_debug with lots of clients else the server will crumble.
7.  Change `ADF_Log_ServerPerfEnable = **true**;` to **true** of **false**. When set to true, server performance information is added to the RPT logfile. The frequency is based on the server performance. If FPS \> 40 than every 60 seconds. If FPS < 40 than every 15 seconds. If FPS < 30 than every 10 seconds. If FPS < 20 than every 5 seconds and if server FPS drops below 15 than it is logged every second. Once server FPS decreases/increases, the frequency of logging changes also.
8.  Change `'ADF_clanName = "**A D F**";` into the name of your clan. This is freetext so any name will do. E.g. ADF_clanName = "**Nopryl**"; The name is displayed in hints, mission roster, briefing, etc.
9.  Change `ADF_clanTAG = "**ADF**";` into the tag of your clan. This is freetext so any tag will do. E.g. ADF_clanTAG = **"L.A.M.B.S**"; The tag is displayed in hints, mission roster, briefing, etc.
10. Change `ADF_clanLogo = "**img\clan_logo_ADF.paa**";` to your clan logo. Clan logo's can be found in the img\ folder. E.g. ADF_clanLogo = "img\**clan_logo_Nopryl.paa**"; The clan logo is used for hints, intro screens, etc. Preset images can be found in the '\\Img' folder.
11. Change `ADF_clanFlag = "**img\clan_flag_ADF.paa**";` to your clan flag. The flag image can be displayed on flags in-game. See the flagpole in the ADF mission with the Nopryl flag for instance (**clan_flag_Nopryl.paa**). Preset images can be found in the '\\Img' folder.
12. Change `_ADF_MissionIntroImage = "**img\mission_cover_ADF.paa**";` to your own image that is displayed after the mission initialization (in-game). E.g. _ADF_MissionIntroImage = "img\mission_cover_**nopryl**.paa. Preset images can be found in the '\\Img' folder.
13. Change `ADF_Clan_uniformInsignia = **true**;` to **true** or **false**. The clan insignia can be configured in the missionConfig.hpp (mission root folder) file. Default is Nopryl.
14. Change `_ADF_preset = "**Default**";` to either **Default** or **Nopryl** or **SHAPE** or **Wolfpack** or **Custom**. The preset file represents clan call signs and preconfigured radio frequencies. The preset file can be found here: 'Core\\F\\ADF_fnc_presets.sqf'. If you wish to create your own preset than edit the **custom** preset and select _ADF_preset = "Custom";

#### Gear & Loadout

1.  Change `ADF_sameGearRespawn = **true**;` to **true** or **false**. In case of respawn this determines if players respawn with the same loadout as when they died. If ACE3 is active it will use the ACE sameGear function. Else it will use the ADF sameGear function.
2.  Change `_ADF_customLoadout_MOD = **true**;` to **true** or **false**. When set to true it will use the preconfigured loadout scripts. When set to false it will use the BIS Vanilla gear + items from active mods such as cTAB, ACE3 and TFAR/ACRE2.
3.  Change `_ADF_noLoadout = **false**;` to **true** or **false**. When set to true, ADF will not load any gear scripts. This is useful when using a custom loadout/gear mod. *Please note that call sign/radio frequencies are loaded no matter if you set '_ADF_noLoadout to true or false*.
4.  Change `_ADF_uniform_inf = "**U_B_CombatUniform_mcam**";` to the classname of the uniform of **infantry** units. If you wish to change, classnames can be found here: [https://community.bistudio.com/wiki/Arma_3_CfgWeapons_Equipment](https://community.bistudio.com/wiki/Arma_3_CfgWeapons_Equipment "BIS Assets"). *Please note that vehicle/air crew members and snipers get default uniforms*.
5.  Change `_ADF_uniform_sor = "**U_B_CombatUniform_mcam_vest**";` to the classname of the uniform of **specop** units. If you wish to change, classnames can be found here: [https://community.bistudio.com/wiki/Arma_3_CfgWeapons_Equipment](https://community.bistudio.com/wiki/Arma_3_CfgWeapons_Equipment "BIS Assets").
6.  Change `_ADF_add_NVGoggles = **true**;` to **true** or **false**. If set to false than all units do NOT get night vision goggles. Only applies when _ADF_noLoadout is set to false.
7.  Change `_ADF_add_GPS = **false**;` to **true** or **false**. This determines if ALL units get a BIS GPS. If set to false than only leadership units get a GPS. Only applies when _ADF_noLoadout is set to false.
8.  Change `_ADF_Thermal = **true**;` to **true** or **false**. This enables (true) or disables (false) thermal sights in both vehicle weapons and personal weapons.
9.  Change `_ADF_INF_assault_weapon = **1**;` to **1** for the MX-series or to **2** for the TRG-series. This determines the assault weapon loadout for **infantry** units.
10. Change `_ADF_INF_LMG_weapon = **1**;` to **1** for the MX-SW autorifleman weapon or to **2** for the MK200 autorifleman weapon.
11. Change `_ADF_INF_hand_weapon = **1**;` to **1** for the P07 hand weapon or to **2** for the 4-five .45 hand weapon for **infantry** units.
12. Change `_ADF_INF_scopes = **false**;` to **true** or **false**. This determines if ALL infantry units get a MCRO scope. If set to false than only leadership and machinegunners gets scopes.
13. Change `_ADF_SOR_assault_weapon = **1**;` to **1** for the MX black series, or to **2** for the TRG series or to **3** for the MX Compact series. This determines the assault weapon loadout for **SpecOp/Recon** units.
14. Change `_ADF_SOR_hand_weapon = **1**;` to **1**for the 4-five .45. hand weapon or to **2** for the P07 hand weapon for **SpecOp/Recon** units
15. Change `_ADF_CAV_assault_weapon = **1**;` to **1**for the MX Compact series or to **2**for the Vermin SMG. This determines the primary weapon loadout for **Cavalry crew** units.
16. Change `_ADF_ACE3_microDAGR_all = **false**;` to **true** or **false**. When set to true, all units will get a ACE3 microDAGR. When set to false, no units will get a ACE3 microDAGR unless **_ADF_ACE3_microDAGR_leaders**is set to true. In that case leadership units get a ACE3 microDAGR. Only applies when _ADF_noLoadout is set to false.
17. Change `_ADF_ACE3_microDAGR_leaders = **true**;` to **true** or **false**. When set to true, leadership will get a ACE3 microDAGR. When set to false all units will get a ACE3 microDAGR when _ADF_ACE3_microDAGR_allis set to true, else no one will get a ACE3 microDAGR. Only applies when _ADF_noLoadout is set to false.
18. Change `_ADF_cTAB_side = **ADF_playerSide**;` to **WEST** or **EAST** if you wish cTAB for another side as the player side. Only change if you know what you're doing slse leave as is.
19. Change `_ADF_cTAB_microDAGR_all = **false**;` to **true** or **false**. When set to true, all units will get a cTAB microDAGR. When set to false, no units will get a cTAB microDAGR unless **_ADF_cTAB_microDAGR_leaders**is set to true. In that case leadership units get a cTAB microDAGR. Note that when both ACE3 and cTAB microDAGR are set to true, the ACE3 microDAGR prevails and cTAB is set to false. Only applies when _ADF_noLoadout is set to false.
20. Change `_ADF_cTAB_microDAGR_leaders = **false**;` to **true** or **false**. When set to true, leadership will get a cTAB microDAGR. When set to false all units will get a cTAB microDAGR when _ADF_cTAB_microDAGR_allis set to true, else no one will get a cTAB microDAGR. Note that when both ACE3 and cTAB microDAGR are set to true, the ACE3 microDAGR prevails and cTAB is set to false. Only applies when _ADF_noLoadout is set to false.
21. Change `_ADF_TFAR_personalRadio = "**tf_rf7800str**";` to the classname of the TFAR personal rifleman radio. If you wish to change, classnames can be found here: [https://github.com/michail-nikolaev/task-force-arma-3-radio/wiki/API:-Classes](https://github.com/michail-nikolaev/task-force-arma-3-radio/wiki/API:-Classes "TFAR radio classes")
22. Change `_ADF_TFAR_SWRadio = "**tf_anprc152**";` to the classname of the TFAR short wave radio. If you wish to change, classnames can be found here: [https://github.com/michail-nikolaev/task-force-arma-3-radio/wiki/API:-Classes](https://github.com/michail-nikolaev/task-force-arma-3-radio/wiki/API:-Classes "TFAR radio classes")
23. Change `_ADF_TFAR_LRRadio = "**tf_rt1523g_big**";` to the classname of the TFAR long range radio. If you wish to change, classnames can be found here: [https://github.com/michail-nikolaev/task-force-arma-3-radio/wiki/API:-Classes](https://github.com/michail-nikolaev/task-force-arma-3-radio/wiki/API:-Classes "TFAR radio classes")
24. Change `_ADF_TFAR_LRRadioSOR = "**ft_rt1523g_black**";` to the classname of the TFAR long range radio for **Recon/Specop** units. If you wish to change, classnames can be found here: [https://github.com/michail-nikolaev/task-force-arma-3-radio/wiki/API:-Classes](https://github.com/michail-nikolaev/task-force-arma-3-radio/wiki/API:-Classes "TFAR radio classes")
25. Change `_ADF_TFAR_microDAGR = **false**;` to **true** or **false**. This determines if all units get the TFAR microDAGR. Can be used in conjunction with the ACE3/cTAB microdagr.
26. Change `ADF_TFAR_preset = **true**;` to **true** or **false**. When set to true, the mission will use TFAR radio frequencies as defined in the **ADF_preset** ( 'Core\\F\\ADF_fnc_presets.sqf'.). If set to false than all radio's will use a flatnet for SW and one for LR.
27. Change `_ADF_ACRE_personalRadio = "**ACRE_PRC343**";` to the classname of the ACRE2 personal radio. If you wish to change, classnames can be found here: [http://gitlab.idi-systems.com/idi-systems/acre2-public/wikis/basic-concepts](http://gitlab.idi-systems.com/idi-systems/acre2-public/wikis/basic-concepts "ACRE2 radio classnames")
28. Change `_ADF_ACRE_SWRadio = "**ACRE_PRC148**";` to the classname of the ACRE2 commander radio. If you wish to change, classnames can be found here: [http://gitlab.idi-systems.com/idi-systems/acre2-public/wikis/basic-concepts](http://gitlab.idi-systems.com/idi-systems/acre2-public/wikis/basic-concepts "ACRE2 radio classnames")
29. Change `_ADF_ACRE_LRRadio = "**ACRE_PRC117F**";` to the classname of the ACRE2 long range radio. If you wish to change, classnames can be found here: [http://gitlab.idi-systems.com/idi-systems/acre2-public/wikis/basic-concepts](http://gitlab.idi-systems.com/idi-systems/acre2-public/wikis/basic-concepts "ACRE2 radio classnames")
30. Change `_ADF_ACRE_fullDuplex = **true**;` to **true** or **false**. Sets the duplex of radio transmissions. If set to **true**, it means that you will receive transmissions even while talking and multiple people can speak at the same time.
31. Change `_ADF_ACRE_interference = **true**;` to **true** or **false**. Sets whether transmissions will interfere with each other. This, by default, causes signal loss when multiple people are transmitting on the same frequency..
32. Change `_ADF_ACRE_AIcanHear = **true**;` to **true** or **false**. Sets whether AI can detect players speaking.
33. Change `ADF_ACRE_preset = **false**;` to **true** or **false**. When set to true, the mission will use ACRE2 radio frequencies as defined in the **ADF_preset** ( 'Core\\F\\ADF_fnc_presets.sqf'.). If set to false than all radio's will use a flatnet for SW and one for LR. Please note that ACRE2 is WIP

#### Mission Balancing

1.  Change `_ADF_misBal = **false**;` to **true** or **false**. Load balancing (number of AI's vs number of players). For scripted missions only! See 'Core/F/ADF_fnc_missionBalancer.sqf' for more information.
2.  Change `_ADF_misBal_low = **10**;` to the number of players that represent a **low** number for the mission balancer. For scripted missions only! See 'Core/F/ADF_fnc_missionBalancer.sqf' for more information.
3.  Change `_ADF_misBal_high = **30**;` to the number of players that represent a **high** number for the mission balancer. For scripted missions only! See 'Core/F/ADF_fnc_missionBalancer.sqf' for more information.

#### Unit & Vehicle Caching

1.  Change `_ADF_Caching = **true**;` to **true** or **false**. When set to true AI groups will be cached according to a preset distance. Note that ADF_Caching is automatically disabled when a HC is active.
2.  Change `_ADF_Caching_unitDistance = **1000**;` to the distance from players that AI groups will be cached.
3.  Change `_ADF_Caching_vehicleDistance_land = **250**;` to the distance from players that AI ground vehicles will be cached.
4.  Change `_ADF_Caching_vehicleDistance_air = **1500**;` to the distance from players that AI air vehicles will be cached.
5.  Change `_ADF_Caching_vehicleDistance_sea = **2000**;` to the distance from players that AI sea vehicles will be cached.
6.  Change `_ADF_Caching_debugInfo = **false**;` to **true** or **false**. Set to true to log (screen and RPT) caching information.

#### View Distance

1.  Change `setViewDistance **1500**;` to the default view distance for players
2.  Change `ADF_VD_foot = **2000**;` to the **maximum** view distance for players on foot
3.  Change `ADF_VD_vehicle = **3000**;` to the **maximum** view distance for players inside a ground/sea vehicle
4.  Change `ADF_VD_air = **7500**;` to the **maximum** view distance for players inside an aircraft.
5.  Change `ADF_VD_allowNoGrass = **true**;` to **true** or **false**. Allow players to change the terrain details option to **low** (no grass)

#### F.A.R.P. Repair/Refuel/Rearm

1.  Change `ADF_FARP_repairTime = **180**;` to the **maximum** time in seconds it takes to repair a vehicle at the FARP.
2.  Change `ADF_FARP_reloadTime = **10**;` to the **maximum** time in seconds it takes to re-arm each turret magazine at the FARP.
3.  Change `ADF_FARP_refuelTime = **90**;` to the **maximum** time in seconds it takes to refuel a vehicle at the FARP.

#### Respawn / Mobile HQ (Mobile Respawn FOB)

1.  Change `ADF_Tickets = **true**;` to **true** or **false**. Set to true to enable the respawn ticket system (limited player respawns). Make sure that respawn is set to **"BASE"** in the description.ext
2.  Change `_ADF_wTixNr = **10**;` to the number of maximum respawns allowed for the **WEST** side (blufor)
3.  Change `_ADF_eTixNr = **15**;` to the number of maximum respawns allowed for the **EAST** side (opfor). Leave as is when no OpFor playable units are used.
4.  Change `_ADF_mhq_enable = **true**;` to **true** or **false**. Set to true to enable the Mobile HQ (MHQ). Players will respawn at the MHQ once the MHQ is deployed ingame.
5.  Change `_ADF_mhq_respawn_nr = **3**;` to the number respawns for a destroyed MHQ vehicle. If there are no more respawns available, the respawn marker (location where players respawn) is move to the last know 'safe position' of the MHQ.
6.  Change `ADF_mhq_respawn_time = **15**;` to the number of **minutes** it takes before a destroyed MHQ vehicle respawns (at the game's original start position, e.g. where the mission developer placed the MHQ vehicle in the editor).
7.  Change `_ADF_mhq_respawn_class = "**B_APC_Tracked_01_CRV_F**";` to MHQ vehicle classname (default is the 'Bobcat'). Any vehicle can be used. If you wish to change, classnames can be found here: [https://community.bistudio.com/wiki/Arma_3_CfgVehicles_WEST](https://community.bistudio.com/wiki/Arma_3_CfgVehicles_WEST "BIS Assets vehicles")
8.  Change `_ADF_mhq_deploy_time = **120**;` to the time in **seconds** it takes to deploy the MHQ (unpack the FOB). Setting this to a few minutes will add some immersion.
9.  Change `_ADF_mhq_packup_time = **180**;` to the time in **seconds** it takes to mobilize the MHQ (pack-up the FOB). Setting this to a few minutes will add some immersion.

#### Misc. third party mods/scripts

1.  '_ADF_DAC = **false**;` is WIP. Leave as is.
2.  Change `_ADF_civKia_enable = **false**;` to **true** or **false**. Set to true if you want to keep track of civilians killed by players.
3.  Change `_ADF_ambient_uCiv = **false**;` to **true** or **false**. Set to true to enable ambient **civilian persons** that spawn around the player(s).
4.  Change `_ADF_ambient_uCiv_nr =**1**;` to the number of civilians that spawn around the players. This number is the **maximum** number of civilian spawns (no matter the amount of players).
5.  Change `_ADF_ambient_uCiv_wpnr =**5**;` to the number of waypoint civilians will use to walk around. Do not change this unless you know what you are doing.
6.  Change `_ADF_ambient_uCiv_dist = **500**;` to the distance that civilians will spawn from the nearest player location. Do not set too high!
7.  Change `_ADF_ambient_vCiv = **false**;` to **true** or **false**. Set to true to enable ambient **civilian vehicles** (driving) that spawn around the player(s).
8.  Change `_ADF_ambient_vCiv_nr = **1**;` to the number of civilian vehicles that spawn around the players. This number is the **maximum** number of vehicle spawns (no matter the amount of players).
9.  Change `_ADF_ambient_vCiv_dist = **500**;` to the distance that civilian vehicles will spawn from the nearest player location. Do not set too high!
10. Change `_ADF_ambient_vCiv_del = **1000**;` to the distance that civilian vehicles will de-spawn from the nearest player location. Do not set too high!
11. Change `_ADF_CleanUp = **true**;` to **true** or **false**. Set to true to enable cleaning up of dead bodies (friendly, enemy, vehicles, etc.).
12. Change `_ADF_CleanUp_viewDist = **500**;` to set the minimum distance in meters from a player unit to allow deletion of dead bodies/vehicles, if you don't care if player sees the deletion, set it to 0.
13. Change `_ADF_CleanUp_manTimer = **300**;` to the number of **seconds** it takes for the script to delete a dead bodies when the viewDist param has cleared
14. Change `_ADF_CleanUp_vehTimer = **600**;`to the number of **seconds** it takes for the script to delete a destroyed vehicle when the viewDist param has cleared
15. Change `_ADF_CleanUp_abaTimer = **6000**;` to the number of **seconds** a deserted/unmanned vehicle will be deleted.
16. Change `_ADF_zeusEagle = **true**;` to **true** or **false**. Set to true to enable the Zeus Eagle? False removes the eagle.

Advanced editing - scripting spawning of units
----------------------------------------------

This section covers spawning of units/groups by scripts. Spawning using scripts we'll call Spawn on Demand (SOD). This enables mission makers to spawn units/groups/vehicles only when it is required/triggered and thus save server/HC performance. SOD can make your missions less linear and more dynamic.

ADF offers a few well documented sample scripts for you to learn about SOD. You'll find them in the Core\\ folder (**ADF\_DSG-Airborne.sqf**, **ADF\_DSG-FootPatrols.sqf**, **ADF\_DSG-Armored.sqf**)

### The basics

To spawn a unit/group/vehicle ARMA3 requires some information that the script should provide:

1.  **Location** - this can either be at the location of a marker, an object or even an existing (named) unit/group/player. You can also spawn using X,Y coordinates.
2.  **Group** - In case of spawning units and crewed vehicles you need to put them in a group. This group can be an existing group or a newly created group. For spawning empty vehicles creating a group is not required.
3.  **Classname** - The classname determines the type of unit/vehicle you are spawning.

### Spawning a group of infantry

We'll spawn a group of Opfor infantry once Blufor units enter a trigger-area. After we have spawned the Opfor group we'll order them to go on patrol. But first, using the ARMA3 editor, let's place a marker on the map and name it 'marker1'. The marker location represents the location where we will spawn our group of Opfor soldiers.

Open Notepad++ with a blank file and select SQF as the scripting **language** from the menu

We'll start by defining a variable for the group. This can be a local variable that we'll only use to create the group and nothing more. The local variable is deleted once the script has finished execution:

```php
// Create local vars for all connected clients:
_g = []; // Infantry group/section/squad variable
```

The '_g' is the local variable that is used to identify the group. We basically create an empty fireteam which we can fill with units. The '[]' brackets are enclosures for an array. An array is basically a list of data, in our case units. A filled array could look like this [Soldier1, Soldier2, Soldier3]. Each item is seperated with a comma.

Now that we have created an empty group, let's continue with the creation of the patrol units that are part of our still empty group. But first we inform ARMA3 that the units should only be created by the server or the headless client. If we don't do this than every connected client (all players and the server) will create a group of units. With 10 players conntected this means 10 Opfor groups. And we only want to create a single group of units.

```php
// Groups are created by/on the HC or server and visible for all clients.
if (!ADF_HC_execute) exitWith {}; // Autodetect: execute on the HC else execute on the server
```
	
Above 'if (!ADF_HC_execute) exitWith {};` means that only the HC or the server can continue with the script. All other clients (including all players) will exit the script (exitWith {};).

To create the units and store them in our '_g" group we use a ARMA3 function: **BIS_fnc_spawnGroup**. More information on this function can be found here: [BIS_fnc_spawnGroup](https://community.bistudio.com/wiki/BIS\_fnc\_spawnGroup)

```php
// Create a CSAT Recon Sentry group
_g = [
	getMarkerPos "marker1", // "marker1" is the location where the group is created
	EAST, // The side of the group
	(configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OI_reconSentry") // See http://community.bistudio.com/wiki/Ambient_Combat_Manager_-_Group_types for different types of groups.
] call BIS_fnc_spawnGroup; // Function that creates the group
```

In above script we use the group variable (_g) call the BIS_fnc_spawnGroup function. We supply the function with the position we want the group to spawn at (**getMarkerPos "marker1"**), the side of the group that we want to spawn (**EAST**), then we use a predefined group from the ARMA3 config (**configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OI_reconSentry"**). The (configFile >> ... "OI_reconSentry") part is a predefined group in ARMA3. Just like in the editor when you place a group of soldiers, the group consists of predefined units with loadout specifically for their role. Just like in the editor you can use these predefined groups with scripting as well. The group 'templates' are stored in what is called the ARMA3 configFile. Basically a database of sorts that stores all preconfigured information that is needed by the ARMA3 engine. You can retrieve this information by clicking on the 'Config Viewer' icon (top of the screen) in the editor. In case of predefined groups, you can also look up the information on the BIS Wiki (much quicker than the editor): [http://community.bistudio.com/wiki/Ambient_Combat_Manager_-_Group_types](http://community.bistudio.com/wiki/Ambient_Combat_Manager_-_Group_types "BIS Ambient Combat Manager"). The page explains how to make up the (configFile >> ... "OI_reconSentry") line of code.

So now we have spawned a group at the marker1 location. But they have no orders so they will just stand there and look dangerous. We want them to go on patrol. For that we call another function that tells them to go on patrol based on parameters that we feed into the function. Easy as pie:

```php
// Set patrol options
[
	_g, // Group local variable (does not need to be unique)
	getMarkerPos "marker1", // This is where the group will start patrolling. 
	125, // The radius in meters that determines the patrol size area.
	6, // The number of waypoints generated (use 4 to max 12 for really large areas. 5-7 is a good number.)
	"MOVE", // Waypoint type. ("MOVE", "DESTROY", "SAD", "SENTRY", "GUARD")
	"SAFE", // Behaviour type. ("CARELESS", "SAFE", "AWARE", "COMBAT", "STEALTH")
	"YELLOW", // Combat mode. ("BLUE" (Never fire), "GREEN" (Hold fire - defend only), "WHITE" (Hold fire, engage at will), "YELLOW" (Fire at will), "RED" (Fire at will, engage at will))
	"LIMITED", // Waypoint patrol speed. ("LIMITED", "NORMAL", "FULL")
	"COLUMN", // Patrol formation. ("COLUMN", "STAG COLUMN", "WEDGE", "ECH LEFT", "ECH RIGHT", "VEE", "LINE", "FILE", "DIAMOND")
	"this spawn CBA_fnc_taskSearchHouse", // Units will search houses (does not work afaik)
	[1,4,9]
] call CBA_fnc_taskPatrol; // Function (CBA) to create the patrol options
```

We are using the CBA A3 function **CBA_fnc_taskPatrol** for this. It is a quick 'n' dirty solution to created random patrols. We use the same group variable and also the spawn position (they are already there) to start their patrol.
We tell them the radius of the patrol area (measured from the start position (marker1) and then feed the function with waypoint information.
The last array with three numbers is the min, avg, max time the group waits at each waypoint.
More information: [https://dev.withsix.com/docs/cba/files/ai/fnc_taskPatrol-sqf.html](https://dev.withsix.com/docs/cba/files/ai/fnc_taskPatrol-sqf.html "CBA task patrol function")

So that's it. We created a 2 pax patrol group and gave them a patrol order with random waiypoints that are created by the CBA function.
Save the script in the Scr folder as ' Scr\**patrol.sqf**'. The entire script (without the comments) looks like this:

```php
// patrol.sqf

_g = [];

if (!ADF_HC_execute) exitWith {}; 

_g = [getMarkerPos "marker1",   EAST, (configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OI_reconSentry")] call BIS_fnc_spawnGroup;
[_g, getMarkerPos "marker1", 125, 6, "MOVE", "SAFE", "YELLOW", "LIMITED", "COLUMN", "this spawn CBA_fnc_taskSearchHouse", [1,4,9]] call CBA_fnc_taskPatrol; 
```

> Note that if you are not using the ADF framework, then replace: **if (!ADF_HC_execute) exitWith {};** with **if (!isServer) exitWith {};**

Now you can create a Trigger in the editor with the following settings (I only mention the settings you need to change):

-   Axis A: **500**
-   Axis B: **500**
-   Activation: **BLUFOR**
-   On Act.: **0 = execVM "Scr\Patrol.sqf";**

If you haven't already, create/place a marker on the map and name it "marker1". You may place the marker anywhere you want, inside or outside the trigger area. This is the position your enemy patrol group will spawn and start their patrol from.
Save your mission and test by entering the trigger area as a Blufor unit. The enemy patrol should spawn immediately.

You can spawn single units, groups, crewed vehicles, empty vehicles, etc. Have a look at the sample spawn scripts. You find then in the Core\\ folder (**ADF\_DSG-Airborne.sqf**, **ADF\_DSG-FootPatrols.sqf**, **ADF\_DSG-Armored.sqf**). For further reading on spawning units and such, have a look at:

-   [BIS spawn vehicle function](https://community.bistudio.com/wiki/BIS\_fnc\_spawnVehicle)
-   [BIS function createGroup](https://community.bistudio.com/wiki/createGroup)
-   [BIS function createUnit](https://community.bistudio.com/wiki/createUnit)
-   [BIS function createUnitArray](https://community.bistudio.com/wiki/createUnit\_array)
-   [BIS createVehicle](https://community.bistudio.com/wiki/createVehicle)
-   [BIS createVehicleArray](https://community.bistudio.com/wiki/createVehicle\_array)

Legal
-----

This file is part of the Arma Mission Development Framework (ADF). ADF is released under the [Arma Public Licence APL](https://www.bistudio.com/community/licenses/arma-public-license)

ADF uses the following third party scripts:

-   F3 Spectator is part of the [F3 Framework](http://ferstaberinde.com/f3/en/)
-   [TAW View Distance](http://forums.bistudio.com/showthread.php?151669-TAW-View-Distance-Script) by Tonic 
-   [ZBE_caching](http://forums.bistudio.com/showthread.php?179777-ZBE\_Cache-AI-amp-Vehicle-caching-script-addon) by Zorrobyte 
-   [MAD Ambient Life](http://forums.bistudio.com/showthread.php?166896-MAD-Ambient-Life-(SP-MP)) by MAD T
-   [Delete All](http://www.thebutcherbay.org/showthread.php?tid=63) by Anjan 
-   [Void Map Marker](http://www.armaholic.com/forums.php?m=posts&q=25540) by Void 

Commercial exploitation of the Software without written permission from The Author(s) is expressly prohibited. ADF is distributed without any warranty; without even the implied warranty of merchantability or fitness for a particular purpose. The Software is not an official addon or tool. Use of the Software (in whole or in part) is entirely at your own risk.
