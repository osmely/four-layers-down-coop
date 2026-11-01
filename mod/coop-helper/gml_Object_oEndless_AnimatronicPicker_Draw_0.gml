draw_set_font(global.FontW97White);
var sprite = sUIBox_Black;
var tileOffset = current_frame();
draw_set_alpha(TileSize);
draw_tower(min((global.EndlessRound - 1) / 10, 10), current_frame());
draw_set_alpha(lerp(0.8, 1, BGFade));
draw_sprite_tiled(sControlPanel_GridTiles_RED, 0, tileOffset, tileOffset);
draw_set_alpha(1);
BGFade = max(BGFade - 0.016666666666666666, 0);
if (Selected)
{
    TransitionTime++;
    if (TransitionTime >= 30)
    {
        for (var i = 0; i < array_length(SelectedAnimatronics); i++)
        {
            if (SelectedAnimatronics[i])
            {
                array_push(global.AllTimeSalvages, Choices[i].ID);
                earn_money(round(Choices[i].Price * PriceScaler));
                global.SalvageRecord[Choices[i].ID]++;
            }
        }
        calculate_repeat_prevention();
        global.EndlessInventory.RoundDebt = 0;
        while (global.Lives[array_length(global.Lives) - 1] != global.Guard)
        {
            array_push(global.Lives, array_shift(global.Lives));
        }
        global.AILevels = array_create(UnknownEnum.Value_201, 0);
        save_endless_data(Office);
        room_goto(Office);
    }
}
var OptionAmount = array_length(Choices);
var LoopWidth = 48;
if (array_length(global.AllTimeSalvages) > 0)
{
    LoopWidth = array_length(global.AllTimeSalvages) * 48;
    for (var loop = 0; loop <= ceil(640 / LoopWidth); loop++)
    {
        for (var t = 0; t < array_length(global.AllTimeSalvages); t++)
        {
            draw_sprite(global.IconTiles[global.AllTimeSalvages[t]], 0, ((t * 48) + (loop * LoopWidth)) - AnimationFrame, (1 - TileSize) * -48);
            draw_sprite(global.IconTiles[global.AllTimeSalvages[t]], 0, (t * 48) + ((loop - 1) * LoopWidth) + AnimationFrame, 360 + (TileSize * -48));
        }
    }
}
AnimationFrame = (AnimationFrame + 1) % LoopWidth;
var InnerWindowWidth = (48 * max(8, OptionAmount / RowCount)) + 4;
var InnerWindowHeight = (48 * (RowCount + 2)) + 4;
var WindowWidth = InnerWindowWidth + 8;
var WindowHeight = InnerWindowHeight + 56;
var WindowX = (640 - WindowWidth) / 2;
var WindowY = (360 - WindowHeight) / 2;
WindowY -= ((1 - TileSize) * 360);
WindowY += WindowOffset;
draw_sprite_stretched(sprite, 0, WindowX, WindowY, WindowWidth, WindowHeight);
var ButtonX = WindowX + 4;
var ButtonY = WindowY + 4;
var ButtonWidth = 22;
var ButtonHeight = 22;
if (clicked(ButtonX, ButtonY, ButtonWidth, ButtonHeight) || input_check_pressed(UnknownEnum.Value_1))
{
    audio_stop_all();
    audio_play_sound(sfxBump, 10, false);
    room_goto(title_screen());
}
draw_sprite_stretched(sprite, 0, ButtonX, ButtonY, ButtonWidth, ButtonHeight);
draw_sprite(sButtonMini_Icons_White, 0, ButtonX + 11, ButtonY + 11);
draw_set_halign(fa_left);
draw_sprite_stretched(sprite, 0, ButtonX + ButtonWidth + 2, ButtonY, WindowWidth - 32, ButtonHeight);
var PicksLeft = AnimatronicQuota - count_up(SelectedAnimatronics);
draw_text(WindowX + 33, WindowY + 5, (PicksLeft <= 0) ? "Click the confirm button to begin." : $"Pick {PicksLeft} more.");
var InnerWindowY = WindowY + (ButtonHeight + 5);
InnerWindowWidth = ((48 * OptionAmount) / RowCount) + 4;
var InnerWindowX = (640 - InnerWindowWidth) / 2;
var CharSelectionWindowHeight = (48 * RowCount) + 4;
ButtonX = InnerWindowX + 2;
ButtonY = InnerWindowY + 2;
ButtonWidth = 48;
ButtonHeight = 48;
var SelectedData = undefined;
var SelectedPrice = 0;
var EntriesPerRow = ceil(OptionAmount / RowCount);
for (var a = 0; a < array_length(Choices); a++)
{
    var TileX = a % EntriesPerRow;
    var TileY = floor(a / EntriesPerRow);
    ButtonX = InnerWindowX + 2 + (TileX * 48);
    ButtonY = InnerWindowY + 2 + (TileY * 48);
    var Animatronic = Choices[a].ID;
    var Picked = SelectedAnimatronics[a];
    var CanClick = (PicksLeft > 0 || Picked) && !array_contains(UltraPickerChar, Animatronic);
    draw_sprite_stretched(sprite, Picked ? 3 : 2, ButtonX, ButtonY, ButtonWidth, ButtonHeight);
    draw_sprite_ext((Anonymize || PhonyAnonymize) ? sMysteryTile : global.IconTiles[Animatronic], !Picked, ButtonX, ButtonY, 1, 1, 0, Picked ? c_white : c_gray, 1);
    if (!Selected)
    {
        if (mouse_in_zone(ButtonX, ButtonY, ButtonWidth, ButtonHeight))
        {
            SelectedData = Animatronic;
            SelectedPrice = round(Choices[a].Price * PriceScaler);
        }
        if (clicked(ButtonX, ButtonY, ButtonWidth, ButtonHeight) && CanClick)
        {
            SelectedAnimatronics[a] = !Picked;
            audio_play_sound(sfxBump, 5, false);
        }
    }
}
InnerWindowX = WindowX + 4;
InnerWindowY += CharSelectionWindowHeight;
InnerWindowWidth = (48 * max(8, OptionAmount / RowCount)) + 4;
InnerWindowHeight = 22;
draw_sprite_stretched(sprite, 0, InnerWindowX, InnerWindowY, InnerWindowWidth, InnerWindowHeight);
if (SelectedData != undefined)
{
    var Text = (Anonymize || PhonyAnonymize) ? "???" : global.Descriptions[SelectedData][0];
    draw_text(InnerWindowX + 6 + 17, InnerWindowY + 1, Text);
    draw_set_halign(fa_right);
    draw_text((InnerWindowX + InnerWindowWidth) - 6, InnerWindowY + 1, "VALUE: $" + string_format(SelectedPrice, 1, 2));
    draw_set_halign(fa_left);
    var ShowShape = true;
    draw_sprite(sEndlessStickers_Gray, ShowShape ? (global.EndlessStickers[SelectedData] + 1) : 0, InnerWindowX + 6 + 5, InnerWindowY + 11);
}
InnerWindowY += 24;
InnerWindowHeight = ((48 * (RowCount + 2)) + 4) - (CharSelectionWindowHeight + 24);
draw_sprite_stretched(sprite, 0, InnerWindowX, InnerWindowY, InnerWindowWidth, InnerWindowHeight);
if (SelectedData != undefined)
{
    draw_text_ext(InnerWindowX + 6, InnerWindowY + 1, Anonymize ? $"Some kind of {get_animatronic_data(SelectedData).DefenseProcedure[0]} character...?" : global.Descriptions[SelectedData][1], 14, InnerWindowWidth - 8);
}
WindowX = (640 - WindowWidth) / 2;
ButtonWidth = 96;
ButtonHeight = 22;
ButtonX = WindowX + 4;
ButtonY = (WindowY + WindowHeight) - (ButtonHeight + 4);
draw_sprite_stretched(sprite, 0, ButtonX, ButtonY, ButtonWidth, ButtonHeight);
draw_text(ButtonX + 6, ButtonY + 1, "Confirm");
if ((clicked(ButtonX, ButtonY, ButtonWidth, ButtonHeight) || input_check_pressed(UnknownEnum.Value_0)) && (Active && PicksLeft <= 0 && !Selected))
{
    instance_destroy(oShopItem);
    instance_destroy(oEleanorChallengeIndicator);
    audio_stop_all();
    Selected = true;
    alarm[0] = Anonymize ? 120 : 1;
    audio_play_sound(sfxClick, 5, false);
    if (Anonymize)
    {
        TransitionTime = -180;
        audio_play_sound(sfxMeleeConfirm, 10, false);
    }
    Anonymize = false;
}
ButtonX = (WindowX + WindowWidth) - (4 + (22 * lives_left()));
ButtonWidth = 22;
if (global.EndlessInventory.BarrierBooze)
{
    shader_set(shRecolor);
    replace_color(13695200, 7389320, 5662772, 3354368, 16777215, 12632256, 8421504, 0);
    draw_sprite(sBarrierBooze, ((floor(AnimationFrame / 12) % 8) == 3) ? 1 : 0, ButtonX - 11, ButtonY + 11);
}
for (var i = 0; i < lives_left(); i++)
{
    var GuardID = global.Lives[i];
    var GuardSelected = GuardID == global.Guard;
    var GuardWalkFrame = floor(AnimationFrame / 12) % 4;
    if (GuardWalkFrame == 2)
    {
        GuardWalkFrame = 0;
    }
    if (GuardWalkFrame == 3)
    {
        GuardWalkFrame = 2;
    }
    draw_sprite_stretched(sprite, GuardSelected ? 3 : 2, ButtonX, ButtonY, ButtonWidth, ButtonHeight);
    shader_set(shRecolor);
    replace_color(13695200, 7389320, 5662772, 3354368, GuardSelected ? 16777215 : 12632256, GuardSelected ? 12632256 : 12632256, GuardSelected ? 8421504 : 12632256, GuardSelected ? 0 : 8421504);
    draw_sprite(GuardSprite, (GuardID * 4) + (GuardSelected ? GuardWalkFrame : 0), ButtonX + 11, ButtonY + 11);
    shader_reset();
    if (mouse_in_zone(ButtonX, ButtonY, ButtonWidth, ButtonHeight))
    {
        draw_mechanic_box((GuardID >= 21 && !GuardSelected) ? "Select to view description..." : get_guard_description(GuardID, true), sUIBox_Black);
    }
    if (clicked(ButtonX, ButtonY, ButtonWidth, ButtonHeight) && !GuardSelected)
    {
        var WasOMC = guard_ability(UnknownEnum.Value_20);
        var WasEdwin = guard_ability(UnknownEnum.Value_12);
        audio_play_sound(sfxBump, 5, false);
        global.Guard = GuardID;
        if (WasOMC && !guard_ability(UnknownEnum.Value_20))
        {
            global.EndlessInventory.MarkiplierPoints--;
        }
        if (!WasOMC && guard_ability(UnknownEnum.Value_20))
        {
            global.EndlessInventory.MarkiplierPoints++;
        }
        set_guard_parameters();
        pick_choices();
        edwin_money_exchange(WasEdwin);
    }
    ButtonX += 22;
}
var HelperSwitch = keyboard_check_pressed(vk_right) - keyboard_check_pressed(vk_left);
if (global.ModHelperMode && Active && !Selected && HelperSwitch != 0)
{
    var HelperGuards = [];
    var GuardIndex = 0;
    for (var i = 0; i < lives_left(); i++)
    {
        if (!array_contains(HelperGuards, global.Lives[i]))
        {
            if (global.Lives[i] == global.Guard)
            {
                GuardIndex = array_length(HelperGuards);
            }
            array_push(HelperGuards, global.Lives[i]);
        }
    }
    if (array_length(HelperGuards) > 1)
    {
        var GuardID = HelperGuards[(GuardIndex + HelperSwitch + array_length(HelperGuards)) % array_length(HelperGuards)];
        var WasOMC = guard_ability(UnknownEnum.Value_20);
        var WasEdwin = guard_ability(UnknownEnum.Value_12);
        audio_play_sound(sfxBump, 5, false);
        global.Guard = GuardID;
        if (WasOMC && !guard_ability(UnknownEnum.Value_20))
        {
            global.EndlessInventory.MarkiplierPoints--;
        }
        if (!WasOMC && guard_ability(UnknownEnum.Value_20))
        {
            global.EndlessInventory.MarkiplierPoints++;
        }
        set_guard_parameters();
        pick_choices();
        edwin_money_exchange(WasEdwin);
    }
}
var BoxWidth = 120;
var BoxOffset = lerp(-24, 0, TileSize);
draw_set_halign(fa_left);
draw_sprite_stretched(sprite, 0, 2, 2 + BoxOffset, BoxWidth, 22);
draw_text_color(8, 3 + BoxOffset, "Round " + string(global.EndlessRound), c_white, c_white, c_white, c_white, 1);
draw_sprite(sEndlessStickers, global.Difficulty, (2 + BoxWidth) - 11, 3 + BoxOffset + 10);
draw_sprite_stretched(sprite, 0, 640 - (BoxWidth + 1), 2 + BoxOffset, BoxWidth, 22);
draw_text_color((640 - (BoxWidth + 1)) + 6, 3 + BoxOffset, "Earnings: ", c_white, c_white, c_white, c_white, 1);
draw_set_halign(fa_right);
draw_text(632, 3 + BoxOffset, "$" + string_format(global.RunEarnings, 1, 2));
draw_set_halign(fa_left);
TileSize += ((Active - TileSize) / 5);
WindowOffset += WindowOffsetSpeed;
WindowOffsetSpeed = lerp(WindowOffsetSpeed, (0 - WindowOffset) * 0.2, 0.25);

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_12 = 12,
    Value_20 = 20,
    Value_201 = 201
}
