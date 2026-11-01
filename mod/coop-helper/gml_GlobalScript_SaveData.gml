global.CurrentVersion = "_v2-0-0";

function apply_settings(arg0 = false)
{
    if (arg0)
    {
        window_set_size(640 * (global.Settings[1][0] + 1), 360 * (global.Settings[1][0] + 1));
        window_set_fullscreen(global.Settings[1][1]);
    }
    set_audio_volumes();
    if (global.Settings[3][UnknownEnum.Value_0])
    {
        display_mouse_lock_auto();
    }
    else
    {
        display_mouse_unlock();
    }
}

function default_settings()
{
    global.Settings[0] = [32, 27, 87, 65, 83, 68, 83, 87, 65, 68, 90, 88, 16, 49, 50, 51, 52, 53, 54, 55, 56, 81, 87, 69, 82, 32, 16];
    global.Settings[1] = [0, 0];
    global.Settings[2] = [10, 10, 10, 10, 0, 0, 0];
    global.Settings[3] = [0, 0, 4, 1, 0, 0, 0];
}

global.Guard = 0;
global.ShuffleMode = false;

function initialize_save_data()
{
    global.Night = 1;
    global.Difficulty = 1;
    global.StartRoom = NightOpening;
    global.ShuffleData = generate_shuffle_array(global.ShuffleMode);
    var Shuffle = global.ShuffleData.Animatronics;
    global.AllTimeSalvages = [Shuffle[UnknownEnum.Value_0], Shuffle[UnknownEnum.Value_1], Shuffle[UnknownEnum.Value_2], Shuffle[UnknownEnum.Value_3], Shuffle[UnknownEnum.Value_16]];
    global.RunEarnings = 0;
    global.RunEarningsTotal = 0;
    global.Upgrades = [];
    global.SalvagedMinigames = [false, false, false, false, false];
    global.SalvagedMasks = [false, false, false, false];
    global.SalvagedScraps = [false, false, false, false];
    global.CanContinue = false;
    global.Deaths = [0, 0, 0, 0, 0, 0];
    global.Route = UnknownEnum.Value_0;
    global.RunTime = 0;
    global.UnlockedAnimatronics = array_create(202, false);
    global.UnlockedTrophies = array_create(UnknownEnum.Value_63, false);
    global.UnlockedMinigames = array_create(30, false);
    global.UnlockedMinigames[UnknownEnum.Value_0] = true;
    global.UnlockedMinigames[UnknownEnum.Value_1] = true;
    global.DeathRecord = array_create(202, 0);
    global.ClearedChallenges = array_create(50, false);
    global.Playtime = 0;
    global.UnlockFlags = [];
    global.ClearedEndings = array_create(4, array_create(5, 0));
    global.ExtrasNotifs = 
    {
        AnimatronicsNotifs: array_create(256, bool(true)),
        ConceptArtNotifs: array_create(256, bool(true)),
        TrophyNotifs: array_create(128, bool(true))
    };
    global.SalvageRecord = array_create(202, 0);
    global.UpgradeRecord = array_create(UnknownEnum.Value_66, 0);
    global.TokensPerMinigame = array_create(30, 0);
    global.RunSpeedBest = 999999;
    global.RunEarningsBest = 0;
    global.EndlessStickers = array_create(202, -1);
    global.EndlessGuardStickers = array_create(40, -1);
    global.EleanorChallenge = undefined;
    global.UnlockedGuards = array_create(30, false);
    global.EndlessRoundsBeaten = 0;
    global.RunsAttempted = [];
    global.RunsWon = [];
    for (var g = 0; g < 22; g++)
    {
        for (var d = 0; d < 5; d++)
        {
            global.RunsAttempted[g][d] = 0;
            global.RunsWon[g][d] = 0;
        }
    }
    global.UnlockedGuards[UnknownEnum.Value_0] = true;
    global.UnlockedGuards[UnknownEnum.Value_1] = true;
    global.UnlockedGuards[UnknownEnum.Value_2] = true;
    global.HiScoresOverall = array_create(30, 0);
    global.BossHiScores = array_create(3, array_create(5, 0));
    global.HiScoresOverall[UnknownEnum.Value_0] = 360;
    global.HiScoresOverall[UnknownEnum.Value_4] = 360;
    global.HiScoresOverall[UnknownEnum.Value_7] = 360;
    global.FreshSave = true;
    global.TipNum = 0;
    global.GameFirstOpened = get_current_date();
    global.ShuffleSettings[UnknownEnum.Value_10] = false;
    var PossiblePrimes = [179, 283, 421, 547, 673, 811];
    global.FunValue[0] = irandom(99);
    global.FunValue[1] = PossiblePrimes[irandom(5)];
    global.Skins = array_create(202, -1);
    global.SkinOffice = -1;
    global.RandomizeSkins = false;
    global.RandomizeOffice = false;
    global.ShuffleCallsHeard = [];
    global.ShuffleSettings = array_create(11, true);
    global.ShuffleSettings[UnknownEnum.Value_0] = false;
    global.ShuffleSettings[UnknownEnum.Value_2] = false;
    global.ShuffleSettings[UnknownEnum.Value_10] = false;
    default_settings();
}

function create_save()
{
    var SaveStuff = 
    {
        _Night: global.Night,
        _StartRoom: global.StartRoom,
        _Difficulty: global.Difficulty,
        _Guard: global.Guard,
        _Salvages: global.AllTimeSalvages,
        _Masks: global.SalvagedMasks,
        _Scraps: global.SalvagedScraps,
        _Minigames: global.SalvagedMinigames,
        _Paycheck: global.RunEarnings,
        _PaycheckTotal: global.RunEarningsTotal,
        _CanContinue: global.CanContinue,
        _Upgrades: global.Upgrades,
        _Deaths: global.Deaths,
        _Route: global.Route,
        _RunTime: global.RunTime,
        _ShuffleMode: global.ShuffleMode,
        _ShuffleData: global.ShuffleData
    };
    var _string = json_stringify(SaveStuff);
    var _buffer = buffer_create(string_byte_length(_string) + 1, buffer_fixed, 1);
    buffer_write(_buffer, buffer_string, _string);
    buffer_save(_buffer, "savedata" + global.CurrentVersion + ".wario");
    buffer_delete(_buffer);
    show_debug_message("GAME SAVED! " + _string);
}

function save_permanent_data()
{
    var SaveStuff = 
    {
        _UnlockedAnimatronics: global.UnlockedAnimatronics,
        _UnlockedTrophies: global.UnlockedTrophies,
        _UnlockedMinigames: global.UnlockedMinigames,
        _DeathRecord: global.DeathRecord,
        _ClearedChallenges: global.ClearedChallenges,
        _Playtime: global.Playtime,
        _UnlockFlags: global.UnlockFlags,
        _ClearedEndings: global.ClearedEndings,
        _SalvageRecord: global.SalvageRecord,
        _UpgradeRecord: global.UpgradeRecord,
        _TokensPerMinigame: global.TokensPerMinigame,
        _RunSpeedBest: global.RunSpeedBest,
        _RunEarningsBest: global.RunEarningsBest,
        _HiScoresOverall: global.HiScoresOverall,
        _GameFirstOpened: global.GameFirstOpened,
        _TipNum: global.TipNum,
        _BossHiScores: global.BossHiScores,
        _ExtrasNotifs: global.ExtrasNotifs,
        _Skins: global.Skins,
        _SkinOffice: global.SkinOffice,
        _RandomizeSkins: global.RandomizeSkins,
        _RandomizeOffice: global.RandomizeOffice,
        _ShuffleSettings: global.ShuffleSettings,
        _EndlessStickers: global.EndlessStickers,
        _EndlessGuardStickers: global.EndlessGuardStickers,
        _UnlockedGuards: global.UnlockedGuards,
        _EndlessRoundsBeaten: global.EndlessRoundsBeaten,
        _ShuffleCallsHeard: global.ShuffleCallsHeard,
        _RunsAttempted: global.RunsAttempted,
        _RunsWon: global.RunsWon,
        _Settings: global.Settings,
        _FunValue: global.FunValue,
        _FreshSave: global.FreshSave
    };
    var _string = json_stringify(SaveStuff);
    var _buffer = buffer_create(string_byte_length(_string) + 1, buffer_fixed, 1);
    buffer_write(_buffer, buffer_string, _string);
    buffer_save(_buffer, "records" + global.CurrentVersion + ".wario");
    buffer_delete(_buffer);
    show_debug_message("GAME SAVED! " + _string);
}

function initialize_endless_data()
{
    global.EndlessRound = 1;
    global.StartRoom = EndlessShopSelection;
    global.Lives = [0, 0, 0];
    global.EndlessInventory = 
    {
        Cartridges: array_create(20, false),
        Consumables: [],
        BobbiedotRegimen: -1,
        WhackedChars: [],
        MarkiplierPoints: 0,
        RoundDebt: 0,
        BarrierBooze: 0,
        BossCall: false
    };
    global.Upgrades = [];
    global.EndlessInventory.Cartridges = [UnknownEnum.Value_1, UnknownEnum.Value_2, UnknownEnum.Value_8];
    global.TimesHealed = 0;
    global.RepeatPrevention = 
    {
        Animatronics: [],
        Shops: [-1, -1],
        Upgrades: [],
        Challenges: -1
    };
    global.Difficulty = 1;
    global.AllTimeSalvages = [UnknownEnum.Value_16];
    global.RunEarnings = 0;
    global.RunEarningsTotal = 0;
    global.RunTime = 0;
    global.DeathsThisRound = 0;
    global.CanContinue = false;
    global.NuzlockeMode = false;
    global.EleanorChallenge = undefined;
    global.Deaths = 0;
    global.Beaten = false;
    initialize_ability_index();
    set_guard_parameters();
    global.CheckForEndlessSave = false;
    global.Seed = random_get_seed();
    global.ModHelperMode = false;
    global.ModCoopGuards = [];
}

set_guard_parameters(UnknownEnum.Value_1);

function get_daily_seed()
{
    var SeedDate = date_current_datetime();
    return date_get_day(SeedDate) + date_get_week(SeedDate) + date_get_year(SeedDate);
}

randomize();
global.Seed = random_get_seed();
global.AbilityIndex = countup_array(20);

function save_endless_data(arg0 = EndlessSelection, arg1 = true)
{
    var SaveStuff = 
    {
        _EndlessRound: global.EndlessRound,
        _StartRoom: arg0,
        _Lives: global.Lives,
        _Upgrades: global.Upgrades,
        _EndlessInventory: global.EndlessInventory,
        _RepeatPrevention: global.RepeatPrevention,
        _Difficulty: global.Difficulty,
        _Guard: global.Guard,
        _Salvages: global.AllTimeSalvages,
        _Paycheck: global.RunEarnings,
        _PaycheckTotal: global.RunEarningsTotal,
        _RunTime: global.RunTime,
        _CanContinue: arg1,
        _DeathsThisRound: global.DeathsThisRound,
        _TimesHealed: global.TimesHealed,
        _NuzlockeMode: global.NuzlockeMode,
        _EleanorChallenge: global.EleanorChallenge,
        _AbilityIndex: global.AbilityIndex,
        _Seed: global.Seed,
        _Deaths: global.Deaths,
        _Beaten: global.Beaten,
        _ModHelperMode: global.ModHelperMode,
        _ModCoopGuards: global.ModCoopGuards
    };
    var _string = json_stringify(SaveStuff);
    var _buffer = buffer_create(string_byte_length(_string) + 1, buffer_fixed, 1);
    buffer_write(_buffer, buffer_string, _string);
    buffer_save(_buffer, "endlessdata" + global.CurrentVersion + ".txt");
    buffer_delete(_buffer);
}

function load_endless_data()
{
    try
    {
        if (file_exists("endlessdata" + global.CurrentVersion + ".txt"))
        {
            var _buffer = buffer_load("endlessdata" + global.CurrentVersion + ".txt");
            var _string = buffer_read(_buffer, buffer_string);
            var _LoadData = json_parse(_string);
            buffer_delete(_buffer);
            global.EndlessRound = _LoadData._EndlessRound;
            global.StartRoom = _LoadData._StartRoom;
            global.Lives = _LoadData._Lives;
            global.Upgrades = _LoadData._Upgrades;
            global.EndlessInventory = _LoadData._EndlessInventory;
            global.RepeatPrevention = _LoadData._RepeatPrevention;
            global.Difficulty = _LoadData._Difficulty;
            global.Guard = _LoadData._Guard;
            global.AllTimeSalvages = _LoadData._Salvages;
            global.RunEarnings = _LoadData._Paycheck;
            global.RunEarningsTotal = _LoadData._PaycheckTotal;
            global.RunTime = _LoadData._RunTime;
            global.CanContinue = _LoadData._CanContinue;
            global.DeathsThisRound = _LoadData._DeathsThisRound;
            global.TimesHealed = _LoadData._TimesHealed;
            global.NuzlockeMode = _LoadData._NuzlockeMode;
            global.EleanorChallenge = _LoadData._EleanorChallenge;
            global.AbilityIndex = _LoadData._AbilityIndex;
            global.Seed = _LoadData._Seed;
            global.Deaths = _LoadData._Deaths;
            global.Beaten = _LoadData._Beaten;
            global.ModHelperMode = variable_struct_exists(_LoadData, "_ModHelperMode") ? _LoadData._ModHelperMode : false;
            global.ModCoopGuards = variable_struct_exists(_LoadData, "_ModCoopGuards") ? _LoadData._ModCoopGuards : [];
            show_debug_message("Endless Data Loaded: " + _string);
        }
        else
        {
            save_endless_data();
        }
    }
    catch (_exception)
    {
        show_message("ERR: Your run data appears to be corrupted. You may need to start a new run.");
    }
}

function load_save()
{
    try
    {
        if (file_exists("savedata" + global.CurrentVersion + ".wario"))
        {
            var _buffer = buffer_load("savedata" + global.CurrentVersion + ".wario");
            var _string = buffer_read(_buffer, buffer_string);
            buffer_delete(_buffer);
            var _LoadData = json_parse(_string);
            global.Night = _LoadData._Night;
            global.StartRoom = _LoadData._StartRoom;
            global.Difficulty = _LoadData._Difficulty;
            global.Guard = _LoadData._Guard;
            global.AllTimeSalvages = _LoadData._Salvages;
            global.SalvagedMasks = _LoadData._Masks;
            global.SalvagedScraps = _LoadData._Scraps;
            global.SalvagedMinigames = _LoadData._Minigames;
            global.RunEarnings = _LoadData._Paycheck;
            global.RunEarningsTotal = _LoadData._PaycheckTotal;
            global.CanContinue = _LoadData._CanContinue;
            global.Upgrades = _LoadData._Upgrades;
            global.Deaths = _LoadData._Deaths;
            global.Route = _LoadData._Route;
            global.RunTime = _LoadData._RunTime;
            global.ShuffleMode = _LoadData._ShuffleMode;
            global.ShuffleData = _LoadData._ShuffleData;
            show_debug_message("GAME LOADED! " + _string);
        }
        else
        {
            create_save();
        }
    }
    catch (_exception)
    {
        show_message("ERR: Your run data appears to be corrupted. You may need to start a new save file.");
    }
}

function load_permanent_data()
{
    try
    {
        if (file_exists("records" + global.CurrentVersion + ".wario"))
        {
            var _buffer = buffer_load("records" + global.CurrentVersion + ".wario");
            var _string = buffer_read(_buffer, buffer_string);
            buffer_delete(_buffer);
            var _LoadData = json_parse(_string);
            if (array_length(_LoadData._Settings[3]) < array_length(global.Settings[3]))
            {
                _LoadData._Settings[3] = global.Settings[3];
            }
            if (array_length(_LoadData._ExtrasNotifs.ConceptArtNotifs) < array_length(global.ExtrasNotifs.ConceptArtNotifs))
            {
                _LoadData._ExtrasNotifs.ConceptArtNotifs = global.ExtrasNotifs.ConceptArtNotifs;
            }
            if (array_length(_LoadData._UpgradeRecord) < array_length(global.UpgradeRecord))
            {
                repeat (array_length(global.UpgradeRecord) - array_length(_LoadData._UpgradeRecord))
                {
                    array_push(_LoadData._UpgradeRecord, 0);
                }
            }
            global.UnlockedAnimatronics = _LoadData._UnlockedAnimatronics;
            global.UnlockedTrophies = _LoadData._UnlockedTrophies;
            global.UnlockedMinigames = _LoadData._UnlockedMinigames;
            global.DeathRecord = _LoadData._DeathRecord;
            global.ClearedChallenges = _LoadData._ClearedChallenges;
            global.Settings = _LoadData._Settings;
            global.FunValue = _LoadData._FunValue;
            global.Playtime = _LoadData._Playtime;
            global.UnlockFlags = _LoadData._UnlockFlags;
            global.ClearedEndings = _LoadData._ClearedEndings;
            global.SalvageRecord = _LoadData._SalvageRecord;
            global.UpgradeRecord = _LoadData._UpgradeRecord;
            global.TokensPerMinigame = _LoadData._TokensPerMinigame;
            global.RunSpeedBest = _LoadData._RunSpeedBest;
            global.RunEarningsBest = _LoadData._RunEarningsBest;
            global.HiScoresOverall = _LoadData._HiScoresOverall;
            global.GameFirstOpened = _LoadData._GameFirstOpened;
            global.TipNum = _LoadData._TipNum;
            if (variable_struct_exists(_LoadData, "_BossHiScores"))
            {
                global.BossHiScores = _LoadData._BossHiScores;
            }
            if (variable_struct_exists(_LoadData, "_ExtrasNotifs"))
            {
                global.ExtrasNotifs = _LoadData._ExtrasNotifs;
            }
            if (variable_struct_exists(_LoadData, "_Skins"))
            {
                global.Skins = _LoadData._Skins;
            }
            if (variable_struct_exists(_LoadData, "_SkinOffice"))
            {
                global.SkinOffice = _LoadData._SkinOffice;
            }
            if (variable_struct_exists(_LoadData, "_RandomizeSkins"))
            {
                global.RandomizeSkins = _LoadData._RandomizeSkins;
            }
            if (variable_struct_exists(_LoadData, "_RandomizeOffice"))
            {
                global.RandomizeOffice = _LoadData._RandomizeOffice;
            }
            if (variable_struct_exists(_LoadData, "_EndlessStickers"))
            {
                global.EndlessStickers = _LoadData._EndlessStickers;
            }
            if (variable_struct_exists(_LoadData, "_EndlessRoundsBeaten"))
            {
                global.EndlessRoundsBeaten = _LoadData._EndlessRoundsBeaten;
            }
            if (variable_struct_exists(_LoadData, "_EndlessGuardStickers"))
            {
                global.EndlessGuardStickers = _LoadData._EndlessGuardStickers;
            }
            if (variable_struct_exists(_LoadData, "_UnlockedGuards"))
            {
                global.UnlockedGuards = _LoadData._UnlockedGuards;
            }
            if (variable_struct_exists(_LoadData, "_RunsAttempted"))
            {
                global.RunsAttempted = _LoadData._RunsAttempted;
            }
            if (variable_struct_exists(_LoadData, "_RunsWon"))
            {
                global.RunsWon = _LoadData._RunsWon;
            }
            if (variable_struct_exists(_LoadData, "_ShuffleSettings"))
            {
                global.ShuffleSettings = _LoadData._ShuffleSettings;
            }
            if (variable_struct_exists(_LoadData, "_ShuffleSettings"))
            {
                global.ShuffleSettings = _LoadData._ShuffleSettings;
            }
            if (variable_struct_exists(_LoadData, "_FreshSave"))
            {
                global.FreshSave = _LoadData._FreshSave;
            }
            if (variable_struct_exists(_LoadData, "_ShuffleCallsHeard"))
            {
                global.ShuffleCallsHeard = _LoadData._ShuffleCallsHeard;
            }
            if (array_length(global.UnlockedAnimatronics) < 202)
            {
                repeat (53)
                {
                    array_insert(global.UnlockedAnimatronics, 47, false);
                    array_insert(global.SalvageRecord, 47, false);
                    array_insert(global.DeathRecord, 47, false);
                    array_insert(global.ExtrasNotifs.AnimatronicsNotifs, 47, false);
                }
            }
            while (array_length(global.UnlockedAnimatronics) < 202)
            {
                array_push(global.UnlockedAnimatronics, false);
            }
            while (array_length(global.UnlockedTrophies) < UnknownEnum.Value_63)
            {
                array_push(global.UnlockedTrophies, false);
            }
            show_debug_message("GAME LOADED! " + _string);
        }
        else
        {
            save_permanent_data();
        }
    }
    catch (_exception)
    {
        show_message("ERR: Your save data appears to be corrupted. You may need to reset your data.");
    }
}

initialize_save_data();
initialize_endless_data();
load_save();
load_permanent_data();
apply_settings();
window_set_cursor(cr_default);
global.CurrentChallenge = undefined;
global.Cheats = array_create(10, false);
global.CallMuted = false;
global.BossPhase = 0;
global.SalvagesCurrent = [];
global.SavedTime = 0;
global.SavedBossTime = 0;
global.ThisBossHiScore = 0;
reset_challenge_alterations();
if (!directory_exists("addons"))
{
    directory_create("addons");
}
if (!directory_exists("offices"))
{
    directory_create("offices");
}
if (!directory_exists("skins"))
{
    directory_create("skins");
}

function old_to_new(arg0)
{
    if (arg0 <= UnknownEnum.Value_46)
    {
        return arg0;
    }
    switch (arg0)
    {
        case 47:
            return UnknownEnum.Value_118;
        case 48:
            return UnknownEnum.Value_119;
        case 49:
            return UnknownEnum.Value_120;
        case 50:
            return UnknownEnum.Value_121;
        case 51:
            return UnknownEnum.Value_122;
        case 52:
            return UnknownEnum.Value_123;
        case 53:
            return UnknownEnum.Value_124;
        case 54:
            return UnknownEnum.Value_125;
        case 55:
            return UnknownEnum.Value_126;
        case 56:
            return UnknownEnum.Value_128;
        case 57:
            return UnknownEnum.Value_129;
        case 58:
            return UnknownEnum.Value_130;
        case 59:
            return UnknownEnum.Value_154;
        case 60:
            return UnknownEnum.Value_155;
        case 61:
            return UnknownEnum.Value_167;
        case 62:
            return UnknownEnum.Value_158;
        case 63:
            return UnknownEnum.Value_163;
        case 64:
            return UnknownEnum.Value_156;
        case 65:
            return UnknownEnum.Value_157;
        case 66:
            return UnknownEnum.Value_159;
        case 67:
            return UnknownEnum.Value_160;
        case 68:
            return UnknownEnum.Value_161;
        case 69:
            return UnknownEnum.Value_162;
        default:
            return -1;
    }
}

function records_data_transfer()
{
    if (file_exists("records2-13-25.wario"))
    {
        var _buffer = buffer_load("records2-13-25.wario");
        var _string = buffer_read(_buffer, buffer_string);
        buffer_delete(_buffer);
        var _LoadData = json_parse(_string);
        for (var i = 0; i < array_length(_LoadData._UnlockedAnimatronics); i++)
        {
            var newID = old_to_new(i);
            if (newID == -1)
            {
                continue;
            }
            global.UnlockedAnimatronics[newID] = _LoadData._UnlockedAnimatronics[i];
            global.ExtrasNotifs.AnimatronicsNotifs[newID] = false;
        }
        for (var i = 0; i < array_length(_LoadData._DeathRecord); i++)
        {
            var newID = old_to_new(i);
            if (newID == -1)
            {
                continue;
            }
            global.DeathRecord[newID] = _LoadData._DeathRecord[i];
        }
        for (var i = 0; i < array_length(_LoadData._SalvageRecord); i++)
        {
            var newID = old_to_new(i);
            if (newID == -1)
            {
                continue;
            }
            global.SalvageRecord[newID] = _LoadData._SalvageRecord[i];
        }
        for (var i = 0; i < min(47, array_length(_LoadData._UnlockedTrophies)); i++)
        {
            if (array_contains([UnknownEnum.Value_21, UnknownEnum.Value_33, UnknownEnum.Value_34, UnknownEnum.Value_37, UnknownEnum.Value_38, UnknownEnum.Value_16, UnknownEnum.Value_32, UnknownEnum.Value_40, UnknownEnum.Value_44, UnknownEnum.Value_42], i))
            {
                continue;
            }
            global.UnlockedTrophies[i] = _LoadData._UnlockedTrophies[i];
        }
        for (var i = 0; i < min(array_length(_LoadData._UnlockedMinigames), array_length(_LoadData._TokensPerMinigame), array_length(_LoadData._HiScoresOverall)); i++)
        {
            global.UnlockedMinigames[i] = _LoadData._UnlockedMinigames[i];
            global.TokensPerMinigame[i] = _LoadData._TokensPerMinigame[i];
            global.HiScoresOverall[i] = _LoadData._HiScoresOverall[i];
        }
        for (var i = 0; i < array_length(_LoadData._UpgradeRecord); i++)
        {
            global.UpgradeRecord[i] = _LoadData._UpgradeRecord[i];
        }
        var OldChallenges = [UnknownEnum.Value_1, UnknownEnum.Value_3, UnknownEnum.Value_0, UnknownEnum.Value_5, UnknownEnum.Value_8, UnknownEnum.Value_9, UnknownEnum.Value_10, UnknownEnum.Value_11, UnknownEnum.Value_13, UnknownEnum.Value_15, UnknownEnum.Value_17, UnknownEnum.Value_18, UnknownEnum.Value_20, UnknownEnum.Value_22, UnknownEnum.Value_23, UnknownEnum.Value_30, UnknownEnum.Value_31, UnknownEnum.Value_32, UnknownEnum.Value_33, UnknownEnum.Value_36, UnknownEnum.Value_40, UnknownEnum.Value_42];
        for (var i = 0; i < min(array_length(_LoadData._ClearedChallenges), array_length(OldChallenges)); i++)
        {
            global.ClearedChallenges[OldChallenges[i]] = _LoadData._ClearedChallenges[i];
        }
        if (variable_struct_exists(_LoadData, "_RunEarningsBest"))
        {
            global.RunEarningsBest = _LoadData._RunEarningsBest;
        }
        if (variable_struct_exists(_LoadData, "_RunSpeedBest"))
        {
            global.RunSpeedBest = _LoadData._RunSpeedBest;
        }
        if (variable_struct_exists(_LoadData, "_TipNum"))
        {
            global.TipNum = _LoadData._TipNum;
        }
        if (variable_struct_exists(_LoadData, "_GameFirstOpened"))
        {
            global.GameFirstOpened = _LoadData._GameFirstOpened;
        }
        if (variable_struct_exists(_LoadData, "_FunValue"))
        {
            global.FunValue = _LoadData._FunValue;
        }
        if (variable_struct_exists(_LoadData, "_Playtime"))
        {
            global.Playtime = _LoadData._Playtime;
        }
        if (variable_struct_exists(_LoadData, "_UnlockFlags"))
        {
            global.UnlockFlags = _LoadData._UnlockFlags;
        }
        if (variable_struct_exists(_LoadData, "_BossHiScores"))
        {
            global.BossHiScores = _LoadData._BossHiScores;
        }
        if (variable_struct_exists(_LoadData, "_ClearedEndings"))
        {
            global.ClearedEndings = _LoadData._ClearedEndings;
        }
    }
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3,
    Value_4,
    Value_5,
    Value_7 = 7,
    Value_8,
    Value_9,
    Value_10,
    Value_11,
    Value_13 = 13,
    Value_15 = 15,
    Value_16,
    Value_17,
    Value_18,
    Value_20 = 20,
    Value_21,
    Value_22,
    Value_23,
    Value_30 = 30,
    Value_31,
    Value_32,
    Value_33,
    Value_34,
    Value_36 = 36,
    Value_37,
    Value_38,
    Value_40 = 40,
    Value_42 = 42,
    Value_44 = 44,
    Value_46 = 46,
    Value_63 = 63,
    Value_66 = 66,
    Value_118 = 118,
    Value_119,
    Value_120,
    Value_121,
    Value_122,
    Value_123,
    Value_124,
    Value_125,
    Value_126,
    Value_128 = 128,
    Value_129,
    Value_130,
    Value_154 = 154,
    Value_155,
    Value_156,
    Value_157,
    Value_158,
    Value_159,
    Value_160,
    Value_161,
    Value_162,
    Value_163,
    Value_167 = 167
}
