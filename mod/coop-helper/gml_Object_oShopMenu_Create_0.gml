SelectedOption = 0;
ShopInventory = oInteraction_Shop.ShopInventory;
OptionPositions = array_create(array_length(ShopInventory), 0);
OptionYOffset = 0;
WaitForConfirm = false;
ConfirmOption = false;
ConfirmHandY = 0;
ConfirmBoxOffset = 0;
TempMessage = "You can't afford this!";
TempTimer = 0;
FadeIn = 1;
with (oTextBox)
{
    ExternalPause = true;
}

function draw_everything()
{
    var ItemIcon = oInteraction_Shop.ItemIcons;
    var DescBoxY = 232;
    draw_set_font(global.FontHanddrawn);
    var TextColor = 3354368;
    var AltColor = 13695200;
    if (input_check_pressed(UnknownEnum.Value_4) || input_check_pressed(UnknownEnum.Value_2))
    {
        audio_play_sound(sfxBump, 5, false);
        if (PurchaseMessage != "")
        {
            PurchaseTimer = 0.016666666666666666;
        }
    }
    if (WaitForConfirm)
    {
        if (input_check_pressed(UnknownEnum.Value_4) || input_check_pressed(UnknownEnum.Value_2))
        {
            ConfirmOption = !ConfirmOption;
        }
        ConfirmBoxOffset += ((0 - ConfirmBoxOffset) / 5);
    }
    else
    {
        SelectedOption += (input_check_pressed(UnknownEnum.Value_4) - input_check_pressed(UnknownEnum.Value_2));
        ConfirmBoxOffset += ((180 - ConfirmBoxOffset) / 5);
    }
    if (SelectedOption >= array_length(ShopInventory))
    {
        SelectedOption = 0;
    }
    if (SelectedOption < 0)
    {
        SelectedOption = array_length(ShopInventory) - 1;
    }
    draw_sprite_ext(sTextBox, 1, -64 - (480 * FadeIn), -32, 7, 6, 0, c_white, 1);
    OptionYOffset += (((32 * (SelectedOption - 3)) - OptionYOffset) / 5);
    var ItemPrice = ShopInventory[SelectedOption].Price;
    if (input_check_pressed(UnknownEnum.Value_0) && FadeIn <= 0.5)
    {
        audio_play_sound(sfxCamSwitch, 5, false);
        if (WaitForConfirm)
        {
            if (!ConfirmOption)
            {
                var DeleteAfterPurchase = true;
                global.RunEarnings -= ItemPrice;
                if (ShopInventory[SelectedOption].Name == "Reroll")
                {
                    var ExclusionList = [];
                    for (var i = 0; i < array_length(ShopInventory); i++)
                    {
                        if (ShopInventory[i].Name == "Reroll")
                        {
                            break;
                        }
                        array_push(ExclusionList, ShopInventory[i].ID);
                    }
                    with (oInteraction_Shop)
                    {
                        generate_inventory(ExclusionList);
                    }
                    ShopInventory = oInteraction_Shop.ShopInventory;
                }
                else
                {
                    var CurrentItem = ShopInventory[SelectedOption];
                    var CurrentItemID = CurrentItem.ID;
                    if (global.Shop == UnknownEnum.Value_0 && CurrentItemID == UnknownEnum.Value_60)
                    {
                        PurchaseMessage = "...";
                        PurchaseTimer = 2;
                        global.EndlessInventory.BossCall = true;
                    }
                    else
                    {
                        with (oShopkeepSprite)
                        {
                            purchase_made();
                            purchase_voiceclip();
                        }
                    }
                    var TextboxDepth = oTextBox.depth;
                    switch (global.Shop)
                    {
                        case UnknownEnum.Value_0:
                            acquire_upgrade(CurrentItemID);
                            break;
                        case UnknownEnum.Value_1:
                            acquire_cartridge(CurrentItemID);
                            break;
                        case UnknownEnum.Value_2:
                            acquire_consumable(CurrentItemID);
                            break;
                        case UnknownEnum.Value_4:
                            coop_heal(CurrentItemID);
                            instance_destroy(oTextBox);
                            with (instance_create_depth(0, 0, TextboxDepth, oTextBox))
                            {
                                game_text("Shop_Conclusion");
                                CurrentTextboxY = 232;
                            }
                            instance_destroy();
                            break;
                        case UnknownEnum.Value_3:
                            global.Jumpscare = CurrentItemID;
                            instance_destroy(oTextBox);
                            with (instance_create_depth(0, 0, TextboxDepth, oTextBox))
                            {
                                game_text("Shop_Conclusion");
                                CurrentTextboxY = 232;
                            }
                            instance_destroy();
                            break;
                        case UnknownEnum.Value_5:
                            global.Jumpscare = global.AllTimeSalvages[CurrentItemID];
                            array_delete(global.AllTimeSalvages, CurrentItemID, 1);
                            array_push(global.EndlessInventory.WhackedChars, global.Jumpscare);
                            instance_destroy(oTextBox);
                            with (instance_create_depth(0, 0, TextboxDepth, oTextBox))
                            {
                                game_text("Shop_Conclusion");
                                CurrentTextboxY = 232;
                            }
                            instance_destroy();
                            break;
                        case UnknownEnum.Value_7:
                            global.Jumpscare = 
                            {
                                ID: CurrentItemID,
                                HardMode: SelectedOption
                            };
                            show_debug_message(global.Jumpscare);
                            DeleteAfterPurchase = false;
                            instance_destroy(oTextBox);
                            with (instance_create_depth(0, 0, TextboxDepth, oTextBox))
                            {
                                game_text("Shop_Conclusion");
                                CurrentTextboxY = 232;
                            }
                            instance_destroy();
                            break;
                        case UnknownEnum.Value_8:
                            apply_eleanor_challenge(CurrentItemID, CurrentItem.Value, CurrentItem.Reward, (string_pos("+", CurrentItem.Name) == 0) ? 1 : 3);
                            instance_destroy(oTextBox);
                            with (instance_create_depth(0, 0, TextboxDepth, oTextBox))
                            {
                                game_text("Shop_Conclusion");
                                CurrentTextboxY = 232;
                            }
                            instance_destroy();
                            break;
                        case UnknownEnum.Value_6:
                            global.EndlessInventory.BobbiedotRegimen = CurrentItemID;
                            instance_destroy(oTextBox);
                            with (instance_create_depth(0, 0, TextboxDepth, oTextBox))
                            {
                                game_text("Shop_Conclusion");
                                CurrentTextboxY = 232;
                            }
                            instance_destroy();
                            break;
                        case UnknownEnum.Value_9:
                            global.EndlessInventory.RoundDebt = CurrentItemID;
                            global.EndlessRound += CurrentItemID;
                            instance_destroy(oTextBox);
                            with (instance_create_depth(0, 0, TextboxDepth, oTextBox))
                            {
                                game_text("Shop_Conclusion");
                                CurrentTextboxY = 232;
                            }
                            instance_destroy();
                            break;
                        case UnknownEnum.Value_12:
                            switch (CurrentItem.Reward)
                            {
                                case UnknownEnum.Value_0:
                                    acquire_upgrade(CurrentItemID);
                                    break;
                                case UnknownEnum.Value_1:
                                    acquire_cartridge(CurrentItemID);
                                    break;
                                case UnknownEnum.Value_2:
                                    acquire_consumable(CurrentItemID);
                                    break;
                            }
                            array_push(global.RepeatPrevention.Upgrades, 
                            {
                                ID: CurrentItem.UpgradeLost,
                                Duration: 3
                            });
                            for (var u = 0; u < array_length(global.Upgrades); u++)
                            {
                                if (global.Upgrades[u] == CurrentItem.UpgradeLost)
                                {
                                    array_delete(global.Upgrades, u, 1);
                                    break;
                                }
                            }
                            instance_destroy(oTextBox);
                            with (instance_create_depth(0, 0, TextboxDepth, oTextBox))
                            {
                                game_text("Shop_Conclusion");
                                CurrentTextboxY = 232;
                            }
                            instance_destroy();
                            break;
                    }
                    if (DeleteAfterPurchase)
                    {
                        array_delete(ShopInventory, SelectedOption, 1);
                    }
                    if (CurrentItemID == UnknownEnum.Value_31)
                    {
                        with (oInteraction_Shop)
                        {
                            generate_inventory([]);
                        }
                        ShopInventory = oInteraction_Shop.ShopInventory;
                    }
                    if (CurrentItemID == UnknownEnum.Value_30 && oInteraction_Shop.Rerolls == 0)
                    {
                        oInteraction_Shop.RerollPrice = 0;
                        ShopInventory[array_length(ShopInventory) - 2].Price = 0;
                    }
                }
                SelectedOption = 0;
                audio_play_sound(sfxRegister, 10, false);
                var Text = "";
                for (var i = 0; i < array_length(global.Upgrades); i++)
                {
                    Text += (get_upgrades(global.Upgrades[i]).Name + ", ");
                }
            }
            WaitForConfirm = false;
        }
        else if (global.RunEarnings < ItemPrice && !(SelectedOption == (array_length(ShopInventory) - 1)) && ItemPrice > 0)
        {
            audio_play_sound(sfxError, 5, false);
        }
        else
        {
            if (SelectedOption == (array_length(ShopInventory) - 1))
            {
                with (oTextBox)
                {
                    ExternalPause = false;
                    CurrentTextboxY = 232;
                }
                instance_destroy();
            }
            WaitForConfirm = true;
            ConfirmOption = false;
            ConfirmHandY = 0;
        }
    }
    var RerollPlacement = max(array_length(ShopInventory) - 2, 0);
    OptionPositions[array_length(ShopInventory) - 1] = 8;
    if (ShopInventory[RerollPlacement].Name == "Reroll")
    {
        OptionPositions[RerollPlacement] = 8;
    }
    for (var o = 0; o < array_length(ShopInventory); o++)
    {
        var OptionY = (12 + (32 * o)) - OptionYOffset;
        if (SelectedOption != o)
        {
            AltColor = 5662772;
        }
        else
        {
            AltColor = 13695200;
        }
        var ItemName = ShopInventory[o].Name;
        if (ItemName == "Dead Ringer" && irandom(60) == 0)
        {
            ItemName = choose("OBEY PHONY", "DO NOT BUY", "DE D RING R", "*!#$ &?$@", "LET US OUT");
        }
        draw_set_halign(fa_left);
        draw_text_color(OptionPositions[o] - (480 * FadeIn), OptionY, ItemName, AltColor, AltColor, AltColor, AltColor, 1);
        var HasIcon = ItemIcon != sNOTHING;
        if (o < (array_length(ShopInventory) - 1))
        {
            draw_set_halign(fa_right);
            if (global.Shop == UnknownEnum.Value_8)
            {
                switch (ShopInventory[o].Reward)
                {
                    case UnknownEnum.Value_0:
                        draw_sprite(sShopItemSalvageIcons, ShopInventory[o].Value, 352 - (480 * FadeIn), OptionY + 16);
                        break;
                    case UnknownEnum.Value_1:
                        draw_sprite(sMinigameCarts, ShopInventory[o].Value, 352 - (480 * FadeIn), OptionY + 16);
                        break;
                    case UnknownEnum.Value_2:
                        draw_sprite(sShop_ConsumableIcons, ShopInventory[o].Value, 352 - (480 * FadeIn), OptionY + 16);
                        break;
                    case UnknownEnum.Value_3:
                        draw_text_color(368 - (480 * FadeIn), OptionY, "+$" + string_format(ShopInventory[o].Value, 1, 2), AltColor, AltColor, AltColor, AltColor, 1);
                        break;
                }
            }
            else if (global.Shop == UnknownEnum.Value_12)
            {
                draw_sprite(sShopItemSalvageIcons, ShopInventory[o].UpgradeLost, 352 - (480 * FadeIn), OptionY + 16);
                draw_text_color(368 - (480 * FadeIn), OptionY, "-   ", AltColor, AltColor, AltColor, AltColor, 1);
                switch (ShopInventory[o].Reward)
                {
                    case UnknownEnum.Value_0:
                        ItemIcon = sShopItemSalvageIcons;
                        break;
                    case UnknownEnum.Value_1:
                        ItemIcon = sMinigameCarts;
                        break;
                    case UnknownEnum.Value_2:
                        ItemIcon = sShop_ConsumableIcons;
                        break;
                }
            }
            else
            {
                draw_text_color(368 - (480 * FadeIn), OptionY, "$" + string_format(ShopInventory[o].Price, 1, 2), AltColor, AltColor, AltColor, AltColor, 1);
            }
            if (!array_contains(["Reroll", "Reset", "Back"], ShopInventory[o].Name) && ItemIcon != sNOTHING)
            {
                if (global.Shop == UnknownEnum.Value_0 && array_contains([UnknownEnum.Value_27, UnknownEnum.Value_29, UnknownEnum.Value_28], ShopInventory[o].ID))
                {
                    var minigameID = -1;
                    switch (ShopInventory[o].ID)
                    {
                        case UnknownEnum.Value_27:
                            minigameID = UnknownEnum.Value_8;
                            break;
                        case UnknownEnum.Value_29:
                            minigameID = UnknownEnum.Value_10;
                            break;
                        case UnknownEnum.Value_28:
                            minigameID = UnknownEnum.Value_9;
                            break;
                    }
                    draw_sprite(sMinigameCarts, global.ShuffleData.Minigames[minigameID], OptionPositions[0] - 20 - (480 * FadeIn), OptionY + 16);
                }
                else
                {
                    draw_sprite(ItemIcon, ShopInventory[o].ID, OptionPositions[0] - 20 - (480 * FadeIn), OptionY + 16);
                }
            }
            else
            {
                HasIcon = false;
            }
        }
        if (o == (array_length(ShopInventory) - 1))
        {
            OptionPositions[o] += (8 - OptionPositions[o]) / 5;
        }
        else
        {
            OptionPositions[o] += ((HasIcon ? 40 : 8) - OptionPositions[o]) / 5;
        }
    }
    var DescText = (PurchaseMessage != "") ? PurchaseMessage : ShopInventory[SelectedOption].Desc;
    if (WaitForConfirm)
    {
        if (ShopInventory[SelectedOption].Name == "Reroll")
        {
            DescText = "Reroll the shop's selection for $" + string_format(ItemPrice, 1, 2) + "?";
        }
        else if (ShopInventory[SelectedOption].Name == "Back")
        {
            DescText = "";
        }
        else
        {
            switch (global.Shop)
            {
                case UnknownEnum.Value_8:
                    DescText = "Take on this challenge?";
                    break;
                case UnknownEnum.Value_7:
                    DescText = "Take on this challenge for $" + string_format(ItemPrice, 1, 2) + "?";
                    break;
                case UnknownEnum.Value_12:
                    DescText = $"Trade {get_upgrades(ShopInventory[SelectedOption].UpgradeLost).Name} for {get_reward(ShopInventory[SelectedOption].ID, ShopInventory[SelectedOption].Reward).Name}?";
                    break;
                default:
                    DescText = "Buy this item for $" + string_format(ItemPrice, 1, 2) + "?";
                    break;
            }
        }
    }
    AltColor = 13695200;
    draw_rectangle_color(-1, DescBoxY - 1, 640, DescBoxY + 128, AltColor, AltColor, AltColor, AltColor, false);
    var ConfirmBoxX = 448;
    var ConfirmBoxY = 68 + ConfirmBoxOffset + (360 * FadeIn);
    draw_sprite_ext(sTextBox, 0, ConfirmBoxX, ConfirmBoxY, 2, 1.5, 0, c_white, 1);
    draw_text_color(ConfirmBoxX + 48, ConfirmBoxY + 16, "Yes", TextColor, TextColor, TextColor, TextColor, 1);
    draw_text_color(ConfirmBoxX + 48, ConfirmBoxY + 48, "No", TextColor, TextColor, TextColor, TextColor, 1);
    ConfirmHandY += (((32 * ConfirmOption) - ConfirmHandY) / 2);
    draw_sprite(sSelectionHand, 0, ConfirmBoxX + 28, ConfirmBoxY + 32 + ConfirmHandY);
    draw_set_halign(fa_left);
    draw_sprite_ext(sTextBox, 0, 0, DescBoxY, 10, 2, 0, c_white, 1);
    if (global.Shop == UnknownEnum.Value_7 && SelectedOption < 3)
    {
        draw_set_font(global.FontW97White);
        DescText = get_minigame_data(ShopInventory[SelectedOption].ID).Desc;
        var CarnieData = get_carnie_scores(ShopInventory[SelectedOption].ID);
        DescText += ("\n\n" + ((CarnieData.NormalScore[SelectedOption] == infinity) ? $"Beat the minigame in {CarnieData.NormalTimer[SelectedOption]} seconds to win!" : ((CarnieData.NormalTimer[SelectedOption] == infinity) ? $"Get {CarnieData.NormalScore[SelectedOption]} points to win!" : $"Get {CarnieData.NormalScore[SelectedOption]} points in {CarnieData.NormalTimer[SelectedOption]} seconds to win!")));
        draw_text_ext_color(16, DescBoxY + 11, DescText, 15, 362.6666666666667, TextColor, TextColor, TextColor, TextColor, 1);
        draw_set_font(global.FontHanddrawn);
        DescText = "REWARDS:  ";
        if (SelectedOption >= 1)
        {
            DescText += ("$" + string_format(20, 1, 2));
        }
        draw_sprite(global.GuardParameters.randomize_minigames ? sMinigameCarts_Mystery : sMinigameCarts, ShopInventory[SelectedOption].ID, 608, DescBoxY + 32 + 64);
        if (SelectedOption == 2)
        {
            if (global.CarnieItemReward == -1)
            {
                DescText = "REWARDS:  $" + string_format(48, 1, 2);
            }
            else
            {
                draw_sprite(sShop_ConsumableIcons, global.CarnieItemReward, 576, DescBoxY + 32 + 64);
            }
        }
        draw_text_ext_color(320, DescBoxY + 84, DescText, 16, 362.6666666666667, TextColor, TextColor, TextColor, TextColor, 1);
    }
    else
    {
        draw_text_ext_color(16, DescBoxY + 16, DescText, 32, 544, TextColor, TextColor, TextColor, TextColor, 1);
    }
    FadeIn -= (FadeIn / 10);
    if (PurchaseTimer > 0)
    {
        PurchaseTimer -= 0.016666666666666666;
        if (PurchaseTimer <= 0)
        {
            PurchaseMessage = "";
            with (oShopkeepSprite)
            {
                switch_pose(1);
            }
        }
    }
}

DisplayedEarnings = global.RunEarnings;
PurchaseMessage = "";
PurchaseTimer = 0;
with (oShopkeepSprite)
{
    switch_pose(1);
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
    Value_12 = 12,
    Value_27 = 27,
    Value_28,
    Value_29,
    Value_30,
    Value_31,
    Value_60 = 60
}
