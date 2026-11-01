if (Freeze == 0)
{
    if (HandheldUp)
    {
        HandheldOffset += ((360 - HandheldOffset) / 5);
    }
    else
    {
        HandheldOffset += ((740 - HandheldOffset) / 5);
    }
    if (global.Night == "Custom" && global.Route != UnknownEnum.Value_0)
    {
        BossTimer += 0.016666666666666666;
    }
    if ((floor(global.Timer) % 30) == 0 && eleanor_challenge_active(UnknownEnum.Value_10) && !instance_exists(oShopItem_KingsPrize))
    {
        instance_create_depth(320, -32, 0, oShopItem_KingsPrize);
    }
    var SE1 = 1000;
    var SE2 = 1100;
    var SE3 = 1;
    if (input_check_pressed(UnknownEnum.Value_8))
    {
        if (BossMode != UnknownEnum.Value_1)
        {
            if (global.Tools.Doors[0] == 0 && !instance_exists(oLaserDoor) && BossMode != UnknownEnum.Value_1)
            {
                global.Doors[0] = !global.Doors[0];
                simple_sound(sfxDoor, -400, 0, false, 1, 15, global.Doors[0] ? 1 : 1.1);
            }
            else
            {
                error();
            }
        }
    }
    if (input_check_pressed(UnknownEnum.Value_9))
    {
        if (BossMode != UnknownEnum.Value_1)
        {
            if (global.Tools.Doors[1] == 0 && !instance_exists(oLaserDoor))
            {
                global.Doors[1] = !global.Doors[1];
                simple_sound(sfxDoor, 400, 0, false, 1, 15, global.Doors[1] ? 1 : 1.1);
            }
            else
            {
                error();
            }
        }
    }
    if (input_check_pressed(UnknownEnum.Value_6) && !global.MaskDown)
    {
        if (global.PanelUp)
        {
            global.PanelUp = false;
        }
        else if (BossMode == UnknownEnum.Value_1 && global.Tools.Camera == 0)
        {
            HandheldUp = !HandheldUp;
            audio_play_sound(sfxMonitor, 10, false);
            if (HandheldUp)
            {
                instance_activate_object(oHappiestDayDrawer);
            }
        }
        else if (global.Tools.Camera == 0)
        {
            global.CamUp = !global.CamUp;
            CamAlpha = 1;
            audio_play_sound(sfxMonitor, 10, false);
            global.PanelUp = false;
        }
        else
        {
            error();
        }
    }
    else if (input_check_pressed(UnknownEnum.Value_6) && helper_active())
    {
        error();
    }
    if (!global.CamUp)
    {
        global.MonitorSystem = "Cameras";
        global.Cam = global.SavedCam;
    }
    if (input_check_pressed(UnknownEnum.Value_11) && BossMode != UnknownEnum.Value_1 && !guard_ability(UnknownEnum.Value_18))
    {
        if (global.Tools.Fan == 0)
        {
            audio_play_sound(sfxBump, 10, false);
            global.Fan = !global.Fan;
            if (global.Fan)
            {
                simple_sound(sfxFan, 64, -128, depth, 1);
            }
        }
        else
        {
            error();
        }
    }
    if (!global.Fan)
    {
        audio_stop_sound(sfxFan);
    }
    if (input_check_pressed(UnknownEnum.Value_7) && !(global.CamUp || HandheldUp))
    {
        if (global.Tools.Mask == 0)
        {
            global.MaskDown = !global.MaskDown;
            if (!global.MaskDown)
            {
                audio_bus_main.effects[0] = undefined;
                audio_play_sound(sfxMaskOff, 10, false);
            }
            else
            {
                audio_play_sound(sfxMaskOn, 10, false);
                audio_bus_main.effects[0] = Muffler;
            }
        }
        else
        {
            error();
        }
    }
    else if (input_check_pressed(UnknownEnum.Value_7) && helper_active())
    {
        error();
    }
    if (instance_exists(oPauser) && !oPauser.Paused)
    {
        if (global.MaskDown && audio_bus_main.effects[0] == undefined)
        {
            audio_bus_main.effects[0] = Muffler;
        }
    }
    global.Flashlight = input_check(UnknownEnum.Value_10) && global.Tools.Flashlight == 0 && !HandheldUp;
    if (input_check_pressed(UnknownEnum.Value_10) && !HandheldUp)
    {
        if (global.Tools.Flashlight == 0)
        {
            audio_play_sound(sfxFlashlightOn, 10, false);
        }
        else
        {
            audio_play_sound(sfxError, 10, false);
        }
    }
    if (input_check_released(UnknownEnum.Value_10) && global.Tools.Flashlight == 0 && !HandheldUp)
    {
        audio_play_sound(sfxFlashlightOff, 10, false);
    }
}
if (input_check_pressed(UnknownEnum.Value_12) && !global.CamUp)
{
    global.TurnedAround = !global.TurnedAround;
    global.PanelUp = false;
}
if (!global.TurnedAround)
{
    global.PanelUp = false;
}
if (global.Power <= 0 && global.Power > -999)
{
    powerdown();
}
if (global.Power <= 0)
{
    global.Brightness = min(global.Brightness + 0.01, 1);
}
Usage = global.CamUp + global.Doors[0] + global.Doors[1] + global.Flashlight + global.Fan;
if (instance_exists(oLaserDoor))
{
    Usage -= (global.Doors[0] + global.Doors[1]);
}
if (InfinitePowerCutoffTime <= 0)
{
    var InterpretedUsage = Usage;
    if (guard_ability(UnknownEnum.Value_16))
    {
        InterpretedUsage = (Usage > 1) ? power(Usage * 2, 2) : 0;
        if (InterpretedUsage > 0 && !audio_is_playing(sfxHudsonWarning))
        {
            audio_play_sound(sfxHudsonWarning, 15, true, 0.5);
        }
        else if (InterpretedUsage == 0)
        {
            audio_stop_sound(sfxHudsonWarning);
        }
    }
    if (guard_ability(UnknownEnum.Value_15) && global.Power > 0 && !instance_exists(oVanniMask))
    {
        DrainRate = lerp(3, 1, 0.25);
        InterpretedUsage *= 5;
        if (global.MaskDown && Usage <= 2)
        {
            global.Power += min((10 * (2 - Usage)) / 60, max(0, MaxPower - global.Power));
        }
    }
    if (guard_ability(UnknownEnum.Value_21))
    {
        InterpretedUsage -= global.CamUp;
        InterpretedUsage *= 2;
    }
    drain_power((DrainRate * InterpretedUsage * global.GuardParameters.power_rate) / 180);
    if (global.Difficulty < 3)
    {
        if (global.Night == 1)
        {
            global.Power += ((InterpretedUsage / 180) * 0.2);
        }
        if (global.Night == 2)
        {
            global.Power += ((InterpretedUsage / 180) * 0.1);
        }
    }
}
else
{
    InfinitePowerCutoffTime -= 0.016666666666666666;
}
if (global.Fan)
{
    global.Temperature -= ((FanSpeed * 2) / 60);
}
else if (BossMode != UnknownEnum.Value_1)
{
    if (guard_ability(UnknownEnum.Value_18))
    {
        global.Temperature += ((TemperatureRate * 0.4) / 60);
    }
    else
    {
        global.Temperature += (TemperatureRate / 60);
    }
}
global.Temperature = clamp(global.Temperature, MinTemperature, 40);
if (global.Cheats[UnknownEnum.Value_4])
{
    global.Temperature = min(global.Temperature, 0);
}
if (global.Temperature >= 40 && !instance_exists(oJumpscare))
{
    if (BossMode == UnknownEnum.Value_1)
    {
        jumpscare(UnknownEnum.Value_121, 0);
    }
    else
    {
        jumpscare(-1, 0);
    }
}
var FredbearMode = instance_exists(oFredbear);
if (BossMode != UnknownEnum.Value_2 && BossMode != UnknownEnum.Value_1)
{
    if (!FredbearMode && guard_ability(UnknownEnum.Value_19))
    {
        var TimerShift = sign(floor(MinigameCompletionPoints) - global.Progress);
        if (abs(TimerShift) >= 1)
        {
            global.Progress += TimerShift;
            audio_play_sound(sfxTick, 1, false);
        }
    }
    else if (!FredbearMode && guard_ability(UnknownEnum.Value_8))
    {
        MinigameCompletionPoints = global.Tokens;
        var TimerShift = sign(floor(MinigameCompletionPoints) - global.Progress);
        if (abs(TimerShift) >= 1)
        {
            global.Progress += (TimerShift / 2);
            audio_play_sound(sfxTick, 1, false);
        }
    }
    if (guard_ability(UnknownEnum.Value_17) && !FredbearMode)
    {
        if (global.CamUp)
        {
            global.Timer += (0.016666666666666666 * (global.TurnedAround ? 1.5 : 0.75));
            audio_sound_gain(sfxMaryMusicPlayer, global.TurnedAround * 0.25, 0);
        }
        else if (global.TurnedAround)
        {
            global.Timer += (1/30);
            if (!audio_is_playing(sfxMaryMusicPlayer) && !Freeze)
            {
                audio_play_sound(sfxMaryMusicPlayer, 30, true, 1);
            }
            audio_sound_gain(sfxMaryMusicPlayer, 0.5, 0);
        }
        else
        {
            global.Timer += (1/120);
            audio_sound_gain(sfxMaryMusicPlayer, 0, 0);
        }
        global.Progress = global.Timer;
    }
    else
    {
        if (((floor((global.Timer * 60) / 5) * 5) % 60) == 0 && !audio_is_playing(sfxClockTicking))
        {
            simple_sound(sfxClockTicking, 500, 0, false, 0.5, 1, random_range(0.9, 1.1));
        }
        global.Timer += 0.016666666666666666;
        if (!(guard_ability(UnknownEnum.Value_8) || guard_ability(UnknownEnum.Value_19)) || FredbearMode)
        {
            global.Progress = global.Timer;
        }
    }
}
global.Tools = 
{
    Camera: max(global.Tools.Camera - 1, 0),
    Doors: [max(global.Tools.Doors[0] - 1, 0), max(global.Tools.Doors[1] - 1, 0)],
    Fan: max(global.Tools.Fan - 1, 0),
    Mask: max(global.Tools.Mask - 1, 0),
    Flashlight: max(global.Tools.Flashlight - 1, 0),
    AudioLure: [max(global.Tools.AudioLure[0] - 1, 0), max(global.Tools.AudioLure[1] - 1, 0)]
};
if (StareFrames > -180)
{
    StareFrames--;
}
if (keyboard_check(ord("F")) && keyboard_check_pressed(ord("B")) && global.DevMode)
{
    if (BossMode == UnknownEnum.Value_2)
    {
        with (oSalvage)
        {
            lose_hp(20, true);
        }
    }
    else if (BossMode == UnknownEnum.Value_3)
    {
        instance_destroy(oFredbearManager);
        end_office_processes(true);
        instance_create_depth(0, 0, 0, oFredbear_EndingScare);
        Block6AMTransition = true;
    }
    else
    {
        win_night();
    }
}
if (global.CupcakeMeter < 1)
{
    global.CupcakeMeter = max(global.CupcakeMeter - 0.002, 0);
}
if (Lockdown && (global.Progress + LockdownTime) >= global.ProgressToMake && !instance_exists(oLaserDoor))
{
    Lockdown = false;
    instance_create_layer(832, 742, "OnWall", oLaserDoor);
    instance_create_layer(1856, 742, "OnWall", oLaserDoor);
    simple_sound(sfxDoor, -400, 0, false);
    simple_sound(sfxDoor, 400, 0, false);
    global.Doors = [1, 1];
    notification("Lockdown Protocol activated!");
    instance_destroy(oGlamrockFreddy);
}
if (global.Progress >= global.ProgressToMake && !audio_is_playing(sfxWarioLose) && !Block6AMTransition && !instance_exists(oEleanor_ScoreTracker))
{
    if (!instance_exists(oJumpscare))
    {
        var BeartrapTanks = instance_number(oShopItem_Beartrap) + (immune_to_jumpscares() * 999);
        if (eleanor_challenge_active(UnknownEnum.Value_5))
        {
            BeartrapTanks = 0;
        }
        for (var i = 0; i < instance_number(oShopItemUltra_Beartrap); i++)
        {
            BeartrapTanks += instance_find(oShopItemUltra_Beartrap, i).Uses;
        }
        var InitialBeartrapTanks = BeartrapTanks;
        if (global.Tokens < 0)
        {
            global.UnlockedAnimatronics[UnknownEnum.Value_119] = true;
            jumpscare(UnknownEnum.Value_119, 0);
            Block6AMTransition = true;
        }
        global.EndOfNightBlocks = [];
        var END_KILLERS = end_of_night_killers();
        for (var i = 0; i < array_length(END_KILLERS); i++)
        {
            with (get_animatronic_object(END_KILLERS[i]))
            {
                if (jumpscare_at_6AM())
                {
                    BeartrapTanks--;
                    array_push(global.EndOfNightBlocks, END_KILLERS[i]);
                }
            }
        }
        if (BeartrapTanks < 0)
        {
            Block6AMTransition = true;
        }
    }
    if (BossMode == UnknownEnum.Value_3)
    {
        var SelectedBoss = 2;
        var CurHiScore = global.BossHiScores[SelectedBoss][global.Difficulty];
        var CurScore = 21 + instance_number(oShopItem_FredbearHeart);
        if (CurScore > CurHiScore || CurHiScore == 0)
        {
            global.BossHiScores[SelectedBoss][global.Difficulty] = CurScore;
        }
        global.ThisBossHiScore = CurScore;
        instance_destroy(oFredbearManager);
        end_office_processes(true);
        instance_create_depth(0, 0, 0, oFredbear_EndingScare);
        Block6AMTransition = true;
    }
    if (instance_exists(oJumpscare) && array_contains([UnknownEnum.Value_62, UnknownEnum.Value_73], global.Jumpscare))
    {
        Block6AMTransition = true;
    }
    if (!Block6AMTransition)
    {
        if (instance_exists(oJumpscare))
        {
            get_trophy(UnknownEnum.Value_12);
            if (global.Night == "Endless" && global.EndlessRound == 10)
            {
                unlock_guard(UnknownEnum.Value_11);
            }
        }
        win_night();
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
    Value_6,
    Value_7,
    Value_8,
    Value_9,
    Value_10,
    Value_11,
    Value_12,
    Value_15 = 15,
    Value_16,
    Value_17,
    Value_18,
    Value_19,
    Value_21 = 21,
    Value_62 = 62,
    Value_73 = 73,
    Value_119 = 119,
    Value_121 = 121
}
