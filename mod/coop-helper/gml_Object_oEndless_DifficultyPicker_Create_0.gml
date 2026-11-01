FaceSprites = -1;
VoiceLineID = -1;
VoiceLine = -1;
if (global.EndlessRound > 1)
{
    instance_change(oEndless_AnimatronicPicker, true);
    exit;
}
global.Difficulty = -1;
StickerPercent = 0;
StarterPicks = floor(lerp(3, 5, global.Difficulty / 4));
PerRoundPicks = lerp(1, 3, global.Difficulty / 4);
Offset = -360;
Confirmed = false;
FaceSprites = import_sprites("icon.png", sCustomNightGuardFaces);
BigFaceSprites = import_sprites("selection.png", sNightGuardFacesSelection, 2);
for (var i = 21; i < global.GuardAmount; i++)
{
    global.TrueAbilityIndex[i] = get_guard_property("ability", UnknownEnum.Value_1, i);
    global.AbilityIndex[i] = global.TrueAbilityIndex[i];
}

function guard_picker(arg0, arg1, arg2)
{
    arg1 += 48;
    var RelativeMouseX = global.MouseX - arg0;
    var RelativeMouseY = global.MouseY - arg1;
    var img_index = 0;
    if (0 < RelativeMouseX && RelativeMouseX < 16 && 0 < RelativeMouseY && RelativeMouseY < 16 && mouse_check_button(mb_left))
    {
        img_index = 1;
        if (mouse_check_button_pressed(mb_left))
        {
            audio_play_sound(sfxTick, 1, false);
            global.Guard -= 1;
        }
    }
    if (16 < RelativeMouseX && RelativeMouseX < 32 && 0 < RelativeMouseY && RelativeMouseY < 16 && mouse_check_button(mb_left))
    {
        img_index = 2;
        if (mouse_check_button_pressed(mb_left))
        {
            audio_play_sound(sfxTick, 1, false);
            global.Guard += 1;
        }
    }
    var GuardNum = 21 - !global.UnlockedAnimatronics[UnknownEnum.Value_161];
    if (global.GuardAmount > 4)
    {
        GuardNum = global.GuardAmount;
    }
    global.Guard = (global.Guard + GuardNum) % GuardNum;
    draw_sprite(sCustomNightArrows, img_index, arg0, arg1);
    draw_sprite(sCustomNightCounter, global.Guard, arg0 + 32, arg1);
    draw_sprite(sTileBase, 0, arg0, arg1 - 48);
    draw_sprite(arg2, global.Guard, arg0, arg1 - 48);
}

SelectedGuard = -1;
GuardSurf = -1;
DescSurf = -1;
BarOffset = 0;
BarDragged = false;
DescBarOffset = 0;
DescBarDragged = false;
FaceOffset = -480;
LastFace = -1;
DailyChallengeGuard = -1;
HelperCursor = 0;
HelperGuard = -1;
HelperFocus = 0;
VoiceLine = -1;
GuardOrd = get_sorter_array(countup_array(UnknownEnum.Value_179, UnknownEnum.Value_159));
for (var i = 0; i < array_length(GuardOrd); i++)
{
    GuardOrd[i] -= UnknownEnum.Value_159;
}
for (var i = 21; i < global.GuardAmount; i++)
{
    array_push(GuardOrd, i);
}

enum UnknownEnum
{
    Value_1 = 1,
    Value_159 = 159,
    Value_161 = 161,
    Value_179 = 179
}
