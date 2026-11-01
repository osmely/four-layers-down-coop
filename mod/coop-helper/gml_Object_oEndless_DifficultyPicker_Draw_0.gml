if (DailyChallengeGuard != -1)
{
    SelectedGuard = DailyChallengeGuard;
}
draw_set_font(global.FontW97White);
var WindowWidth = 316;
var WindowHeight = 356;
var WindowX = 322;
var WindowY = 2 + Offset;
var sprite = sUIBox_Black;
Offset += (((Confirmed * 360) - Offset) / 5);
if (SelectedGuard != -1)
{
    draw_outline(16777215, BigFaceSprites, SelectedGuard * 2, FaceOffset - (Offset * (4/3)), 0);
    draw_sprite(BigFaceSprites, SelectedGuard * 2, FaceOffset - (Offset * (4/3)), 0);
    FaceOffset += ((0 - FaceOffset) / 4);
}
else
{
    FaceOffset = -480;
}
if (LastFace != -1)
{
    draw_outline(16777215, BigFaceSprites, LastFace * 2, -480 - FaceOffset, 0);
    draw_sprite(BigFaceSprites, LastFace * 2, -480 - FaceOffset, 0);
}
draw_sprite_stretched(sprite, 0, WindowX, WindowY, WindowWidth, WindowHeight);
var ButtonX = WindowX + 4;
var ButtonY = WindowY + 4;
var ButtonWidth = 22;
var ButtonHeight = 22;
if ((clicked(ButtonX, ButtonY, ButtonWidth, ButtonHeight) || input_check_pressed(UnknownEnum.Value_1)) && !Confirmed)
{
    audio_play_sound(sfxBump, 10, false);
    Confirmed = true;
    with (oEndless_ModePicker)
    {
        Active = true;
    }
}
draw_sprite_stretched(sprite, 0, ButtonX, ButtonY, ButtonWidth, ButtonHeight);
draw_sprite(sButtonMini_Icons_White, 0, ButtonX + 11, ButtonY + 11);
draw_set_halign(fa_left);
draw_sprite_stretched(sprite, 0, ButtonX + ButtonWidth + 2, ButtonY, WindowWidth - 32, ButtonHeight);
var HelperReady = !global.ModHelperMode || (HelperGuard != -1 && HelperGuard != SelectedGuard);
draw_text(WindowX + 33, WindowY + 5, (SelectedGuard == -1) ? "Select a guard." : ((global.Difficulty == -1) ? "Select a difficulty." : (HelperReady ? "Click \"Confirm\" to begin." : "Helper: pick a guard with the arrows.")));
var GuardUnlocked = false;
var HoveredGuard = SelectedGuard;
if (global.ModHelperMode && DailyChallengeGuard == -1 && !Confirmed)
{
    var HelperMove = (keyboard_check_pressed(vk_right) - keyboard_check_pressed(vk_left)) + ((keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up)) * 6);
    if (HelperMove != 0)
    {
        HelperCursor = clamp(HelperCursor + HelperMove, 0, global.GuardAmount - 1);
        var HelperID = GuardOrd[HelperCursor];
        var HelperUnlocked = (HelperID >= 21) ? true : global.UnlockedGuards[HelperID];
        HelperGuard = -1;
        if (HelperUnlocked && HelperID != SelectedGuard)
        {
            HelperGuard = HelperID;
        }
        HelperFocus = 120;
        audio_play_sound(sfxTick, 1, false);
        var HelperRowY = floor(HelperCursor / 6) * 48;
        BarOffset = clamp(BarOffset, (HelperRowY + 48) - 96, HelperRowY);
    }
    if (HelperFocus > 0)
    {
        HelperFocus--;
        HoveredGuard = GuardOrd[HelperCursor];
    }
}
if (DailyChallengeGuard == -1)
{
    ButtonX = WindowX + 4;
    ButtonY = WindowY + 28;
    ButtonWidth = WindowWidth - 8;
    ButtonHeight = 100;
    draw_sprite_stretched(sprite, 4, ButtonX, ButtonY, ButtonWidth, ButtonHeight);
    if (!surface_exists(GuardSurf))
    {
        GuardSurf = surface_create(ButtonWidth - 20, ButtonHeight - 4);
    }
    surface_set_target(GuardSurf);
    var WithinSelectionBox = mouse_in_zone(ButtonX + 2, ButtonY + 2, surface_get_width(GuardSurf), surface_get_height(GuardSurf));
    draw_clear_alpha(c_white, 0);
    for (var i = 0; i < global.GuardAmount; i++)
    {
        var ID = GuardOrd[i];
        GuardUnlocked = (ID >= 21) ? true : global.UnlockedGuards[ID];
        var BoxX = (i % 6) * 48;
        var BoxY = (floor(i / 6) * 48) - BarOffset;
        draw_sprite_stretched(sprite, (ID == SelectedGuard) ? 3 : 2, BoxX, BoxY, 48, 48);
        if (!GuardUnlocked)
        {
            shader_set(shFlash);
            draw_sprite_ext(FaceSprites, ID, BoxX, BoxY, 1, 1, 0, c_black, 1);
            shader_reset();
        }
        else
        {
            draw_sprite(FaceSprites, ID, BoxX, BoxY);
        }
        if (global.ModHelperMode && i == HelperCursor)
        {
            var HelperColor = (HelperGuard != -1 && HelperGuard != SelectedGuard) ? c_yellow : c_gray;
            draw_rectangle_color(BoxX + 1, BoxY + 1, BoxX + 46, BoxY + 46, HelperColor, HelperColor, HelperColor, HelperColor, true);
            draw_text_color(BoxX + 3, BoxY + 1, "2P", HelperColor, HelperColor, HelperColor, HelperColor, 1);
        }
        if (global.ModHelperMode && ID == SelectedGuard)
        {
            draw_text(BoxX + 26, BoxY + 31, "1P");
        }
        if (mouse_in_zone(BoxX + ButtonX + 2, BoxY + ButtonY + 2, 48, 48) && WithinSelectionBox)
        {
            HoveredGuard = ID;
        }
        if (clicked(BoxX + ButtonX + 2, BoxY + ButtonY + 2, 48, 48) && GuardUnlocked && WithinSelectionBox && !Confirmed && !(SelectedGuard == ID) && !(global.ModHelperMode && HelperGuard == ID))
        {
            LastFace = SelectedGuard;
            SelectedGuard = ID;
            audio_play_sound(sfxBump, 5, false);
            FaceOffset = -480;
            DescBarOffset = 0;
            DescBarDragged = false;
            set_guard_parameters(SelectedGuard);
        }
    }
    surface_reset_target();
    draw_surface(GuardSurf, ButtonX + 2, ButtonY + 2);
    var ScrollBar = scroll_bar(BarOffset, BarDragged, ButtonX + 2, ButtonY + 2, surface_get_width(GuardSurf), surface_get_height(GuardSurf), ceil(global.GuardAmount / 6) * 48, 24, 0, 0, true);
    BarOffset = ScrollBar[0];
    BarDragged = ScrollBar[1];
}
ButtonX = WindowX + 4;
ButtonY = WindowY + 130;
ButtonWidth = WindowWidth - 8;
ButtonHeight = 22;
draw_sprite_stretched(sprite, 0, ButtonX, ButtonY, ButtonWidth, ButtonHeight);
if (HoveredGuard > -1)
{
    GuardUnlocked = (HoveredGuard >= 21) ? true : global.UnlockedGuards[HoveredGuard];
    draw_text(ButtonX + 6 + 17, ButtonY + 1, GuardUnlocked ? guard_nickname(HoveredGuard) : "???");
    if (global.EndlessGuardStickers[functional_guard_id(HoveredGuard)] == -1)
    {
        draw_sprite(sEndlessStickers_Gray, 0, ButtonX + 6 + 5, ButtonY + 11);
    }
    else
    {
        draw_sprite(sEndlessStickers, global.EndlessGuardStickers[functional_guard_id(HoveredGuard)], ButtonX + 6 + 5, ButtonY + 11);
    }
}
ButtonY = WindowY + 154;
ButtonHeight = 62;
draw_sprite_stretched(sprite, 0, ButtonX, ButtonY, ButtonWidth, ButtonHeight);
if (!surface_exists(DescSurf))
{
    DescSurf = surface_create(ButtonWidth - 4, ButtonHeight - 4);
}
surface_set_target(DescSurf);
draw_clear_alpha(c_black, 0);
if (HoveredGuard != SelectedGuard)
{
    DescBarOffset = 0;
}
var ScrollBarNeeded, TextHeight;
if (HoveredGuard > -1)
{
    var Desc = GuardUnlocked ? get_guard_description(HoveredGuard) : get_guard_unlock_description(HoveredGuard);
    if (HoveredGuard >= 21 && HoveredGuard != SelectedGuard)
    {
        Desc = "Select to view description...";
    }
    ScrollBarNeeded = string_height_ext(Desc, 15, ButtonWidth - 10) > (ButtonHeight - 4);
    draw_text_ext(4, -1 - DescBarOffset, Desc, 15, ButtonWidth - (ScrollBarNeeded ? 26 : 10));
    TextHeight = string_height_ext(Desc, 15, ButtonWidth - (ScrollBarNeeded ? 26 : 10)) + 5;
}
surface_reset_target();
draw_surface(DescSurf, ButtonX + 2, ButtonY + 2);
if (HoveredGuard > -1 && ScrollBarNeeded)
{
    var ScrollBar = scroll_bar(DescBarOffset, DescBarDragged, ButtonX + 2, ButtonY + 2, ButtonWidth - 20, ButtonHeight - 4, TextHeight, 15, 0, 0, true);
    DescBarOffset = ScrollBar[0];
    DescBarDragged = ScrollBar[1];
}
if (SelectedGuard != -1)
{
    ButtonX = WindowX + 4;
    ButtonY = WindowY + 218;
    ButtonWidth = 114;
    ButtonHeight = 22;
    var Difficulties = ["Easy", "Normal", "Hard", "Lunatic", "Nightmare"];
    draw_set_font(global.FontW97Black);
    for (var i = 0; i < 5; i++)
    {
        draw_sprite_stretched(sprite, (global.Difficulty == i) ? 3 : 2, ButtonX, ButtonY, ButtonWidth, ButtonHeight);
        draw_sprite((global.Difficulty == i) ? sEndlessStickers : sEndlessStickers_Gray, i + (global.Difficulty != i), ButtonX + 6 + 5, ButtonY + 11);
        draw_text(ButtonX + 6 + 17, ButtonY + 1, Difficulties[i]);
        if (clicked(ButtonX, ButtonY, ButtonWidth, ButtonHeight) && !Confirmed)
        {
            StickerPercent = 0;
            global.Difficulty = i;
            audio_play_sound(sfxBump, 5, false);
            for (var s = 0; s <= 86; s++)
            {
                if (global.EndlessStickers[s] >= global.Difficulty)
                {
                    StickerPercent++;
                }
            }
        }
        ButtonY += 22;
    }
    draw_set_font(global.FontW97White);
    ButtonX = WindowX + 6 + ButtonWidth;
    ButtonY = WindowY + 218;
    ButtonWidth = 192;
    ButtonHeight = 110;
    draw_sprite_stretched(sprite, 0, ButtonX, ButtonY, ButtonWidth, ButtonHeight);
    if (global.Difficulty != -1)
    {
        StarterPicks = floor(lerp(3, 5, global.Difficulty / 4)) + global.GuardParameters.starting_quota_increase;
        PerRoundPicks = lerp(1, 3, (global.Difficulty - (global.AbilityIndex[SelectedGuard] == UnknownEnum.Value_10)) / 4) + global.GuardParameters.nightly_quota_increase;
        draw_text(ButtonX + 6, ButtonY + 1, "Starter Animatronics:");
        draw_set_halign(fa_right);
        draw_text((ButtonX + ButtonWidth) - 6, ButtonY + 1, string_format(StarterPicks, 1, 1));
        draw_set_halign(fa_left);
        ButtonY += 15;
        draw_text(ButtonX + 6, ButtonY + 1, "Animatronics Per Round:");
        draw_set_halign(fa_right);
        draw_text((ButtonX + ButtonWidth) - 6, ButtonY + 1, string_format(PerRoundPicks, 1, 1));
        draw_set_halign(fa_left);
        ButtonY += 15;
        draw_text(ButtonX + 6, ButtonY + 1, "Animatronics by Round 10:");
        draw_set_halign(fa_right);
        draw_text((ButtonX + ButtonWidth) - 6, ButtonY + 1, string_format(StarterPicks + ceil(PerRoundPicks * 9), 1, 1));
        draw_set_halign(fa_left);
        ButtonY += 30;
        draw_text_ext(ButtonX + 6, ButtonY + 1, (global.Difficulty >= 4) ? "How long can you survive?" : "Survive 10 rounds to win!", 15, ButtonWidth - 12);
        ButtonY = (WindowY + WindowHeight) - 50;
        draw_sprite(sEndlessStickers, global.Difficulty, ButtonX + 6 + 5, ButtonY + 11);
        draw_text(ButtonX + 6 + 17, ButtonY + 1, $"{StickerPercent}/{87}");
        ButtonX = WindowX + 202;
        ButtonY = WindowY + 330;
        ButtonWidth = 110;
        ButtonHeight = 22;
        draw_sprite_stretched(sprite, 2, ButtonX, ButtonY, ButtonWidth, ButtonHeight);
        draw_set_font(global.FontW97Black);
        draw_text(ButtonX + 6, ButtonY + 1, "Confirm");
        draw_set_font(global.FontW97White);
        if (clicked(ButtonX, ButtonY, ButtonWidth, ButtonHeight) && !Confirmed && HelperReady)
        {
            Confirmed = true;
            global.Guard = SelectedGuard;
            var GuardID = min(global.Guard, 21);
            if (GuardID >= array_length(global.RunsAttempted))
            {
                for (var g = 21; g < 22; g++)
                {
                    for (var d = 0; d < 5; d++)
                    {
                        global.RunsAttempted[g][d] = 0;
                        global.RunsWon[g][d] = 0;
                    }
                }
            }
            global.RunsAttempted[GuardID][global.Difficulty] = global.RunsAttempted[GuardID][global.Difficulty] + 1;
            global.Lives = array_create(global.NuzlockeMode ? 1 : 3, global.Guard);
            global.ModCoopGuards = [];
            if (global.ModHelperMode)
            {
                global.Lives = [HelperGuard, global.Guard, global.Guard];
                global.ModCoopGuards = [global.Guard, HelperGuard];
            }
            global.RunTime = 0;
            set_guard_parameters(global.Guard);
            var Params = global.GuardParameters;
            global.AllTimeSalvages = [];
            global.EndlessInventory.Cartridges = [];
            for (var i = 0; i < array_length(Params.animatronics); i++)
            {
                var ID = Params.animatronics[i];
                if (ID <= 86 && ID >= 0)
                {
                    array_push(global.AllTimeSalvages, ID);
                }
            }
            for (var i = 0; i < array_length(Params.upgrades); i++)
            {
                var ID = Params.upgrades[i];
                if (ID < UnknownEnum.Value_66 && ID >= 0)
                {
                    acquire_upgrade(ID);
                }
            }
            for (var i = 0; i < array_length(Params.minigames); i++)
            {
                var ID = Params.minigames[i];
                if (ID < 16 && ID >= 0)
                {
                    acquire_cartridge(ID);
                }
            }
            for (var i = 0; i < array_length(Params.consumables); i++)
            {
                var ID = Params.consumables[i];
                if (ID < UnknownEnum.Value_12 && ID >= 0)
                {
                    acquire_consumable(ID);
                }
            }
            global.RunEarnings += Params.extra_money;
            VoiceLineID = get_guard_line(SelectedGuard, "Selection");
            VoiceLine = reverb_sound(VoiceLineID, 0, 0, false, 1.5, 0.5, 0.25);
            with (instance_create_depth(0, 0, -5, oSubtitleDrawer))
            {
                set_voiceline(other.VoiceLine, other.VoiceLineID);
            }
            alarm[0] = (1 + audio_sound_length(VoiceLine)) * 60;
            audio_stop_sound(mus_EndlessSelectNEW);
            audio_play_sound(sfxMeleeConfirm, 10, false);
            with (oBlackBars)
            {
                BlackOut = true;
            }
            global.StartRoom = EndlessShopSelection;
            global.RunEarnings += ((guard_ability(UnknownEnum.Value_12) ? 250 : 30) + (20 * global.NuzlockeMode));
        }
    }
}

enum UnknownEnum
{
    Value_1 = 1,
    Value_10 = 10,
    Value_12 = 12,
    Value_66 = 66
}
