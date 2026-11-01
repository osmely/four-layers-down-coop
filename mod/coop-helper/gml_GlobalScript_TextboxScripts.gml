function set_defaults_for_text()
{
    line_break_pos[0][TextPageNumber] = 999;
    line_break_num[TextPageNumber] = 0;
    line_break_offset[TextPageNumber] = 0;
    for (var l = 0; l < 999; l++)
    {
        TextColor[l][TextPageNumber] = 3354368;
        TextEffect[l][TextPageNumber] = undefined;
        TextFont[l][TextPageNumber] = global.FontHanddrawn;
        TextYOffset[l][TextPageNumber] = 4;
    }
    if (array_length(Function) <= TextPageNumber)
    {
        Function[TextPageNumber] = function()
        {
        };
    }
    if (array_length(Delay) <= TextPageNumber)
    {
        Delay[TextPageNumber] = 0;
    }
    if (array_length(Hide) <= TextPageNumber)
    {
        Hide[TextPageNumber] = false;
    }
    if (array_length(Skip) <= TextPageNumber)
    {
        Skip[TextPageNumber] = false;
    }
    if (array_length(Lock) <= TextPageNumber)
    {
        Lock[TextPageNumber] = false;
    }
}

function add_page(arg0, arg1)
{
    set_defaults_for_text();
    Text[TextPageNumber] = arg0;
    CharacterSpeaking[TextPageNumber] = arg1;
    TextPageNumber++;
}

function add_function(arg0)
{
    Function[TextPageNumber] = arg0;
}

function add_option(arg0, arg1)
{
    TextOption[TextOptionNumber] = arg0;
    TextOptionLink[TextOptionNumber] = arg1;
    TextOptionNumber++;
}

function text_color(arg0, arg1, arg2)
{
    for (var l = arg0; l <= arg1; l++)
    {
        TextColor[l][TextPageNumber - 1] = arg2;
    }
}

function text_effect(arg0, arg1, arg2)
{
    for (var l = arg0; l <= arg1; l++)
    {
        TextEffect[l][TextPageNumber - 1] = arg2;
    }
}

function text_font(arg0, arg1, arg2)
{
    for (var l = arg0; l <= arg1; l++)
    {
        TextFont[l][TextPageNumber - 1] = arg2;
    }
}

function replace_text(arg0, arg1)
{
    with (oInteractionPoint)
    {
        if (Text == arg0)
        {
            Text = arg1;
        }
    }
}

function salvage_options(arg0)
{
    SalvageID = arg0;
    var Shuffle = global.ShuffleData.Animatronics;
    if (array_contains([Shuffle[UnknownEnum.Value_20], Shuffle[UnknownEnum.Value_33], Shuffle[UnknownEnum.Value_34], Shuffle[UnknownEnum.Value_35]], arg0))
    {
        if (global.SalvagedScraps[0])
        {
            add_page("This animatronic seems to be in very poor condition...Though that white rabbit may be interested in it.", "");
        }
        else
        {
            add_page("This animatronic seems to be in very poor condition... Corporate probably won't accept this.", "");
        }
        add_page("You can choose to salvage it anyway and pocket the earnings for yourself, but it won't count towards your quota.", "");
        
        Function[TextPageNumber] = function()
        {
            with (instance_create_depth(320, 360, 256, oSalvageSheet))
            {
                ID = other.SalvageID;
            }
        };
        
        add_page("Salvage this animatronic regardless?", "");
        add_option("Yes", "Salvage_Yes_Special");
        add_option("No", "Salvage_No");
    }
    else
    {
        Function[TextPageNumber] = function()
        {
            with (instance_create_depth(320, 360, 256, oSalvageSheet))
            {
                ID = other.SalvageID;
            }
        };
        
        add_page("Salvage this animatronic?", "");
        add_option("Yes", "Salvage_Yes");
        add_option("No", "Salvage_No");
    }
}

function upgrade_shop(arg0 = false)
{
    if (in_salvage_location())
    {
        if (arg0)
        {
            add_page("ANYTHING ELSE?", "Upgrade Cadet");
        }
        add_option("Buy Upgrades", "Shop_Upgrades");
        if (global.HasGift)
        {
            add_option("Give Gift", "Shop_Gift");
        }
        add_option("Tell a story!", "Shop_Story");
        add_option("Info", "Shop_Explain");
        add_option("Quit", "Shop_Quit");
    }
    else
    {
        if (arg0)
        {
            switch (global.Shop)
            {
                case UnknownEnum.Value_0:
                    add_page("Anything else?", "Rockstar Freddy");
                    break;
                case UnknownEnum.Value_1:
                    add_page("I got more in the back, you know.", "Rockstar Bonnie");
                    break;
                case UnknownEnum.Value_2:
                    add_page("Anything else, hun?", "Rockstar Chica");
                    break;
                case UnknownEnum.Value_3:
                    add_page("Arr, don't be a yellowbelly!", "Rockstar Foxy");
                    break;
                case UnknownEnum.Value_4:
                    add_page("You know what's good for you!", "Dollie");
                    break;
                case UnknownEnum.Value_7:
                    add_page("C'mon, I don't got all day!", "Carnie");
                    break;
                case UnknownEnum.Value_5:
                    add_page("Quit bustin' my balloons, here!", "Browboy");
                    break;
                case UnknownEnum.Value_10:
                    add_page("Our shareholders are depending on you!", "FazEnt Representative");
                    break;
                case UnknownEnum.Value_9:
                    add_page("Snrk.", "Morse");
                    break;
                case UnknownEnum.Value_8:
                    add_page("Feeling apprehensive...?", "Eleanor");
                    break;
                case UnknownEnum.Value_11:
                    add_page("Come along, now!", "Tipsy Bird");
                    break;
                case UnknownEnum.Value_6:
                    add_page("Please, let us assist you!", "Bobbiedots");
                    break;
                case UnknownEnum.Value_12:
                    add_page("Can someone get me a dictionary or somethin'?", "El Chip");
                    break;
                default:
                    add_page("Anything else?", "");
                    break;
            }
        }
        if (global.Shop == UnknownEnum.Value_11)
        {
            add_option("Sit Down", "Bar");
            add_option("Info", "Shop_Explain");
            add_option("Leave", "Shop_Quit");
        }
        else
        {
            add_option("Buy", "Shop_Upgrades");
            add_option("Info", "Shop_Explain");
            add_option("Quit", "Shop_Quit");
        }
    }
}

function check_if_last_ending()
{
    if (oEndingPFFredbear.EndingsSeen == 3)
    {
        add_page("...", "");
        
        Function[TextPageNumber] = function()
        {
            with (oEndingPFFredbear)
            {
                change_expression(1);
            }
        };
        
        add_page("...But you've already seen every way this story ends, haven't you?", "");
        
        Function[TextPageNumber] = function()
        {
            with (oEndingPFFredbear)
            {
                change_expression(3);
            }
        };
        
        add_page("And no matter how you go about it, you can't help everyone. Someone gets left behind...", "");
        
        Function[TextPageNumber] = function()
        {
            with (oEndingPFFredbear)
            {
                change_expression(0);
            }
        };
        
        add_page("...And by the end of it, you're just back at square one.", "");
        
        Function[TextPageNumber] = function()
        {
            with (oEndingPFFredbear)
            {
                change_expression(2);
            }
        };
        
        add_page("Hey, don't be upset! You tried your best, you know?", "");
        
        Function[TextPageNumber] = function()
        {
            with (oEndingPFFredbear)
            {
                change_expression(3);
            }
        };
        
        add_page("Besides, it isn't ALL bad...", "");
        
        Function[TextPageNumber] = function()
        {
            with (oEndingPFFredbear)
            {
                change_expression(2);
            }
        };
        
        add_page("Even if things stay the same, there's...something comforting about that, you know?", "");
        
        Function[TextPageNumber] = function()
        {
            with (oEndingPFFredbear)
            {
                change_expression(1);
            }
        };
        
        add_page("...Well, either way, I'd say you deserve some rest.", "");
        
        Function[TextPageNumber] = function()
        {
            with (oEndingPFFredbear)
            {
                change_expression(0);
            }
        };
        
        add_page("Why don't you take it easy for a while?", "");
    }
}

function talk_to_animatronic(arg0, arg1 = true, arg2 = false)
{
    AnimatronicSpokenTo = arg0;
    if (global.Skins[arg0] > -1)
    {
        arg1 = skin_get_attribute(arg0, "SalvageLocation_SayVoiceLine", true);
    }
    var Shuffle = global.ShuffleData.Animatronics;
    if (array_length(global.SalvagesCurrent) >= global.SalvageQuota && !array_contains([Shuffle[UnknownEnum.Value_20], Shuffle[UnknownEnum.Value_33], Shuffle[UnknownEnum.Value_34], Shuffle[UnknownEnum.Value_35]], arg0))
    {
        add_page("Your quota's already been met! No point in salvaging this one.", "");
        return true;
    }
    if (arg1)
    {
        Function[TextPageNumber] = function()
        {
            play_selection_voiceline(AnimatronicSpokenTo);
        };
    }
    if (skip_cutscenes())
    {
        salvage_options(arg0);
        return true;
    }
    if (skin_salvage_dialogue(AnimatronicSpokenTo, "DIALOGUE"))
    {
        salvage_options(AnimatronicSpokenTo);
        return true;
    }
    return false;
}

function game_text(arg0)
{
    add_page(".", "");
    var Shuffle = global.ShuffleData.Animatronics;
    var CanTakeMask = !array_contains_ext(global.SalvagesCurrent, [Shuffle[UnknownEnum.Value_20], Shuffle[UnknownEnum.Value_33], Shuffle[UnknownEnum.Value_34], Shuffle[UnknownEnum.Value_35]], false) || ultimate_route_unlocked() || global.Night >= 2 || global.DevMode;
    switch (arg0)
    {
        case "Test":
            add_page("Test Test Test. This is test dialogue.", "Name");
            add_page("Isn't it kinda crazy that Freddy Fazbear's actually been real this whole time? Like, who knew, right?", "Name");
            add_page("This text shakes! This text is haunted!", "Name");
            text_effect(0, 17, "Shake");
            text_effect(18, 999, "Spin");
            add_option("Buy", "Test2");
            add_option("Sell", "Test2");
            break;
        case "Test2":
            add_page("Test Test Test. This is more test dialogue.", "Name");
            break;
        case "CreditsEnd":
            Function[TextPageNumber] = function()
            {
                global.SalvagesCurrent = [];
                with (oSalvageSheet)
                {
                    Delete = true;
                }
                with (instance_create_depth(160, 360, 0, oSalvageSheet))
                {
                    PageMode = 2;
                }
            };
            
            add_page(" ", "");
            Hide[TextPageNumber - 1] = true;
            
            Function[TextPageNumber] = function()
            {
                with (oSalvageSheet)
                {
                    Delete = true;
                }
            };
            
            add_page("Thank you for playing, and I hope you had fun!", "");
            
            Function[TextPageNumber] = function()
            {
                audio_sound_gain(musCredits, 0, 1000);
                global.CanContinue = false;
                create_save();
                with (instance_create_depth(0, 0, 0, oTransitionMinigame))
                {
                    Destination = TitleScreenMap;
                }
            };
            
            break;
        case "GuardIntro":
            Function[TextPageNumber] = function()
            {
                with (oTextBox)
                {
                    IntroTheme = get_guard_themes([[sfxWarioLose, 1]], ["theme_intro"]);
                    Sound = IntroTheme[0][0];
                    if (audio_get_type(Sound))
                    {
                        audio_play_sound(Sound, 100, true, IntroTheme[0][1]);
                    }
                    else
                    {
                        Sound = play_music(musGuardOpening);
                    }
                }
                with (instance_create_depth(800, 0, 50, oTalksprite))
                {
                    Image = guard_id_conversion(global.Guard);
                    Sprite = import_sprites("outside.png", sTalksprites_GuardIntros, 1, 320, 0);
                    sprite_index = Sprite;
                }
                audio_play_sound(sfxSwoosh, 10, false);
            };
            
            switch (global.Guard)
            {
                case 0:
                    add_page("Hello there! My name's Jeremy. Jeremy Fitzgerald!", "Jeremy");
                    add_page("Now, you may be wondering, 'Gosh Jeremy, what's a fella like you doing working at a place like this?'", "Jeremy");
                    add_page("Well, it's quite simple, really! My tuition won't pay for itself, so I figured it was the perfect time to get a summer job.", "Jeremy");
                    add_page("...Well, ANOTHER summer job. The last couple never seemed to end well...", "Jeremy");
                    add_page("First there was that time that old lady's nails almost poked my eye out, and that time I spilled that scalding hot coffee all over my face...", "Jeremy");
                    add_page("...Then that mishap with the knives, THAT was a close one, and that one time the car I was chauffeuring got hijacked...", "Jeremy");
                    add_page("...And that accident I got into during that OTHER chauffeuring job that sent me hurtling through the windshield towards that old lady...", "Jeremy");
                    add_page("...Who was carrying a big tray of hot coffee and knives...", "Jeremy");
                    add_page("But on the bright side, my time in the hospital gave me plenty of time to send out applications, and wouldn't you know it, this one got accepted!", "Jeremy");
                    add_page("I'm confident that this will finally be the one! A kiddie pizza place is just about as safe as it gets, after all.", "Jeremy");
                    add_page("And hey, you know what they say - thirteenth time's the charm!", "Jeremy");
                    add_page("...Oh, right, what am I doing standing out here in the rain? There's mascots to be monitored!", "Jeremy");
                    break;
                case 1:
                    add_page("The name's Mike. Mike Schmidt.", "Mike");
                    add_page("The job market's been rough...Well, for me at least. Haven't exactly had the best track record, especially with my resume being...how it is.", "Mike");
                    add_page("I didn't expect to end up working at a place like this, but the career counseler told me it was, quote...", "Mike");
                    add_page("...'Probably the last place in town that would even think about hiring a blasphemously incompetent neanderthal like you'...as he put it.", "Mike");
                    add_page("I'm not really used to night shifts...part of me wonders if I could just sleep through it, but I can't risk getting caught. I'm on thin ice as is.", "Mike");
                    add_page("Even then, this gig seems...odd. Not sure what at this run-down pizza joint is important enough to justify hiring a security guard...", "Mike");
                    add_page("But hey, I'm getting paid for it, and I need this job. Better keep my eyes peeled regardless.", "Mike");
                    add_page("...Right, looks like it's almost midnight. Time to get this started.", "Mike");
                    break;
                case 2:
                    add_page("I'm Vanessa Shelley.", "Vanessa");
                    add_page("I didn't think I'd ever wind up here again, but...I guess things have a funny way of working themselves out.", "Vanessa");
                    add_page("To think taking that summer job who knows how many years ago would've led to a whole career...", "Vanessa");
                    add_page("...Right right, about what I'm doing here.", "Vanessa");
                    add_page("I've actually been working at this chain for a while, even before it changed owners - I still slip up and call it Freddy Fazbear's sometimes, heh.", "Vanessa");
                    add_page("Before now I had a job at our flagship location, but the hustle and bustle got to be a bit much for me.", "Vanessa");
                    add_page("And so, I asked upper management if I could transfer to a smaller location, and even with how few locations were still open...", "Vanessa");
                    add_page("...This one happened to have a position available.", "Vanessa");
                    add_page("It almost seemed like fate, y'know? Like the universe itself wanted me to be right back here, at this very moment...", "Vanessa");
                    add_page("...Not that I believe in any of that stuff, of course.", "Vanessa");
                    add_page("Regardless, that's where I am now. Right back where my whole career started...", "Vanessa");
                    add_page("...But that's enough about the past, I suppose. Today begins this new chapter of my career!", "Vanessa");
                    break;
                case 3:
                    add_page("...", "Fritz");
                    add_page("...I forgot my name.", "Fritz");
                    break;
                default:
                    if (get_guard_property("new_opening_dialogue", false))
                    {
                        read_custom_dialogue("dialogue/cutscene_Opening.txt", "DIALOGUE");
                    }
                    else
                    {
                        var Import = import_dialogue(global.Guard);
                        var NarratorName = "";
                        if (string_lower(Import.FIRST_PERSON) == "true")
                        {
                            NarratorName = guard_nickname();
                        }
                        for (var i = 0; i < array_length(Import.DIALOGUE); i++)
                        {
                            add_page(Import.DIALOGUE[i], NarratorName);
                        }
                    }
                    break;
            }
            
            Function[TextPageNumber] = function()
            {
                audio_stop_sound(Sound);
                with (oTextBox)
                {
                    if (audio_get_type(Sound))
                    {
                        audio_destroy_stream(Sound);
                    }
                }
                with (oTitleMenu)
                {
                    Transitioning = true;
                }
            };
            
            break;
        case "Pause":
            add_page("What would you like to do?", "");
            add_option("Resume", "Resume");
            if (array_length(global.SalvagesCurrent) > 0)
            {
                add_option("View Salvages", "View_Salvages");
            }
            add_option("Quit Game", "Quit_Game");
            break;
        case "Resume":
            break;
        case "View_Salvages":
            add_page("Which animatronic would you like to check?", "");
            for (var i = 0; i < array_length(global.SalvagesCurrent); i++)
            {
                add_option(string(global.Descriptions[global.SalvagesCurrent[i]][0]), "View_Salvage_" + string(i));
            }
            add_option("Back", "Pause");
            break;
        case "View_Salvage_0":
        case "View_Salvage_1":
        case "View_Salvage_2":
        case "View_Salvage_3":
        case "View_Salvage_4":
        case "View_Salvage_5":
        case "View_Salvage_6":
            SalvageNum = real(string_char_at(arg0, 14));
            
            Function[TextPageNumber] = function()
            {
                with (instance_create_depth(160, 360, 256, oSalvageSheet))
                {
                    ID = global.SalvagesCurrent[other.SalvageNum];
                    PageMode = 1;
                }
            };
            
            add_page(" ", "");
            Hide[TextPageNumber - 1] = true;
            
            Function[TextPageNumber] = function()
            {
                with (oSalvageSheet)
                {
                    Delete = true;
                }
            };
            
            add_page("Which animatronic would you like to check?", "");
            for (var i = 0; i < array_length(global.SalvagesCurrent); i++)
            {
                add_option(string(global.Descriptions[global.SalvagesCurrent[i]][0]), "View_Salvage_" + string(i));
            }
            add_option("Back", "Pause");
            break;
        case "Quit_Game":
            add_page("Are you sure you want to quit? Any unsaved progress will be lost.", "");
            add_option("Quit", "Quit");
            add_option("Back", "Pause");
            break;
        case "Quit":
            Function[TextPageNumber] = function()
            {
                game_end();
            };
            
            break;
        case "Salvage_Yes":
            var SalvQuota = global.SalvageQuota;
            var SalvAmount = array_length(global.SalvagesCurrent) + 1;
            var Tutorialize = SalvAmount == 1 && global.Night == 1 && !global.UnlockedAnimatronics[UnknownEnum.Value_128];
            Delay[TextPageNumber] = 60;
            
            Function[TextPageNumber] = function()
            {
                audio_play_sound(sfxTallyTotal, 30, false);
                array_push(global.SalvagesCurrent, other.SalvageID);
                array_push(global.AllTimeSalvages, other.SalvageID);
                global.SalvageRecord[other.SalvageID]++;
                var Earnings = get_animatronic_data(other.SalvageID).SalvageValue / 100;
                earn_money(Earnings);
                if (array_contains([UnknownEnum.Value_40, UnknownEnum.Value_41, UnknownEnum.Value_42, UnknownEnum.Value_43, UnknownEnum.Value_44, UnknownEnum.Value_45, UnknownEnum.Value_46], other.SalvageID))
                {
                    get_trophy(UnknownEnum.Value_13);
                }
                with (oCamera3DMaze.LockOnTarget)
                {
                    Text = "Destroy";
                }
                with (oSalvageSheet)
                {
                    Delete = true;
                }
                with (instance_create_depth(160, 360, 256, oSalvageSheet))
                {
                    ID = other.SalvageID;
                    PageMode = 1;
                }
            };
            
            add_page(" ", "");
            Hide[TextPageNumber - 1] = true;
            
            Function[TextPageNumber] = function()
            {
                with (oSalvageSheet)
                {
                    Delete = true;
                }
            };
            
            if (SalvAmount < SalvQuota)
            {
                if (Tutorialize)
                {
                    add_page("Animatronic salvaged! If you need a refresher, you can review their mechanics in the pause menu.", "");
                    add_page(string(SalvQuota - SalvAmount) + " more until your quota is met.", "");
                }
                else
                {
                    add_page("Animatronic salvaged! " + string(SalvQuota - SalvAmount) + " more until your quota is met.", "");
                }
            }
            else if (Tutorialize)
            {
                add_page("Animatronic salvaged! If you need a refresher, you can review their mechanics in the pause menu.", "");
                add_page("You can head back to the entrance now.", "");
            }
            else
            {
                add_page("That makes " + string(SalvQuota) + "! You can head back to the entrance now.", "");
            }
            break;
        case "Salvage_Yes_Special":
            global.SalvageQuota += 1;
            var SalvQuota = global.SalvageQuota;
            var SalvAmount = array_length(global.SalvagesCurrent) + 1;
            Delay[TextPageNumber] = 60;
            
            Function[TextPageNumber] = function()
            {
                audio_play_sound(sfxTallyTotal, 30, false, 1, 0, 0.8);
                array_push(global.SalvagesCurrent, other.SalvageID);
                array_push(global.AllTimeSalvages, other.SalvageID);
                global.SalvageRecord[other.SalvageID]++;
                var Earnings = get_animatronic_data(other.SalvageID).SalvageValue / 100;
                earn_money(Earnings);
                global.SalvagedScraps[global.Night - 1] = true;
                with (oCamera3DMaze.LockOnTarget)
                {
                    Text = "Destroy";
                }
                with (oSalvageSheet)
                {
                    Delete = true;
                }
                with (instance_create_depth(160, 360, 256, oSalvageSheet))
                {
                    ID = other.SalvageID;
                    PageMode = 1;
                }
                if (ultimate_route_unlocked())
                {
                    with (oInteraction_Disappearing)
                    {
                        CanAppear = true;
                    }
                }
            };
            
            add_page(" ", "");
            Hide[TextPageNumber - 1] = true;
            
            Function[TextPageNumber] = function()
            {
                with (oSalvageSheet)
                {
                    Delete = true;
                }
            };
            
            add_page("Animatronic salvaged! ...Hopefully you won't come to regret this.", "");
            if (SalvAmount < SalvQuota)
            {
                add_page(string(SalvQuota - SalvAmount) + " more until your quota is met.", "");
            }
            else
            {
                add_page("You can head back to the entrance now.", "");
            }
            break;
        case "Salvage_No":
            Function[TextPageNumber] = function()
            {
                with (oSalvageSheet)
                {
                    Delete = true;
                }
            };
            
            add_page("Probably best to peruse your other options first.", "");
            break;
        case "PsychicFriendFredbear_Intro":
            Delay[TextPageNumber] = 60;
            add_page(global.UnlockedAnimatronics[UnknownEnum.Value_128] ? "Well well well, look who's back!" : "Well gosh, look who it is! I was wondering when you'd show up!", "???");
            var Height = floor(clamp(get_guard_property("player_height", 48), 16, 80) / 20);
            var Message = "";
            switch (Height)
            {
                case 0:
                    Message = "...Ahem. Uh, up here.";
                    break;
                case 1:
                    Message = "...Ahem. Over here.";
                    break;
                case 2:
                    Message = "...Ahem. Down here.";
                    break;
                default:
                    Message = "...Ahem. Uh, down here, big guy.";
                    break;
            }
            add_page(Message, "???");
            Delay[TextPageNumber] = 60;
            
            Function[TextPageNumber] = function()
            {
                with (oCamera3DMaze)
                {
                    var NearestPoint = instance_nearest(x, y, oInteraction_Animatronic);
                    LockOnTarget = NearestPoint;
                    LockX = NearestPoint.x;
                    LockY = NearestPoint.y;
                    LockZ = NearestPoint.Height;
                }
            };
            
            if (global.ShuffleMode)
            {
                add_page("I apologize that we couldn't meet under better circumstances. It seems the space-time continuum's gone all screwey!", "Psychic Friend Fredbear");
                add_page("...Which is NOT my fault, by the way. Point is, the animatronics have all wound up in the wrong places!", "Psychic Friend Fredbear");
                add_page("You may meet some unexpected faces here. You might even make a new friend or two!", "Psychic Friend Fredbear");
                add_page("The job's still the same regardless, though! Go talk to them, grab a few, and come back here once you're done.", "Psychic Friend Fredbear");
            }
            else
            {
                add_page("Welcome! You're the new hire, aren't you?", "???");
                add_page("You can call me your Psychic Friend Fredbear! I'm here to help you on your salvaging duties.", "Psychic Friend Fredbear");
                add_page("...Oh, you seem a little confused! Don't worry, I'll explain.", "Psychic Friend Fredbear");
                add_page("Y'see, the company's been a tad shorthanded lately. Because of that, some employees have had to double up on duties!", "Psychic Friend Fredbear");
                add_page("And thanks to that, you not only have the honor of being our one and only security guard, but our one and only salvager as well!", "Psychic Friend Fredbear");
                add_page("Doesn't that make you feel special?", "Psychic Friend Fredbear");
                if (global.SalvageQuota == 1)
                {
                    add_page("Your job here's real simple - Investigate these abandoned locations, find an animatronic, and bring it back with you for spare parts!", "Psychic Friend Fredbear");
                }
                else
                {
                    add_page("Your job here's real simple - Investigate these abandoned locations, find " + string(global.SalvageQuota) + " animatronics, and bring 'em back with you for spare parts!", "Psychic Friend Fredbear");
                }
                add_page("Be on the lookout for trinkets and papers left behind by old employees, too - you might learn a thing or two from them!", "Psychic Friend Fredbear");
                add_page("Oh, and don't worry, the animatronics here should all be friendly. Just try talking to them - they'd love a new place to stay!", "Psychic Friend Fredbear");
                add_page("...Once they're back at your location and learn what we're planning on using them for though, I'm not sure.", "Psychic Friend Fredbear");
                add_page("EITHER WAY, you might as well get to it! Feel free to come back here and talk to me once you're ready to leave.", "Psychic Friend Fredbear");
            }
            add_page("Good luck!", "Psychic Friend Fredbear");
            replace_text(arg0, "PsychicFriendFredbear_Leave");
            break;
        case "PsychicFriendFredbear_1":
            Delay[TextPageNumber] = 60;
            add_page("Ah, there you are!", "Psychic Friend Fredbear");
            
            Function[TextPageNumber] = function()
            {
                with (oCamera3DMaze)
                {
                    var NearestPoint = instance_nearest(x, y, oInteraction_Animatronic);
                    LockOnTarget = NearestPoint;
                    LockX = NearestPoint.x;
                    LockY = NearestPoint.y;
                    LockZ = NearestPoint.Height;
                }
            };
            
            add_page("Took you a while to come here! Though I suppose that only makes sense with a space-time continuum THIS screwey.", "Psychic Friend Fredbear");
            add_page("...It's a nice palette though, isn't it? I'm not used to seeing it like this.", "Psychic Friend Fredbear");
            add_page("Well, regardless, I don't mean to talk your ear off! Go get salvaging!", "Psychic Friend Fredbear");
            replace_text("PsychicFriendFredbear_Intro", "PsychicFriendFredbear_Leave");
            break;
        case "PsychicFriendFredbear_2":
            Delay[TextPageNumber] = 60;
            add_page("Ah, there you are!", "Psychic Friend Fredbear");
            
            Function[TextPageNumber] = function()
            {
                with (oCamera3DMaze)
                {
                    var NearestPoint = instance_nearest(x, y, oInteraction_Animatronic);
                    LockOnTarget = NearestPoint;
                    LockX = NearestPoint.x;
                    LockY = NearestPoint.y;
                    LockZ = NearestPoint.Height;
                }
            };
            
            add_page("Glad to see you found your way here!", "Psychic Friend Fredbear");
            add_page("Have you been paying attention to the salvage values of the animatronics? You get a 1% commission on whatever they're worth!", "Psychic Friend Fredbear");
            add_page("Isn't the company generous?", "Psychic Friend Fredbear");
            add_page("More expensive animatronics might be harder to deal with...but hey, I'm sure they're worth the price!", "Psychic Friend Fredbear");
            add_page("Other than that, same rigmarole as last night! Talk to me when you're done. Now get salvaging!", "Psychic Friend Fredbear");
            replace_text("PsychicFriendFredbear_Intro", "PsychicFriendFredbear_Leave");
            break;
        case "PsychicFriendFredbear_3":
            Delay[TextPageNumber] = 60;
            add_page("Ah, there you are!", "Psychic Friend Fredbear");
            
            Function[TextPageNumber] = function()
            {
                with (oCamera3DMaze)
                {
                    var NearestPoint = instance_nearest(x, y, oInteraction_Animatronic);
                    LockOnTarget = NearestPoint;
                    LockX = NearestPoint.x;
                    LockY = NearestPoint.y;
                    LockZ = NearestPoint.Height;
                }
            };
            
            add_page("Glad to see you found your way here again!", "Psychic Friend Fredbear");
            add_page("You know how to crawl through vents, right? You'll probably need to do a lot of that here.", "Psychic Friend Fredbear");
            add_page("That aside...have fun salvaging!", "Psychic Friend Fredbear");
            replace_text("PsychicFriendFredbear_Intro", "PsychicFriendFredbear_Leave");
            break;
        case "PsychicFriendFredbear_4":
            Delay[TextPageNumber] = 60;
            var UltimateRoute = has_been_ultimate() && currently_ultimate();
            add_page(UltimateRoute ? "Ah, took you long enough!" : "Ah, there you are!", "Psychic Friend Fredbear");
            
            Function[TextPageNumber] = function()
            {
                with (oCamera3DMaze)
                {
                    var NearestPoint = instance_nearest(x, y, oInteraction_Animatronic);
                    LockOnTarget = NearestPoint;
                    LockX = NearestPoint.x;
                    LockY = NearestPoint.y;
                    LockZ = NearestPoint.Height;
                }
            };
            
            add_page("Glad to see you found your way here again!", "Psychic Friend Fredbear");
            switch (global.Guard)
            {
                case 0:
                    add_page("...Uh...do I have the right place? This just looks like someone's house.", "Jeremy");
                    break;
                case 1:
                    add_page("The boss wanted me to salvage animatronics in...some guy's house?", "Mike");
                    break;
                case 2:
                    add_page("...Surely this can't be the place, right?", "Vanessa");
                    break;
                case 3:
                    add_page("The woods...Not what I was expecting, though I suppose this IS a likely place to find bears and rabbits.", "Fritz");
                    add_page("...Do I need to bring a live bear back?", "Fritz");
                    break;
                default:
                    read_custom_dialogue("properties.txt", "psy_friend_fredbear_house", [["...Huh? What is this place? Why did your boss send you here?", "Psychic Friend Fredbear"]]);
                    break;
            }
            add_page("Hey, I don't know any better than you! I'm sure you'll find what you're looking for if you search hard enough.", "Psychic Friend Fredbear");
            add_page("Either way...good luck!", "Psychic Friend Fredbear");
            if (UltimateRoute)
            {
                add_page("...And don't bite off more than you can chew.", "Psychic Friend Fredbear");
            }
            replace_text("PsychicFriendFredbear_Intro", "PsychicFriendFredbear_Leave");
            break;
        case "PsychicFriendFredbear_5":
            Delay[TextPageNumber] = 60;
            add_page("Ah, there you are!", "Psychic Friend Fredbear");
            
            Function[TextPageNumber] = function()
            {
                with (oCamera3DMaze)
                {
                    var NearestPoint = instance_nearest(x, y, oInteraction_Animatronic);
                    LockOnTarget = NearestPoint;
                    LockX = NearestPoint.x;
                    LockY = NearestPoint.y;
                    LockZ = NearestPoint.Height;
                }
            };
            
            add_page("...Hey, wait a second! You aren't supposed to be in here! How did you get in here!?", "Psychic Friend Fredbear");
            add_page("...Oh well, I guess I can't really stop you, can I?", "Psychic Friend Fredbear");
            add_page("Word to the wise - the animatronics here are MEAN. You're probably gonna have a rough time tomorrow night no matter who you salvage.", "Psychic Friend Fredbear");
            add_page("...But hey, you've made it this far, right? I'm sure it's nothing you can't handle.", "Psychic Friend Fredbear");
            add_page("Now, you better not linger too long! You still aren't supposed to be here, you know!", "Psychic Friend Fredbear");
            replace_text("PsychicFriendFredbear_Intro", "PsychicFriendFredbear_Leave");
            break;
        case "PsychicFriendFredbear_Leave":
            if (global.HasGift)
            {
                add_page("...Oh? Is that a gift box? For me?", "Psychic Friend Fredbear");
                add_page("Well, I appreciate the gesture...but I can't exactly open it! I'm just a plushie, after all.", "Psychic Friend Fredbear");
                add_page("Although... Say, try taking that to Upgrade Cadet, he might be willing to give you something in exchange for it.", "Psychic Friend Fredbear");
                break;
            }
            Shuffle = global.ShuffleData.Animatronics;
            if (array_length(global.SalvagesCurrent) == (global.SalvageQuota - 1) && array_contains(global.SalvagesCurrent, [Shuffle[UnknownEnum.Value_20], Shuffle[UnknownEnum.Value_33], Shuffle[UnknownEnum.Value_34], Shuffle[UnknownEnum.Value_35]]))
            {
                add_page("Hey, where do you think YOU'RE going, silly? You...", "Psychic Friend Fredbear");
                add_page("...Huh? Well, it DOES appear you've met the quota, but...", "Psychic Friend Fredbear");
                add_page("One of the animatronics you're carrying looks far too raggedy to be of any use to us! Sorry, but you'll need to find one more.", "Psychic Friend Fredbear");
                break;
            }
            if (array_length(global.SalvagesCurrent) < global.SalvageQuota)
            {
                var SalvAmount = global.SalvageQuota - array_length(global.SalvagesCurrent);
                add_page($"Hey, where do you think YOU'RE going, silly? You're still {SalvAmount} animatronic{(SalvAmount == 1) ? "" : "s"} short!", "Psychic Friend Fredbear");
                add_page("No leaving until the salvage quota's met. Company policy!", "Psychic Friend Fredbear");
                break;
            }
            add_page("Hey, where do you - Oh! I see you've met the quota!", "Psychic Friend Fredbear");
            add_page("Great work, buddy! Do you wanna head on home now?", "Psychic Friend Fredbear");
            add_option("Leave", "PsychicFriendFredbear_Quit");
            add_option("Stay", "PsychicFriendFredbear_Stay");
            replace_text(arg0, "PsychicFriendFredbear_LeaveAlt");
            break;
        case "PsychicFriendFredbear_LeaveAlt":
            add_page("Do you wanna head home now?", "Psychic Friend Fredbear");
            add_option("Leave", "PsychicFriendFredbear_Quit");
            add_option("Stay", "Default");
            break;
        case "PsychicFriendFredbear_Stay":
            add_page("Uh...alright, if you say so! Maybe you'll find something if you look around longer?", "Psychic Friend Fredbear");
            break;
        case "PsychicFriendFredbear_Quit":
            Delay[TextPageNumber] = 600;
            
            Function[TextPageNumber] = function()
            {
                audio_stop_all();
                instance_destroy(oPauser);
                with (instance_create_depth(0, 0, 1000, oTransitionMinigame))
                {
                    Destination = SalvageResults;
                }
                global.DiedToEndo = false;
            };
            
            add_page(" ", "");
            break;
        case "Escape":
            Delay[TextPageNumber] = 600;
            
            Function[TextPageNumber] = function()
            {
                global.SalvagedMasks[global.Night - 1] = 1;
                audio_stop_all();
                instance_destroy(oPauser);
                global.DiedToEndo = false;
                global.UnlockedAnimatronics[UnknownEnum.Value_154] = true;
                with (instance_create_depth(0, 0, 1000, oTransitionMinigame))
                {
                    Destination = SalvageResults;
                }
                instance_destroy(oMazeEnemy);
            };
            
            add_page(" ", "");
            break;
        case "Shop_Intro":
            replace_text(arg0, "Shop");
            play_selection_voiceline(UnknownEnum.Value_130);
            if (global.ShuffleMode || global.UnlockedAnimatronics[UnknownEnum.Value_128])
            {
                add_page("I AM THE UPGRADE CADET. I HAVE UPGRADES ALL DAY, EVERYDAY.", "Upgrade Cadet");
                upgrade_shop();
            }
            else
            {
                add_page("I AM THE UPGRADE CADET. I HAVE UPGRADES ALL DAY, EVERYDAY. UPGRADES. UPGRADES. UPGRADES.", "Upgrade Cadet");
                add_page("...I DO NOT RECOGNIZE YOU. YOU MUST BE A NEW PATRON.", "Upgrade Cadet");
                add_page("WOULD YOU LIKE ME TO EXPLAIN MY SERVICES?", "Upgrade Cadet");
                add_option("Yes", "Shop_Explain");
                add_option("No", "Shop_Continue");
            }
            break;
        case "Shop_Explain":
            if (in_salvage_location())
            {
                add_page("VERY WELL. AHEM...", "Upgrade Cadet");
                add_page("I AM UPGRADE CADET. I PROVIDE VARIOUS GOODS AND SERVICES, WHICH YOU CAN PURCHASE WITH MONEY.", "Upgrade Cadet");
                add_page("YOU MAY PURCHASE UPGRADES FROM ME, WHICH SHOULD MAKE YOUR JOB SIGNIFICANTLY EASIER.", "Upgrade Cadet");
                add_page("THESE UPGRADES WILL PERSIST UNTIL THE END OF YOUR WORK WEEK, BUT COME AT A PRICE.", "Upgrade Cadet");
                add_page("...THAT PRICE BEING MONEY.", "Upgrade Cadet");
                add_page("YOU CAN EARN MONEY FROM SALVAGES, AS WELL AS BONUSES FOR SAVING POWER OR TOKENS DURING A NIGHT.", "Upgrade Cadet");
                add_page("NOW...WOULD YOU LIKE TO BUY SOMETHING?", "Upgrade Cadet");
            }
            else
            {
                switch (global.Shop)
                {
                    case UnknownEnum.Value_0:
                        add_page("What's the matter with you? Never seen an »upgrade shop before!?", "Rockstar Freddy");
                        add_page("...I apologize. That was uncouth of me.", "Rockstar Freddy");
                        add_page("In need of a boost? Freddy here's got all your upgrade needs covered! My upgrades are sure to come in handy during your shifts!", "Rockstar Freddy");
                        add_page("You might notice some differences in them from - ahem, OTHER vendors - but these upgrades will last to the end of your trip all the same.", "Rockstar Freddy");
                        add_page("Furthermore, if you happen to come by again...I might just have more powerful versions of upgrades you've already purchased for sale!", "Rockstar Freddy");
                        add_page("Now, care to peruse my wares?", "Rockstar Freddy");
                        break;
                    case UnknownEnum.Value_1:
                        add_page("Oi, picked the right time to ask for an explanation! I just finished a song about it! Ahem...", "Rockstar Bonnie");
                        add_page("My name's Rockstar Bonnie, I sell minigames! All these pretty cartridges, they're all yours to play!", "Rockstar Bonnie");
                        add_page("The pricier the cartridge, the quicker it'll pay! ...'Least assuming you're good at them, which, hey, who's to say?", "Rockstar Bonnie");
                        add_page("Your favorites, tried-and-true, or something nice and new... Whatever you want, Bonnie's got it for you!", "Rockstar Bonnie");
                        add_page("...Like that one? I've been workshopping it quite a while now.", "Rockstar Bonnie");
                        break;
                    case UnknownEnum.Value_2:
                        add_page("Get in here, let yer ol' friend Chica lay the down-low!", "Rockstar Chica");
                        add_page("Ya'll ever wanted a golden cupcake that lasts between nights? Maybe a beartrap that does the same?", "Rockstar Chica");
                        add_page("What about backup power? Or just a lil somethin' to turn the tides of luck more in yer favor?", "Rockstar Chica");
                        add_page("You wanna ruffle some feathers? You wanna put the egg on the face of your enemies? You wanna RULE THE ROOST?", "Rockstar Chica");
                        add_page("Welly well well... Just feel free to snag something from this hen's handy hoard of helpful handiwork!", "Rockstar Chica");
                        add_page("All my items will carry over between rounds - and they're mighty cheap, too!", "Rockstar Chica");
                        add_page("Now...what can I getcha?", "Rockstar Chica");
                        break;
                    case UnknownEnum.Value_3:
                        add_page("Methinks this be self-explanatory, even fer a landlubber...", "Rockstar Foxy");
                        add_page("SQUAWK! EVEN FER A LANDLUBBER!", "Pickles");
                        add_page("...Aye, Pickles, I'm tryin' to explain to the kid. Quiet down for a second, will ye?", "Rockstar Foxy");
                        add_page("SQUAWK! MY BAD!", "Pickles");
                        add_page("Aye, I've plundered many'er treasure in me sails. I'm more than happy ta' share th'spoils.", "Rockstar Foxy");
                        add_page("If yer a lily-livered landlubber, you'll be wanting to pick the small chest.", "Rockstar Foxy");
                        add_page("Yer guaranteed somethin' good...even if it's cheap as me last pair of britches!", "Rockstar Foxy");
                        add_page("If yer feeling a bit more daring, the middle chests should have enough riches to keep you happy. But be wary - not all of them are full!", "Rockstar Foxy");
                        add_page("Now, the BIG chests - aye, THOSE chests are full of booty fit for a captain!", "Rockstar Foxy");
                        add_page("Though, I've so many I can't remember which ones be real treasure n' which be thief traps...", "Rockstar Foxy");
                        add_page("...Aye, only one way to find out! So, tell ol' Foxy... Arrr ye feelin' lucky?", "Rockstar Foxy");
                        break;
                    case UnknownEnum.Value_4:
                        add_page("Oh, you silly goose! Surely someone as beaten and battered as you knows what a hospital's for!", "Dollie");
                        add_page("My shop'll show up if you're missing a life or two. For a low price (and a liiiittle bit of shock therapy), I can get you feeling good as new!", "Dollie");
                        add_page("You can either get the normal treatment, which restores one life...or, if you're down to your last one, my SPECIAL treatment, which restores two!", "Dollie");
                        add_page("...Though, just so you know, the treatment will get a little more expensive each time I have to perform it.", "Dollie");
                        add_page("Sorry, all those bruises can be tough to buffer out!", "Dollie");
                        add_page("Now, want me to get to work?", "Dollie");
                        break;
                    case UnknownEnum.Value_11:
                        add_page("The trek up this tower can get awful lonely, can't it? Luckily, you're not alone! Plenty of people stop here on their way up.", "Tipsy Bird");
                        add_page("Buy one of them a drink, get talking...and you might just make a friend! (Don't worry, we've got non-alcoholic drinks for the kids too.)", "Tipsy Bird");
                        add_page("Your friends can switch out for you at the start of a round if you see fit...but if you let 'em get jumpscared, you'll be back on your own again!", "Tipsy Bird");
                        add_page("So...what can I get you to drink?", "Tipsy Bird");
                        break;
                    case UnknownEnum.Value_5:
                        add_page("Huh? What do we do?", "Browboy");
                        add_page("Well kid, isn't it obvious? We's a...uh...", "Browboy");
                        add_page("...A vacation agency! Yeah, a vacation agency.", "Browboy");
                        add_page("Got a particular animatronic who's givin' you trouble? Well, me and my boys can take good care of 'em. Send 'em on a trip to Belize. You get me?", "Browboy");
                        add_page("'Course, our work doesn't come cheap. The more money you got when you salvaged the animatronic, the more it'll cost to make 'em disappear.", "Browboy");
                        add_page("That's just how it is these days.", "Browboy");
                        add_page("Just gimme a name and my Ballboys here can get to work, capiche?", "Browboy");
                        break;
                    case UnknownEnum.Value_9:
                        add_page("Aye, I'll keep it simple! (Simple as yeh look. Snrk.)", "Morse");
                        add_page("Us moles are expert diggers, yeh know! And, (for a decent fee, o' course), I'd be willin' to dig a wee tunnel past yer next round or three.", "Morse");
                        add_page("Yeh can just' burrow right past 'em! Or repeat one yeh already finished, if ye'd like. (Weirdo...)", "Morse");
                        add_page("Ye'd have to be off yer head to turn down such an offer! ...So make wit' yer tokens, or get lost.", "Morse");
                        break;
                    case UnknownEnum.Value_6:
                        add_page("Oh, we're, like, your new assistants. We're here to help ensure a smooth employment for staff.", "Olive");
                        add_page("Umm, I think they were asking ME, Olive! Wait your turn, okay? But right you are! You're sooo smart! Ahem...", "Gemini");
                        add_page("We're the Bobbiedots! We understand that every employee has different needs, and won't be able to keep up with everything flying at them.", "Gemini");
                        add_page("Through the power of REVOLUTIONARY MACHINE LEARNING, we can search for animatronics that align with your desires!", "Gemini");
                        add_page("Want more animatronics knocking at your doors? We'll find them for you!", "Gemini");
                        add_page("Take it easy while we tailor your animatronic regimen and streamline your workflow!", "Gemini");
                        add_page("And when you're clocking out after an easy shift, just remember it's all thanks to the Bobbiedots. We work hard so you don't have to!", "Gemini");
                        add_page("Nyeh? We work hard? But all we do is check the database on the company website?", "Rose");
                        add_page("Yes, yes...But if the company knew that, they wouldn't be bankrolling us...!", "Olive");
                        add_page("Now...! How may we serve you?", "Gemini");
                        break;
                    case UnknownEnum.Value_7:
                        add_page("What, do you think you just wandered into the circus? This is a MIDWAY, numbnuts! And at the midway, you play games!", "Carnie");
                        add_page("Each time you come and see me, I'll have three games on offer! One's easy, one's a bit trickier...", "Carnie");
                        add_page("...And the last is too hard for someone who plays like you do.", "Carnie");
                        add_page("Beat 'em, and you'll get to take the game home with you as a prize! ...Along with some other little trinkets if you beat the tougher ones.", "Carnie");
                        add_page("This ain't a charity, though! Each attempt is gonna cost ya some coin, especially the harder games.", "Carnie");
                        add_page("Now, are you gonna make me keep babbling, or are you gonna give one of these games a try?", "Carnie");
                        break;
                    case UnknownEnum.Value_10:
                        add_page("Now, don't get me wrong... You've been doing great with keeping on pace with your salvage quota!", "FazEnt Representative");
                        add_page("...But we're also quite understaffed! If you want job security, you're gonna have to pick up the pace!", "FazEnt Representative");
                        add_page("See, we've got a shareholder meeting coming up, and the numbers on our Rental service are NOT looking good. We gotta raise those earnings!", "FazEnt Representative");
                        add_page("The solution is so simple! If YOU rent them, then I'm pretty sure that technically counts!", "FazEnt Representative");
                        add_page("And if making our investors happy isn't enough of a sell for you, we'll also pay you a bit more than these characters' listed salvage values!", "FazEnt Representative");
                        add_page("It's a win-win! So get on in here!", "FazEnt Representative");
                        break;
                    case UnknownEnum.Value_8:
                        add_page("Ah, say not one more word. I can already tell what troubles you by that look on your face.", "Eleanor");
                        add_page("...You're broke, aren't you?", "Eleanor");
                        add_page("Well, luckily for you...that little problem is one I can solve!", "Eleanor");
                        add_page("Take on any of my wonderful little challenges, and you can wave your money worries goodbye!", "Eleanor");
                        add_page("...Well, so long as you do one, little thing...", "Eleanor");
                        add_page("...Don't die. If you do, I'm afraid I'll need to reclaim what is rightfully mine, and leave you with no reward.", "Eleanor");
                        add_page("But it's not like that'd ever happen to YOU, would it? Now, why don't I show you what I can do?", "Eleanor");
                        break;
                    case UnknownEnum.Value_12:
                        add_page("An explanation? Shoot, anything for a pendejo like you!", "El Chip");
                        add_page("(Oh, and pendejo is Spanish for \"buddy\", in case you didn't know. Withered Bonnie taught me that one!)", "El Chip");
                        add_page("Ahem...\"El Chip's got deals por días! Deals hotter than eldy-oblo! Deals that'll make you shout \"¡Ay caramba!\"", "El Chip");
                        add_page("Just hand over your crummy old upgrades, and I'll swap 'em out for some shiny new ones - maybe even a minigame or consumables too!", "El Chip");
                        add_page("I can even give you higher-tier upgrades without you needing to own the lower-tier ones first! Try getting THAT kind of deal out of the bear!", "El Chip");
                        add_page("So come on in and make a deal with El Chip - you're sure to save Mucho Dinero!\"", "El Chip");
                        add_page("...So whaddaya say? Wanna start tradin' or what?", "El Chip");
                        break;
                    default:
                        add_page("PLACEHOLDER TEXT", "");
                        break;
                }
            }
            upgrade_shop(false);
            break;
        case "Shop_Continue":
            add_page("UNDERSTOOD. LESS WORK FOR ME, THEN.", "Upgrade Cadet");
            add_page("NOW...WOULD YOU LIKE TO BUY SOMETHING?", "Upgrade Cadet");
            upgrade_shop();
            break;
        case "Shop":
            if (in_salvage_location())
            {
                play_selection_voiceline(UnknownEnum.Value_130);
                add_page("I AM THE UPGRADE CADET. I HAVE UPGRADES ALL DAY, EVERYDAY.", "Upgrade Cadet");
                upgrade_shop();
            }
            else
            {
                switch (global.Shop)
                {
                    case UnknownEnum.Value_0:
                        global.UnlockedAnimatronics[UnknownEnum.Value_131] = true;
                        add_page("Welcome, welcome! How can I serve you today?", "Rockstar Freddy");
                        upgrade_shop();
                        break;
                    case UnknownEnum.Value_1:
                        global.UnlockedAnimatronics[UnknownEnum.Value_132] = true;
                        add_page("Take a look around, hey?", "Rockstar Bonnie");
                        upgrade_shop();
                        break;
                    case UnknownEnum.Value_2:
                        global.UnlockedAnimatronics[UnknownEnum.Value_133] = true;
                        add_page("Well howdy! Have a look around, y'hear?", "Rockstar Chica");
                        upgrade_shop();
                        break;
                    case UnknownEnum.Value_3:
                        global.UnlockedAnimatronics[UnknownEnum.Value_134] = true;
                        add_page("Yarr, fortune favors th'bold! Will ye crash against the tides o' chance?", "Rockstar Foxy");
                        upgrade_shop();
                        break;
                    case UnknownEnum.Value_5:
                        global.UnlockedAnimatronics[UnknownEnum.Value_135] = true;
                        add_page("Hey hey, kid! Need someone...taken care of?", "Browboy");
                        upgrade_shop();
                        break;
                    case UnknownEnum.Value_6:
                        global.UnlockedAnimatronics[UnknownEnum.Value_139] = true;
                        add_page("Care to personalize your experience?", "Gemini");
                        upgrade_shop();
                        break;
                    case UnknownEnum.Value_9:
                        global.UnlockedAnimatronics[UnknownEnum.Value_137] = true;
                        add_page("WHAZZAT?! Who's in my gaff!? Oh. S'just one of you nightguard numpties.", "Morse");
                        upgrade_shop();
                        break;
                    case UnknownEnum.Value_7:
                        global.UnlockedAnimatronics[UnknownEnum.Value_140] = true;
                        add_page("Roll up, roll up! Step right this way for a game of skill!", "Carnie");
                        upgrade_shop();
                        break;
                    case UnknownEnum.Value_10:
                        global.UnlockedAnimatronics[UnknownEnum.Value_136] = true;
                        add_page("The Fazbear Special Delivery service is here for you! Care to take one of our fuzzy friends home? (We'll pay you!)", "FazEnt Representative");
                        upgrade_shop();
                        break;
                    case UnknownEnum.Value_8:
                        global.UnlockedAnimatronics[UnknownEnum.Value_138] = true;
                        add_page("Well, what do we have here...?", "Eleanor");
                        upgrade_shop();
                        break;
                    case UnknownEnum.Value_4:
                        global.UnlockedAnimatronics[UnknownEnum.Value_142] = true;
                        add_page("Awww, you poor thing! Would you like me to heal you up?", "Dollie");
                        upgrade_shop();
                        break;
                    case UnknownEnum.Value_11:
                        global.UnlockedAnimatronics[UnknownEnum.Value_143] = true;
                        add_page("Welcome to the booze capital of the afterlife, hun! Should I get you seated?", "Tipsy Bird");
                        upgrade_shop();
                        break;
                    case UnknownEnum.Value_12:
                        global.UnlockedAnimatronics[UnknownEnum.Value_141] = true;
                        add_page("How do you say \"Welcome!\" in Spanish again? Gesundheit?", "El Chip");
                        upgrade_shop();
                        break;
                }
                var AllShopsVisited = true;
                for (var i = 0; i < 13; i++)
                {
                    if (!global.UnlockedAnimatronics[UnknownEnum.Value_131 + i])
                    {
                        AllShopsVisited = false;
                        break;
                    }
                }
                if (AllShopsVisited)
                {
                    unlock_guard(UnknownEnum.Value_13);
                }
            }
            break;
        case "DollieHeal":
            if (global.RunEarnings >= get_heal_price())
            {
                Function[TextPageNumber] = function()
                {
                    audio_play_sound(sfxBitBoost, 10, false);
                    global.RunEarnings -= get_heal_price();
                    coop_heal(false);
                    bitcrush_sound(choose_from_array(get_misc_voicelines(UnknownEnum.Value_142, "Buy")), 0, 0, false, 1.5, 6);
                    with (oShopkeepSprite)
                    {
                        switch_pose(1);
                    }
                };
                
                add_page("There you go, all better! Stay safe out there...", "Dollie");
            }
            else
            {
                Function[TextPageNumber] = function()
                {
                    audio_play_sound(sfxBitFail, 10, false);
                    bitcrush_sound(choose_from_array(get_misc_voicelines(UnknownEnum.Value_142, "Leave")), 0, 0, false, 1.5, 6);
                };
                
                add_page("Oh dear... It doesn't seem you can quite afford my services. Visit me again once you've saved up a little more!", "Dollie");
            }
            break;
        case "DollieFullHeal":
            if (global.RunEarnings >= get_heal_price(1.5))
            {
                Function[TextPageNumber] = function()
                {
                    audio_play_sound(sfxBitBoost, 10, false);
                    global.RunEarnings -= get_heal_price(1.5);
                    coop_heal(true);
                    bitcrush_sound(choose_from_array(get_misc_voicelines(UnknownEnum.Value_142, "Buy")), 0, 0, false, 1.5, 6);
                    with (oShopkeepSprite)
                    {
                        switch_pose(1);
                    }
                };
                
                add_page("There you go, all better! Stay safe out there...", "Dollie");
            }
            else
            {
                Function[TextPageNumber] = function()
                {
                    audio_play_sound(sfxBitFail, 10, false);
                };
                
                add_page("Oh dear... It doesn't seem you can quite afford my services. Visit me again once you've saved up a little more!", "Dollie");
            }
            break;
        case "RockstarFoxyResults":
            switch (abs(global.Jumpscare))
            {
                case 0:
                    bitcrush_sound(choose_from_array(get_misc_voicelines(UnknownEnum.Value_134, "Win")), 0, 0, false, 1.5, 6);
                    add_page("Arr, I suppose ye got what ye paid for. Now get off me ship!", "Rockstar Foxy");
                    break;
                case 1:
                    if (sign(global.Jumpscare) == 1)
                    {
                        bitcrush_sound(choose_from_array(get_misc_voicelines(UnknownEnum.Value_134, "Win")), 0, 0, false, 1.5, 6);
                        add_page("Yarhar, what a treat! Now, take care on the rest of yer voyage.", "Rockstar Foxy");
                    }
                    else
                    {
                        bitcrush_sound(choose_from_array(get_misc_voicelines(UnknownEnum.Value_134, "Lose")), 0, 0, false, 1.5, 6);
                        add_page("Arrrr, unfortunate, that is... But aye, at least it wasn't booby-trapped!", "Rockstar Foxy");
                        add_page("Now get off me ship! I got more chests to prepare.", "Rockstar Foxy");
                    }
                    break;
                case 2:
                    if (sign(global.Jumpscare) == 1)
                    {
                        bitcrush_sound(choose_from_array(get_misc_voicelines(UnknownEnum.Value_134, "Win")), 0, 0, false, 1.5, 6);
                        add_page("In all me years of piratin', I never met a sailor as lucky as ye! Take that with pride, and off ye go!", "Rockstar Foxy");
                    }
                    else
                    {
                        bitcrush_sound(choose_from_array(get_misc_voicelines(UnknownEnum.Value_134, "Lose")), 0, 0, false, 1.5, 6);
                        add_page("B-BY THE SKIRT OF DAVY JONES' MISTRESS! YE BE CURSED! CURSED!", "Rockstar Foxy");
                        add_page("OFF ME SHIP WITH YE, AN' TAKE YER HEXES WITH YE!", "Rockstar Foxy");
                    }
                    break;
            }
            break;
        case "Shop_Conclusion":
            switch (global.Shop)
            {
                case UnknownEnum.Value_3:
                    switch (global.Jumpscare)
                    {
                        case 0:
                            add_page("Sensible one, are ye? Arrr, ye bore me to tears!", "Rockstar Foxy");
                            add_page("Nonetheless, what's in the chest?", "Rockstar Foxy");
                            break;
                        case 1:
                            add_page("Arrrr, that's what I like to see! Now, what kind of treasure will ye find?", "Rockstar Foxy");
                            break;
                        case 2:
                            add_page("Yoho-HO! Daring one, aren'tcha? I like ye!", "Rockstar Foxy");
                            add_page("Now...let's hope you don't get thrown overboard!", "Rockstar Foxy");
                            break;
                    }
                    Delay[TextPageNumber] = 60;
                    
                    Function[TextPageNumber] = function()
                    {
                        instance_create_depth(0, 0, depth - 1, oRockstarFoxy_Chests);
                        ExternalPause = true;
                    };
                    
                    add_page("", "");
                    Hide[TextPageNumber - 1] = true;
                    add_page("", "");
                    break;
                case UnknownEnum.Value_5:
                    Function[TextPageNumber] = function()
                    {
                        with (oShopkeepSprite)
                        {
                            switch_pose(2);
                        }
                    };
                    
                    add_page("Alright kid, deal's a deal!", "Browboy");
                    add_page("Just, uhh...close your eyes for a sec, will ya?", "Browboy");
                    Delay[TextPageNumber] = 60;
                    
                    Function[TextPageNumber] = function()
                    {
                        with (oTextBox)
                        {
                            Transitioning = true;
                        }
                    };
                    
                    Skip[TextPageNumber] = true;
                    add_page(" ", "");
                    Hide[TextPageNumber - 1] = true;
                    Delay[TextPageNumber] = 180;
                    
                    Function[TextPageNumber] = function()
                    {
                        with (oShopkeepSprite)
                        {
                            switch_pose(0);
                        }
                        audio_play_sound(sfxBrowboyShootout, 50, false);
                        audio_play_sound(sfxMetalImpact, 15, false, 0.7);
                        play_deathcoin_voiceline(global.Jumpscare);
                    };
                    
                    Skip[TextPageNumber] = true;
                    add_page(" ", "");
                    Hide[TextPageNumber - 1] = true;
                    
                    Function[TextPageNumber] = function()
                    {
                        with (oTextBox)
                        {
                            Transitioning = false;
                        }
                    };
                    
                    add_page("Alright! That one should be well taken care of.", "Browboy");
                    add_page("See you around, kid!", "Browboy");
                    break;
                case UnknownEnum.Value_6:
                    add_page("Delightful! The regimen shall be put in place.", "Gemini");
                    add_page("Thank you for shopping with us. We hope you enjoyed your experience.", "Gemini");
                    break;
                case UnknownEnum.Value_4:
                    add_page("There you go, all better! Stay safe out there...", "Dollie");
                    break;
                case UnknownEnum.Value_8:
                    add_page("Very well. Don't lose that pendant, now!", "Eleanor");
                    break;
                case UnknownEnum.Value_12:
                    add_page("Bingo-bango! The trade is made!", "El Chip");
                    add_page("Thanks for stopping by, amigo! Be sure to grab a complementary burrito on the way out!", "El Chip");
                    break;
                case UnknownEnum.Value_10:
                    var RandomAddendum = "";
                    switch (irandom(7))
                    {
                        case 0:
                            RandomAddendum = "You know, that one was always my wife's favorite.";
                            break;
                        case 1:
                            RandomAddendum = "My kid's a big fan of that one.";
                            break;
                        case 2:
                            RandomAddendum = "That one's great at parties, you know.";
                            break;
                        case 3:
                            RandomAddendum = "Boy, you've got a good eye!";
                            break;
                        case 4:
                            RandomAddendum = "...Really? Why that one specifically?";
                            break;
                        case 5:
                            RandomAddendum = "That's the one I would've picked!";
                            break;
                        case 6:
                            RandomAddendum = "(Thank goodness, someone finally took that one...)";
                            break;
                        case 7:
                            RandomAddendum = "(...I thought I told them to reserve that one.)";
                            break;
                    }
                    add_page($"Ah, {global.Descriptions[global.Jumpscare][0]}! {RandomAddendum}", "FazEnt Representative");
                    add_page("Remember that all purchases are final and we cannot be held liable for any and all injuries sustained from your decision.", "FazEnt Representative");
                    add_page("Thank you, and have a Faz-eriffic day!", "FazEnt Representative");
                    break;
                case UnknownEnum.Value_7:
                    add_page("Right then, make with the midway game! Let's see if you've got as much skill as you do financial illiteracy!", "Carnie");
                    
                    Function[TextPageNumber] = function()
                    {
                        with (oTextBox)
                        {
                            ExternalPause = true;
                        }
                        instance_create_depth(0, 0, 0, oCarnieMinigame);
                        with (oShopkeepSprite)
                        {
                            switch_pose(1);
                        }
                    };
                    
                    Hide[TextPageNumber] = true;
                    add_page("", "");
                    Hide[TextPageNumber] = true;
                case UnknownEnum.Value_9:
                    add_page("Right! This way, laddie. We havnae got all day!", "Morse");
                    break;
            }
            break;
        case "Carnie_Fail":
            Function[TextPageNumber] = function()
            {
                bitcrush_sound(choose_from_array(get_misc_voicelines(UnknownEnum.Value_140, "Lose")), 0, 0, false, 1.5, 6);
            };
            
            add_page("Wow, kid! That was awful! Just plain awful!", "Carnie");
            add_page("'Course, you're welcome to try again if you got the cash.", "Carnie");
            upgrade_shop(false);
            break;
        case "Carnie_Win":
            Function[TextPageNumber] = function()
            {
                bitcrush_sound(choose_from_array(get_misc_voicelines(UnknownEnum.Value_140, "Win")), 0, 0, false, 1.5, 6);
            };
            
            add_page("Wow, look at you! You won! Guess I gotta hand these over now.", "Carnie");
            
            Function[TextPageNumber] = function()
            {
                audio_play_sound(sfxBitCollect, 15, false);
                switch (global.Jumpscare.HardMode)
                {
                    case 2:
                        switch (global.CarnieItemReward)
                        {
                            case -1:
                                earn_money(28);
                                break;
                            case UnknownEnum.Value_4:
                            case UnknownEnum.Value_9:
                                array_push(global.EndlessInventory.Consumables, 
                                {
                                    ID: global.CarnieItemReward,
                                    Uses: get_consumables(global.CarnieItemReward).Uses
                                });
                                break;
                        }
                    case 1:
                        earn_money(20);
                    case 0:
                        array_push(global.EndlessInventory.Cartridges, global.Jumpscare.ID);
                        break;
                }
            };
            
            add_page("Now get out of here! I'm sick of lookin' at your ugly mug!", "Carnie");
            break;
        case "Shop_Gift":
            add_page("OH, A GIFT BOX?", "Upgrade Cadet");
            add_page("HMM, WELL, I SUPPOSE WHATEVER'S INSIDE MAY MAKE FOR A WORTHWHILE ADDITION TO MY INVENTORY...", "Upgrade Cadet");
            add_page("...TELL YOU WHAT. I WILL GIVE YOU $5.00 IN EXCHANGE FOR IT. DO WE HAVE A DEAL?", "Upgrade Cadet");
            add_option("Yes", "Shop_GiftAccept");
            add_option("No", "Shop_GiftRefuse");
            break;
        case "Shop_GiftAccept":
            global.HasGift = false;
            
            Function[TextPageNumber] = function()
            {
                audio_play_sound(sfxRegister, 5, false);
                earn_money(5);
                global.HasGift = false;
            };
            
            add_page("PLEASURE DOING BUSINESS WITH YOU.", "Upgrade Cadet");
            add_page("NOW...WOULD YOU LIKE TO BUY SOMETHING?", "Upgrade Cadet");
            upgrade_shop();
            break;
        case "Shop_GiftRefuse":
            if (global.Night == 5)
            {
                add_page("SAVING IT FOR A SPECIAL OCCASION? I UNDERSTAND.", "Upgrade Cadet");
                add_page("...EVEN IF THERE'S NOBODY ELSE YOU CAN GIVE IT TO HERE.", "Upgrade Cadet");
            }
            else
            {
                add_page("SAVING IT FOR A SPECIAL OCCASION? I UNDERSTAND. I AM SURE THERE IS SOMEONE HERE WHO WANTS IT MORE.", "Upgrade Cadet");
            }
            add_page("NOW... WOULD YOU LIKE TO BUY SOMETHING?", "Upgrade Cadet");
            upgrade_shop();
            break;
        case "Shop_Upgrades":
            Delay[TextPageNumber] = 5;
            Skip[TextPageNumber] = true;
            
            Function[TextPageNumber] = function()
            {
                instance_create_depth(0, 0, 0, (global.Shop == UnknownEnum.Value_10) ? oShopMenu_FazEntRep : oShopMenu);
                ExternalPause = true;
            };
            
            add_page("", "Upgrade Cadet");
            Hide[TextPageNumber - 1] = true;
            upgrade_shop(true);
            break;
        case "Shop_Story":
            if (array_contains(global.UnlockFlags, "CCStory_Ultimate"))
            {
                add_page("WHICH STORY WOULD YOU LIKE TO HEAR?", "Upgrade Cadet");
                add_option("The Beans", "Shop_StoryTell_Money");
                add_option("The Jester", "Shop_StoryTell_Evil");
                add_option("The Maid", "Shop_StoryTell_Good");
                add_option("The Boy", "Shop_StoryTell_Ultimate");
                add_option("Nevermind", "Shop_Continue");
            }
            else if (oInteraction_Shop.HeardStory)
            {
                add_page("I'M AFRAID I ONLY HAD ONE STORY PREPARED...PERHAPS I WILL TELL ANOTHER IF YOU COME BACK ANOTHER NIGHT.", "Upgrade Cadet");
                add_page("ANYTHING ELSE?", "Upgrade Cadet");
                upgrade_shop();
            }
            else if (global.RunEarnings >= 2.5)
            {
                add_page("A STORY WILL COST YOU $2.50. WOULD YOU LIKE ME TO TELL YOU ONE?", "Upgrade Cadet");
                add_option("Yes", "Shop_StoryTell");
                add_option("No", "Shop_Continue");
            }
            else
            {
                add_page("A STORY WILL COST YOU $2.50.", "Upgrade Cadet");
                add_page("...YOU CANNOT AFFORD THAT.", "Upgrade Cadet");
                add_page("ANYTHING ELSE?", "Upgrade Cadet");
                upgrade_shop();
            }
            break;
        case "Shop_StoryTell":
            Function[TextPageNumber] = function()
            {
                audio_play_sound(sfxRegister, 5, false);
                global.RunEarnings -= 2.5;
                audio_sound_gain(global.Music, 0, 1000);
                oInteraction_Shop.HeardStory = true;
                global.UnlockedAnimatronics[UnknownEnum.Value_130] = true;
            };
            
            var Story = irandom(2);
            if (array_contains(global.UnlockFlags, "CCStory_Money") && array_contains(global.UnlockFlags, "CCStory_Evil") && array_contains(global.UnlockFlags, "CCStory_Good"))
            {
                Story = 3;
            }
            else
            {
                while ((array_contains(global.UnlockFlags, "CCStory_Money") && Story == 0) || (array_contains(global.UnlockFlags, "CCStory_Evil") && Story == 1) || (array_contains(global.UnlockFlags, "CCStory_Good") && Story == 2))
                {
                    Story = irandom(2);
                }
            }
        case "Shop_StoryTell_Money":
        case "Shop_StoryTell_Evil":
        case "Shop_StoryTell_Good":
        case "Shop_StoryTell_Ultimate":
            if (arg0 == "Shop_StoryTell_Money")
            {
                Story = 0;
                
                Function[TextPageNumber] = function()
                {
                    audio_sound_gain(global.Music, 0, 1000);
                };
            }
            if (arg0 == "Shop_StoryTell_Evil")
            {
                Story = 1;
                
                Function[TextPageNumber] = function()
                {
                    audio_sound_gain(global.Music, 0, 1000);
                };
            }
            if (arg0 == "Shop_StoryTell_Good")
            {
                Story = 2;
                
                Function[TextPageNumber] = function()
                {
                    audio_sound_gain(global.Music, 0, 1000);
                };
            }
            if (arg0 == "Shop_StoryTell_Ultimate")
            {
                Story = 3;
                
                Function[TextPageNumber] = function()
                {
                    audio_sound_gain(global.Music, 0, 1000);
                };
            }
            add_page("VERY WELL. AHEM...", "Upgrade Cadet");
            
            Function[TextPageNumber] = function()
            {
                play_music(mus_CandyCadetStory);
            };
            
            switch (Story)
            {
                case 0:
                    add_page("TODAY, I WILL TELL YOU THE STORY OF A YOUNG BOY NAMED JACK.", "Upgrade Cadet");
                    add_page("THE BOY GREW UP POOR ON A FARM, LIVING ONLY WITH HIS MOTHER.", "Upgrade Cadet");
                    add_page("THE TWO HAD RUN DRY THE LITTLE SAVINGS THEY HAD, SO DESPERATELY, JACK'S MOTHER ASKED HIM TO SELL THEIR ONLY COW.", "Upgrade Cadet");
                    add_page("JACK TOOK THE COW TO THE MARKET, WHERE HE MET A STRANGE MAN.", "Upgrade Cadet");
                    add_page("IN EXCHANGE FOR THE COW, THE MAN OFFERED JACK A HANDFUL OF BEANS. JACK ACCEPTED.", "Upgrade Cadet");
                    add_page("ONCE HE RETURNED HOME, HIS MOTHER WAS FURIOUS, THROWING THE BEANS OUT OF THE WINDOW.", "Upgrade Cadet");
                    add_page("HOWEVER, LITTLE DID SHE KNOW, THE USELESS BEANS WERE MUCH MORE VALUABLE THAN ANY MONEY COULD HAVE POSSIBLY BEEN.", "Upgrade Cadet");
                    add_page("SOON, A GIANT BEANSTALK GREW FROM THE MAGIC BEANS, ONE WHICH JACK CLIMBED TO REACH A KINGDOM IN THE SKY.", "Upgrade Cadet");
                    Skip[TextPageNumber] = true;
                    add_page("IN THE KINGDOM LIVED A GIANT AND HIS WIFE. JACK ASKED", "Upgrade Cadet");
                    
                    Function[TextPageNumber] = function()
                    {
                        audio_stop_sound(mus_CandyCadetStory);
                    };
                    
                    switch (global.Guard)
                    {
                        case 0:
                            add_page("Uh...I don't mean to interrupt or anything, but...", "Jeremy");
                            add_page("...This is just Jack and the Beanstalk.", "Jeremy");
                            break;
                        case 1:
                            add_page("This is just Jack and the Beanstalk. You're telling me Jack and the Beanstalk.", "Mike");
                            break;
                        case 2:
                            add_page("Isn't this just Jack and the Beanstalk?", "Vanessa");
                            break;
                        case 3:
                            add_page("When does the death and destruction begin? I'm falling asleep over here...", "Fritz");
                            break;
                        default:
                            read_custom_dialogue("properties.txt", "upgrade_cadet_story", [["You interrupt Upgrade Cadet to tell him you've heard this story before.", ""], ["YOU ASKED FOR A STORY. I AM TELLING YOU A STORY. I DO NOT SEE THE ISSUE.", "Upgrade Cadet"], ["...WHAT? CONTINUE?", "Upgrade Cadet"]]);
                            break;
                    }
                    add_page("YOU ASKED FOR A STORY. I AM TELLING YOU A STORY. I DO NOT SEE THE ISSUE.", "Upgrade Cadet");
                    switch (global.Guard)
                    {
                        case 0:
                            add_page("Well, I just thought it'd be something more...I dunno, original?", "Jeremy");
                            add_page("IT IS A GOOD STORY. ANY ALTERATIONS WOULD DISTRACT FROM ITS MESSAGE.", "Upgrade Cadet");
                            add_page("Alright, sorry sorry, continue with the story.", "Jeremy");
                            break;
                        case 1:
                            add_page("I paid two bucks and fifty cents for this, dude. The least you could do is tell an original story.", "Mike");
                            add_page("IT IS A GOOD STORY. ANY ALTERATIONS WOULD DISTRACT FROM ITS MESSAGE.", "Upgrade Cadet");
                            add_page("Fine, whatever, keep going then.", "Mike");
                            break;
                        case 2:
                            Skip[TextPageNumber] = true;
                            add_page("Well I dunno, I guess I was just expecting", "Vanessa");
                            add_page("IT IS A GOOD STORY. ANY ALTERATIONS WOULD DISTRACT FROM ITS MESSAGE.", "Upgrade Cadet");
                            add_page("...Y'know what, never mind, just continue.", "Vanessa");
                            break;
                        case 3:
                            add_page("I know how these stories go, the kid dies. Go on, just skip to that part.", "Fritz");
                            break;
                    }
                    add_page("NO. YOU HAVE COMPLETELY THROWN OFF MY FLOW. I CANNOT STORYTELL IN THIS CONDITION.", "Upgrade Cadet");
                    add_page("STORIES ARE MORE THE STRONG SUIT OF MY CANDY-DISPENSING BRETHREN ANYWAY...", "Upgrade Cadet");
                    
                    Function[TextPageNumber] = function()
                    {
                        audio_sound_gain(global.Music, 0.5, 1000);
                        array_push(global.UnlockFlags, "CCStory_Money");
                    };
                    
                    break;
                case 1:
                    add_page("TODAY, I WILL TELL YOU THE STORY OF THE FOOLISH JESTER AND THE TYRANT KING.", "Upgrade Cadet");
                    add_page("THERE ONCE LIVED A JESTER, EVER-LOYAL TO HIS RUTHLESS KING.", "Upgrade Cadet");
                    add_page("ONE DAY, THE KING ORDERED THE JESTER TO TRAVEL THE LAND AND FIND FOUR BRAVE WARRIORS.", "Upgrade Cadet");
                    add_page("HE ONLY WANTED THE BEST, ONLY THE STRONGEST, MOST COURAGEOUS, DAUNTLESS WARRIORS FOR HIS ROYAL GUARD.", "Upgrade Cadet");
                    add_page("KNOWING THE KING WOULD HAVE HIS HEAD IF HE REFUSED, THE JESTER OBLIGED.", "Upgrade Cadet");
                    add_page("ONE BY ONE, HE FOUND THE BEST WARRIORS ACROSS THE LAND. THEY WOULD NOT JOIN HIS SIDE EASILY, HOWEVER.", "Upgrade Cadet");
                    add_page("EACH DEMANDED THE JESTER PROVE HIS DEDICATION THROUGH INCREASINGLY PERILOUS TRIALS...", "Upgrade Cadet");
                    add_page("...YET DESPITE THE HARDSHIPS, THE JESTER FOLLOWED THROUGH, EACH AND EVERY TIME.", "Upgrade Cadet");
                    add_page("THE JESTER RETURNED TO THE KING WITH THE FOUR WARRIORS IN TOW, PRESENTING THEM BEFORE THE KING.", "Upgrade Cadet");
                    add_page("THE KING WAS IMPRESSED...BUT NOT YET CONVINCED.", "Upgrade Cadet");
                    add_page("TO PROVE THEIR MIGHT, THE KING ORDERED THE FOUR WARRIORS TO SLAY THE JESTER.", "Upgrade Cadet");
                    add_page("THEY OBLIGED.", "Upgrade Cadet");
                    
                    Function[TextPageNumber] = function()
                    {
                        audio_stop_sound(mus_CandyCadetStory);
                        audio_sound_gain(global.Music, 0.5, 1000);
                        array_push(global.UnlockFlags, "CCStory_Evil");
                    };
                    
                    add_page("...THE END.", "Upgrade Cadet");
                    add_page("I HOPE YOU FOUND THIS STORY ENTERTAINING.", "Upgrade Cadet");
                    break;
                case 2:
                    add_page("TODAY, I WILL TELL YOU THE STORY OF THE OLD MAID AND THE SICKLY BOY.", "Upgrade Cadet");
                    add_page("ONCE, THERE WAS A MAID WHO TENDED TO THE MANOR OF A VERY WEALTHY COUPLE.", "Upgrade Cadet");
                    add_page("EVERY DAY, SHE WOULD SWEEP THROUGH THE HOUSE...ALL OF IT, WITH THE EXCEPTION OF ONE ROOM.", "Upgrade Cadet");
                    add_page("THE COUPLE TOLD HER SHE WAS NEVER TO OPEN THE DOOR TO THE GUEST BEDROOM, NOT UNDER ANY CIRCUMSTANCE.", "Upgrade Cadet");
                    add_page("NOT WANTING TO LOSE HER JOB, SHE OBLIGED...UNTIL ONE DAY.", "Upgrade Cadet");
                    add_page("ONE DAY, TENDING TO THE HOUSE AS SHE ALWAYS HAD BEEN, DRIFTING PAST THE DOOR TO THE ROOM...SHE HEARD CRYING.", "Upgrade Cadet");
                    add_page("SHE COULDN'T HELP HER CURIOSITY. SHE OPENED THE DOOR, AND INSIDE...", "Upgrade Cadet");
                    add_page("...WAS A SICKLY BOY. THE COUPLE'S SON.", "Upgrade Cadet");
                    add_page("HE WAS HAPPY TO HAVE COMPANY AGAIN. HE RARELY SAW HIS PARENTS...THEY SEEMED ASHAMED OF HIM.", "Upgrade Cadet");
                    add_page("THE MAID, HOWEVER, HAD FAR MORE SYMPATHY FOR THE BOY.", "Upgrade Cadet");
                    add_page("WANTING TO HELP HIM FEEL BETTER, SHE ASKED IF THERE WAS ANYTHING SHE COULD DO.", "Upgrade Cadet");
                    add_page("THE BOY ASKED HER TO BRING HIM HIS TOYS FROM AROUND THE HOUSE, SO HE COULD HAVE SOMETHING TO PLAY WITH.", "Upgrade Cadet");
                    add_page("SHE ACCEPTED HIS REQUEST.", "Upgrade Cadet");
                    add_page("SHE SWEPT THROUGH THE HOUSE YET AGAIN, THROUGH EVERY NOOK AND CRANNY, PICKING UP FOUR DUSTY TOYS ALONG THE WAY.", "Upgrade Cadet");
                    add_page("MAKING HER WAY BACK TO THE BOY'S ROOM, SHE CREAKED OPEN HIS DOOR...", "Upgrade Cadet");
                    add_page("...ONLY TO FIND HE HAD PASSED WHILE SHE WAS AWAY.", "Upgrade Cadet");
                    add_page("AND YET...THE BOY HAD A SMILE ON HIS FACE. IT SEEMS ALL IT TOOK TO MAKE HIM HAPPY AGAIN WAS HER COMPANY.", "Upgrade Cadet");
                    
                    Function[TextPageNumber] = function()
                    {
                        audio_stop_sound(mus_CandyCadetStory);
                        audio_sound_gain(global.Music, 0.5, 1000);
                        array_push(global.UnlockFlags, "CCStory_Good");
                    };
                    
                    add_page("...THE END.", "Upgrade Cadet");
                    add_page("I HOPE YOU FOUND THIS STORY ENTERTAINING.", "Upgrade Cadet");
                    break;
                case 3:
                    add_page("TODAY, I WILL TELL YOU THE STORY OF THE BOY.", "Upgrade Cadet");
                    add_page("THERE ONCE LIVED A BOY, A VERY ORDINARY BOY. NOT TOO SHORT, NOT TOO TALL. NOT TOO SMART, NOT TOO DULL.", "Upgrade Cadet");
                    add_page("AND YET, ONE DAY...HE FOUND HIMSELF FULL OF AMBITION.", "Upgrade Cadet");
                    add_page("HE TOLD HIS MOTHER RIGHT THEN AND THERE THAT HE WOULD BECOME A POLICE OFFICER, AND A FIREMAN, AND AN ASTRONAUT.", "Upgrade Cadet");
                    add_page("OF COURSE, HIS MOTHER KNEW THIS WAS SILLY. NOBODY CAN BE EVERYTHING ALL AT ONCE.", "Upgrade Cadet");
                    add_page("...BUT THE BOY WOULD NOT HEAR IT.", "Upgrade Cadet");
                    add_page("ONE DAY, HE LEFT HOME TO PURSUE HIS DREAMS...AND IN HIS FOOLISHNESS, HE SOON FOUND HIMSELF...", "Upgrade Cadet");
                    add_page("...", "Upgrade Cadet");
                    
                    Function[TextPageNumber] = function()
                    {
                        audio_stop_sound(mus_CandyCadetStory);
                        audio_sound_gain(global.Music, 0.5, 1000);
                        array_push(global.UnlockFlags, "CCStory_Ultimate");
                    };
                    
                    add_page("...HMMM.", "Upgrade Cadet");
                    add_page("IT'S...STRANGE. I DO NOT SEEM TO ACTUALLY RECALL HOW THIS STORY ENDS.", "Upgrade Cadet");
                    add_page("OH WELL. I SUPPOSE IT'S UP TO YOU TO WRITE YOUR OWN ENDING NOW.", "Upgrade Cadet");
                    
                    Function[TextPageNumber] = function()
                    {
                        get_trophy(UnknownEnum.Value_27);
                    };
                    
                    add_page("...AH. IT SEEMS I HAVE NOW TOLD YOU EVERY STORY I KNOW.", "Upgrade Cadet");
                    add_page("I KNOW STORIES ARE NOT MY STRONG SUIT...BUT I THANK YOU FOR LISTENING ALL THE SAME.", "Upgrade Cadet");
                    add_page("IF YOU WOULD LIKE ME TO TELL YOU ONE OF THESE STORIES AGAIN, FEEL FREE TO ASK. I SHALL DO SO FREE OF CHARGE.", "Upgrade Cadet");
                    break;
            }
            add_page("ANYTHING ELSE?", "Upgrade Cadet");
            upgrade_shop();
            break;
        case "Shop_Quit":
            if (in_salvage_location())
            {
                add_page("COME AGAIN.", "Upgrade Cadet");
            }
            else
            {
            }
            break;
        case "Marionette":
            if (oMarionetteProp.Holding == 2)
            {
                add_page("Take the mask?", "");
                add_option("Yes", "TakeMask");
                add_option("No", "Marionette_No");
                break;
            }
            else
            {
                if (!oMarionetteProp.Checked)
                {
                    Function[TextPageNumber] = function()
                    {
                        oMarionetteProp.Checked = true;
                    };
                    
                    add_page("It seems to be a Marionette... Wait, was this thing always here?", "");
                    add_page("Its hands are empty. It almost seems like it's expecting you to put something between them...", "");
                    if (!global.HasGift)
                    {
                        break;
                    }
                    if (!CanTakeMask)
                    {
                        add_page("You could give it that gift box you found...", "");
                        add_page("...Though you're already taking back that old model off the record, so this might be pushing it. Better leave it be...for now.", "");
                        break;
                    }
                    add_page("...Give it the gift box?", "");
                }
                else
                {
                    if (!global.HasGift)
                    {
                        add_page("Doesn't seem like you have anything to give it.", "");
                        break;
                    }
                    if (!CanTakeMask)
                    {
                        add_page("You consider giving the Marionette that gift box you found...", "");
                        add_page("...Though you're already taking back that old model off the record, so this might be pushing it. Better leave it be...for now.", "");
                        break;
                    }
                    add_page("Give it the gift box?", "");
                }
                add_option("Yes", "Marionette_Yes");
                add_option("No", "Marionette_No");
            }
            break;
        case "Marionette_Yes":
            Function[TextPageNumber] = function()
            {
                global.HasGift = false;
                oMarionetteProp.Holding = 1;
            };
            
            add_page("The Marionette ascends into the ceiling...", "");
            Delay[TextPageNumber] = 60;
            
            Function[TextPageNumber] = function()
            {
                oMarionetteProp.Holding = 2;
            };
            
            add_page("...And returns with a mask.", "");
            add_page("Take the mask?", "");
            add_option("Yes", "TakeMask");
            add_option("No", "Marionette_No");
            break;
        case "TakeMask":
            if (CanTakeMask)
            {
                Function[TextPageNumber] = function()
                {
                    with (oInteractionPoint)
                    {
                        if (object_index != oMarionetteProp && Text != "Escape")
                        {
                            instance_destroy();
                        }
                    }
                    with (oMarionetteProp)
                    {
                        Activated = true;
                    }
                    with (oEnemySpawnPoint)
                    {
                        with (instance_create_depth(x, y, 0, oMazeEnemy))
                        {
                            PatrolID = other.PatrolID;
                        }
                    }
                    with (oCamera3DMaze)
                    {
                        CurrentPalette = 14;
                        CurrentLoadZone = 99;
                    }
                    audio_stop_sound(musMinigameA);
                    audio_stop_sound(musMinigameB);
                    audio_stop_sound(musMinigameC);
                    audio_stop_sound(musMinigameD);
                    audio_stop_sound(musMinigameE);
                    audio_play_sound(sfxAmbience, 10, true, 1);
                    audio_play_sound(sfxPowerDown, 10, false, 1);
                    with (oMazeWall_Flat)
                    {
                        if (Sprite == sMazeDecor_Boards)
                        {
                            instance_destroy();
                        }
                    }
                };
                
                Delay[TextPageNumber] = 60;
                add_page("Get back to the exit...quietly.", "");
                replace_text("Marionette", "Marionette_Active");
            }
            else
            {
                add_page("You reach out to take the mask...", "");
                add_page("...But you remember you're already taking back that old model off the record, and fear this might be pushing it.", "");
                add_page("Maybe you could try after another couple weeks on the job...but not wanting get fired on your first day, you decide not to take the mask.", "");
            }
            break;
        case "Marionette_No":
            break;
        case "Marionette_Active":
            add_page("Do you have any idea what you're getting yourself into?", "");
            break;
        case "Endo_Death":
            Delay[TextPageNumber] = 180;
            add_page("...You wake up outside.", "");
            add_page("You still have the mask...but it seems your pockets are five dollars lighter.", "");
            add_page("Better luck next time!", "");
            Delay[TextPageNumber] = 600;
            
            Function[TextPageNumber] = function()
            {
                global.SalvagedMasks[global.Night - 1] = 1;
                audio_stop_all();
                instance_destroy(oPauser);
                global.DiedToEndo = true;
                with (instance_create_depth(0, 0, 1000, oTransitionMinigame))
                {
                    Destination = SalvageResults;
                }
            };
            
            add_page(" ", "");
            break;
        case "BB_Normal":
            Function[TextPageNumber] = function()
            {
                play_selection_voiceline(UnknownEnum.Value_14);
            };
            
            add_page("Hi! Hello! Hahaha!", "BB");
            add_page("...Seems like someone bolted him to the floor. Guess you won't be salvaging this one.", "");
            break;
        case "BB_Quiz":
            Function[TextPageNumber] = function()
            {
                play_selection_voiceline(UnknownEnum.Value_14);
            };
            
            add_page("Hi! Hello! Hahaha!", "BB");
            add_page("...Huh? You're looking for a key?", "BB");
            add_page("Haha! Well, you're in luck, because I've got one right here!", "BB");
            add_page("...Huh? GIVE it to you? C'mon, where's the fun in that?", "BB");
            add_page("Hmmm...tell ya what, I'll give this key to you...", "BB");
            add_page("...If you pass my quiz! Whaddaya say?", "BB");
            replace_text(arg0, "BB_Quiz_Short");
            add_option("Yes", "BB_Quiz_1");
            add_option("No", "BB_Quiz_No");
            break;
        case "BB_Quiz_Short":
            Function[TextPageNumber] = function()
            {
                play_selection_voiceline(UnknownEnum.Value_14);
            };
            
            add_page("Wanna retry the quiz?", "BB");
            add_option("Yes", "BB_Quiz_1");
            add_option("No", "BB_Quiz_No");
            break;
        case "BB_Quiz_Cleared":
            Function[TextPageNumber] = function()
            {
                play_selection_voiceline(UnknownEnum.Value_14);
            };
            
            add_page("Those were my best questions...I'd better think up some new ones for the next guy who comes through here.", "BB");
            break;
        case "BB_Quiz_No":
            add_page("Aww, you're no fun! No key for you, then...", "BB");
            break;
        case "BB_Quiz_Fail":
            add_page("...BZZZZT! WRONG!", "BB");
            add_page("Sorry buddy! Looks like you'll have to try again.", "BB");
            break;
        case "BB_Quiz_1":
            add_page("Alright, let's get this started!", "BB");
            add_page("QUESTION 1!", "BB");
            var Answers;
            switch (irandom_range(0, 2))
            {
                case 0:
                    add_page("How many salvagable animatronics are at this location?", "BB");
                    var NumOffset = has_upgrade(UnknownEnum.Value_8) ? 1 : (has_upgrade(UnknownEnum.Value_9) ? 2 : (has_upgrade(UnknownEnum.Value_10) ? 3 : 0));
                    Answers = array_shuffle([[string(5 + NumOffset), "BB_Quiz_Fail"], [string(6 + NumOffset), "BB_Quiz_Fail"], [string(7 + NumOffset), "BB_Quiz_2"], [string(8 + NumOffset), "BB_Quiz_Fail"]]);
                    break;
                case 1:
                    add_page("What does Toy Chica's bib say?", "BB");
                    Answers = array_shuffle([["Let's party!", "BB_Quiz_2"], ["Let's eat!", "BB_Quiz_Fail"], ["Let's rock!", "BB_Quiz_Fail"], ["Let's play!", "BB_Quiz_Fail"]]);
                    break;
                case 2:
                    add_page("What's your reason for working here?", "BB");
                    Answers = array_shuffle([["Pay for tuition", (global.Guard == 0) ? "BB_Quiz_2" : "BB_Quiz_Fail"], ["Bad resume", (global.Guard == 1) ? "BB_Quiz_2" : "BB_Quiz_Fail"], ["Work environment", (global.Guard == 2) ? "BB_Quiz_2" : "BB_Quiz_Fail"], ["I forgot", (global.Guard == 3) ? "BB_Quiz_2" : "BB_Quiz_Fail"]]);
                    if (global.Guard >= 21)
                    {
                        Answers[irandom(3)] = [get_guard_property("bb_quiz_answer", "I was modded in"), "BB_Quiz_2"];
                    }
                    break;
            }
            add_option(Answers[0][0], Answers[0][1]);
            add_option(Answers[1][0], Answers[1][1]);
            add_option(Answers[2][0], Answers[2][1]);
            add_option(Answers[3][0], Answers[3][1]);
            break;
        case "BB_Quiz_2":
            add_page("...CORRECT! Nice job!", "BB");
            add_page("ONTO QUESTION 2!", "BB");
            var Answers;
            switch (irandom_range(0, 2))
            {
                case 0:
                    add_page("What year did Fazbear Entertainment file for bankruptcy?", "BB");
                    Answers = array_shuffle([["2004", "BB_Quiz_3"], ["2023", "BB_Quiz_Fail"], ["1987", "BB_Quiz_Fail"], ["1993", "BB_Quiz_Fail"]]);
                    break;
                case 1:
                    add_page("How many tokens do you get for clearing Fredsweeper?", "BB");
                    Answers = array_shuffle([["30", "BB_Quiz_3"], ["15", "BB_Quiz_Fail"], ["10", "BB_Quiz_Fail"], ["20", "BB_Quiz_Fail"]]);
                    break;
                case 2:
                    add_page($"Which of these animatronics is worth ${get_animatronic_data(UnknownEnum.Value_11).SalvageValue}?", "BB");
                    Answers = array_shuffle([["Withered Bonnie", "BB_Quiz_3"], ["Withered Freddy", "BB_Quiz_Fail"], ["Withered Chica", "BB_Quiz_Fail"], ["Endoskeleton", "BB_Quiz_Fail"]]);
                    break;
            }
            add_option(Answers[0][0], Answers[0][1]);
            add_option(Answers[1][0], Answers[1][1]);
            add_option(Answers[2][0], Answers[2][1]);
            add_option(Answers[3][0], Answers[3][1]);
            break;
        case "BB_Quiz_3":
            add_page("...CORRECT! I'm impressed!", "BB");
            add_page("FINAL QUESTION!", "BB");
            var Answers;
            switch (irandom_range(0, 2))
            {
                case 0:
                    add_page("If you earn 100 tokens and buy a Golden Cupcake, a Distortion Clock and two Snowcones, how much do you have left?", "BB");
                    Answers = array_shuffle([["30", "BB_Quiz_Win"], ["25", "BB_Quiz_Fail"], ["40", "BB_Quiz_Fail"], ["45", "BB_Quiz_Fail"]]);
                    break;
                case 1:
                    add_page("How many party tables are at this location, total?", "BB");
                    Answers = array_shuffle([["18", "BB_Quiz_Win"], ["19", "BB_Quiz_Fail"], ["20", "BB_Quiz_Fail"], ["17", "BB_Quiz_Fail"]]);
                    break;
                case 2:
                    add_page("What's Shadow Bonnie's legal name?", "BB");
                    Answers = array_shuffle([["RWQFSFASXC", "BB_Quiz_Win"], ["RXQFSFASXC", "BB_Quiz_Fail"], ["RWQFSFASWC", "BB_Quiz_Fail"], ["RWQFSAFSXC", "BB_Quiz_Fail"]]);
                    break;
            }
            add_option(Answers[0][0], Answers[0][1]);
            add_option(Answers[1][0], Answers[1][1]);
            add_option(Answers[2][0], Answers[2][1]);
            add_option(Answers[3][0], Answers[3][1]);
            break;
        case "BB_Quiz_Win":
            add_page("...CORRECT!", "BB");
            add_page("Alright alright, you beat me fair and square. Here's the key!", "BB");
            
            Function[TextPageNumber] = function()
            {
                audio_play_sound(sfxBitCollect, 10, false);
            };
            
            add_page("You got the Parts & Service key.", "");
            replace_text("BB_Quiz_Short", "BB_Quiz_Cleared");
            replace_text("FT_LockedParts&ServiceDoor", "FT_LockedParts&ServiceDoor_Unlocked");
            break;
        case "Salvage":
            var ID = instance_nearest(oCamera3DMaze_Cursor.x, oCamera3DMaze_Cursor.y, oInteraction_Animatronic).AnimatronicID;
            var Name = global.Descriptions[ID][0];
            if (talk_to_animatronic(ID))
            {
                break;
            }
            switch (ID)
            {
                case UnknownEnum.Value_10:
                    add_page("You know me! I'm the bear who stares, scares, and is a little worse for wear, Freddy Fazbear™!", "Withered Freddy");
                    add_page("Looking for a new friend to join you back at your pizzeria? Well, shoot - Freddy's ALWAYS up for making new friends!", "Withered Freddy");
                    add_page("I'd love to keep you company there...Well, as long as you have enough pizza. Gyuh-huh!", "Withered Freddy");
                    add_page("So whaddaya say? Wanna take me home?", "Withered Freddy");
                    break;
                case UnknownEnum.Value_11:
                    add_page("¿Eh? ¿Quien está aquí? No puedo ver muy bien sin mi cara.", "Withered Bonnie");
                    var Insult = "gordo";
                    switch (global.Guard)
                    {
                        case 0:
                            Insult = "hombre-sin-cara desgraciado";
                            break;
                        case 1:
                            Insult = "gordo baboso";
                            break;
                        case 2:
                            Insult = "nina fea";
                            break;
                        case 3:
                            Insult = "bastardo loco";
                            break;
                        default:
                            Insult = get_guard_property("withered_bonnie", "gordo");
                            break;
                    }
                    add_page($"¡Oye! ¡Hola! Te estoy hablando, {Insult}! ¿Puedes escucharme?", "Withered Bonnie");
                    add_page("...Oh, solo hablas ingles? Lo siento, cambiaré mi configuración de idioma.", "Withered Bonnie");
                    add_page("Ahem...my apologies.", "Withered Bonnie");
                    add_page("Looking for animatronics to salvage? You should take me! I'm bilingual, I'm a rabbit, and my guitar skills are second to none!", "Withered Bonnie");
                    add_page("...Well, they were before I lost my other arm, at least. But two for one ain't bad, eh?", "Withered Bonnie");
                    break;
                case UnknownEnum.Value_12:
                    add_page("GRAAAAAUAAAAAAAAAAAUAUGHHHGHHH", "Withered Chica");
                    add_page("H-H-HEL-H-H-HE-H-HEL-HE-HEL-H-H-H-HE-HEL", "Withered Chica");
                    add_page("GFVNWGHIEIIRWQFSAFSXCGHSFJLGHDFSG", "Withered Chica");
                    add_page("GRAAAAAUAAAAAAAAAAAUAUGHHHGHHH", "Withered Chica");
                    break;
                case UnknownEnum.Value_13:
                    add_page("Yarr, ahoy there, ye scurvy sea dog! ", "Withered Foxy");
                    add_page("I can tell by that look in yer eye - yer lookin' for a mate to sail the high seas with, aren'tcha?", "Withered Foxy");
                    add_page("Well, assumin' you've got the booty, I'd love to join your crew!", "Withered Foxy");
                    add_page("...And that's booty as in treasure, y'know. So don't get any ideas.", "Withered Foxy");
                    add_page("So what do you say to me becomin' your first mate, matey? Is it a yay, or is it a nay?", "Withered Foxy");
                    break;
                case UnknownEnum.Value_4:
                    add_page("...This one doesn't seem much for conversation.", "");
                    add_page("In fact, it doesn't seem like it's functional at all...", "");
                    break;
                case UnknownEnum.Value_5:
                    add_page("DIALOGUE ERROR: NO ANIMATRONIC IDENTITY SET.", "Endoskeleton");
                    add_page("PLEASE ASSIGN VALUE AND TRY AGAIN.", "Endoskeleton");
                    break;
                case UnknownEnum.Value_6:
                    add_page("Bored, bored, BORED!", "Toy Freddy");
                    add_page("I thought all these arcade machines would keep me busy while I was stuck in here, but...", "Toy Freddy");
                    add_page("...D'oh, I've mastered every single one already! Now none of them are FUN anymore!", "Toy Freddy");
                    add_page("Sigh...it's tough being a gamer bear like me...", "Toy Freddy");
                    add_page("...Say, you wouldn't happen to have any games at YOUR location, would you?", "Toy Freddy");
                    add_page("You do!? HURRAY! There's hope for me yet!", "Toy Freddy");
                    add_page("How about you let a bear hitch a ride with you back there, eh?", "Toy Freddy");
                    break;
                case UnknownEnum.Value_7:
                    add_page("Ah, another fan! Right then, hand over whatever you want me to autograph.", "Toy Bonnie");
                    add_page("...Huh? You're here to salvage me? You wanna take me with you back to your location?", "Toy Bonnie");
                    add_page("Pshhh, quit fooling around! There's no way you'd be able to afford my rates.", "Toy Bonnie");
                    add_page("A rising star like me can't just putz around with whoever. My fans here need me!", "Toy Bonnie");
                    add_page("...Although I suppose having a bigger audience would definitely be nice...", "Toy Bonnie");
                    add_page("...You know what, I changed my mind! I'll go with you! Go on then, show me to my limousine.", "Toy Bonnie");
                    break;
                case UnknownEnum.Value_8:
                    add_page("Huh? You wanna, like, take me back to your place?", "Toy Chica");
                    add_page("Uh...yeah, in your DREAMS! At LEAST, like, take me out to dinner first.", "Toy Chica");
                    add_page("...What? You're a salvager? ...Oooh, that like, makes way more sense, yeah.", "Toy Chica");
                    add_page("Well in that case, you should, like, TOTALLY take us back to your place, yeah. We're like, TOTALLY fun at parties.", "Toy Chica");
                    add_page("So? Am I coming with?", "Toy Chica");
                    break;
                case UnknownEnum.Value_9:
                    add_page("OOH, A NEW FRIEND! A NEW FRIEND TO PLAY WITH! IT'S BEEN YEARS!", "Mangle");
                    add_page("YOU KNOW, IT GETS AWFUL LONELY HERE...THE OTHERS DON'T TALK TO ME MUCH.", "Mangle");
                    add_page("I THINK THEY'RE JUST JEALOUS OF HOW PRETTY I AM.", "Mangle");
                    add_page("BUT YOU SEEM FRIENDLY! HOW ABOUT WE HANG OUT BACK AT YOUR PLACE, FRIEND?", "Mangle");
                    break;
                case UnknownEnum.Value_15:
                    add_page("Shhh, quiet! Me and my brother are playing hide-n-seek, and I can't let him find me!", "JJ");
                    add_page("...Whuzzat? You think you know a better hiding spot?", "JJ");
                    add_page("Ooh, a completely different location? That's genius! I bet he'll NEVER find me there!", "JJ");
                    add_page("...Especially since I don't think his programming even allows him to leave the building!", "JJ");
                    add_page("So sure, I'll go with you! Will you take me there?", "JJ");
                    break;
                case UnknownEnum.Value_18:
                    add_page("∎∎∎∎∎ ∎∎∎∎∎∎∎∎ ∎∎∎∎∎∎∎∎ ∎∎ ∎∎∎∎∎∎∎∎ ∎∎∎∎∎. ∎∎∎ ∎∎∎ ∎∎∎∎ ∎∎∎∎ ∎'∎ ∎∎∎∎∎∎?", "RWQFSFASXC");
                    add_page("...∎∎∎∎. ∎ ∎∎∎∎∎∎∎ ∎∎ ∎∎∎∎.", "RWQFSFASXC");
                    add_page("∎∎∎∎, ∎∎ ∎∎∎ ∎∎∎ ∎∎∎∎ ∎∎∎∎ ∎'∎ ∎∎∎∎∎∎, ∎∎∎∎∎ ∎∎∎∎∎∎∎ ∎∎?", "RWQFSFASXC");
                    break;
                case UnknownEnum.Value_17:
                    add_page("As you reach out to inspect this animatronic...you notice that your hand phases right through it.", "");
                    add_page("The animatronic may not actually exist within this physical realm. Luckily, the boss never said your salvages necessarily needed to.", "");
                    break;
                case UnknownEnum.Value_19:
                    add_page("OoOoOoOoOoOo! DOES MY PARANORMAL PRESENCE FRIGHTEN YOU, MORTAL?", "Phantom BB");
                    text_effect(0, 999, "Shake");
                    add_page("I AM A PHANTOM! A GHOULISH MANIFESTATION OF THE FEAR AND SUFFERING THIS CHAIN HAS CAUSED!", "Phantom BB");
                    text_effect(0, 999, "Shake");
                    add_page("...What? C'mon, you should be quaking in your boots! Do I not FRIGHTEN you!?", "Phantom BB");
                    text_effect(62, 70, "Shake");
                    add_page("Oh what, let me guess, you think I look like a watermelon, huh?", "Phantom BB");
                    add_page("Yeah yeah, get all your jokes out, it's not like I've already heard them a million times before.", "Phantom BB");
                    add_page("Listen, just...*sniff* Whatever man, I don't even care if you salvage me anymore. *sniff* Just leave me alone...", "Phantom BB");
                    text_effect(15, 21, "Shake");
                    text_effect(82, 999, "Shake");
                    break;
                case UnknownEnum.Value_30:
                    add_page("Woah there, pal! Don't tell me you're here salvaging animatronics all by yourself!", "Helpy");
                    add_page("Y'know, you could really use a little helper like me! Every job's more fun with a bear buddy by your side.", "Helpy");
                    Skip[TextPageNumber] = true;
                    switch (global.Guard)
                    {
                        case 0:
                            add_page("Funny you mention it! I actually already have a-", "Jeremy");
                            break;
                        case 1:
                            add_page("Uh...yeah, no, I actually-", "Mike");
                            break;
                        case 2:
                            add_page("I appreciate the offer, but I actually already have one over-", "Vanessa");
                            break;
                        case 3:
                            add_page("Well, I suppose I could-", "Fritz");
                            break;
                        default:
                            read_custom_dialogue("properties.txt", "helpy", [["You point out to Helpy that you do, in fact, already have a-", ""]]);
                            break;
                    }
                    add_page("So you DO need help! Great, great! That's what I do best!", "Helpy");
                    add_page("Whaddaya say to me tagging along with you, huh, buddy?", "Helpy");
                    add_page("All you have to do is install me on your computer! (Just be sure to disable your antivirus first!)", "Helpy");
                    break;
                case UnknownEnum.Value_31:
                    global.Jumpscare = audio_sound_get_gain(global.Music);
                    add_page("Hey, watch it, will ya!? You almost threw off my groove!", "Music Man");
                    add_page("I'm working on a new song, you dig? It goes a little something like this.", "Music Man");
                    
                    Function[TextPageNumber] = function()
                    {
                        audio_sound_gain(global.Music, 0, 1000);
                    };
                    
                    add_page("Ahem...", "Music Man");
                    
                    Function[TextPageNumber] = function()
                    {
                        play_music(musMusicMan);
                    };
                    
                    add_page("This old, moldy place has me down in the dumps! »I'd be jammin' all night if not jammed with these chumps!", "Music Man");
                    text_effect(0, 999, "Spin");
                    add_page("They call me a freak, geek, even unsightly! »All this critique, man, I'm gettin' it nightly!", "Music Man");
                    text_effect(0, 999, "Spin");
                    add_page("So please get me out, yeah, get me some space, »Please get me over to your pizza place!", "Music Man");
                    text_effect(0, 999, "Spin");
                    
                    Function[TextPageNumber] = function()
                    {
                        audio_stop_sound(musMusicMan);
                        with (oCamera3DMaze)
                        {
                            audio_sound_gain(global.Music, global.Jumpscare, 1000);
                        }
                    };
                    
                    add_page("...Ehh?", "Music Man");
                    break;
                case UnknownEnum.Value_32:
                    add_page("Ah, looks like I'm in quite the pickle...took one wrong turn at the park and somehow wound up here!", "Mr. Hippo");
                    add_page("I'm not even quite sure how this all happened, to be honest with you. It seems I just...forgot.", "Mr. Hippo");
                    add_page("You know how things are once you get old, your mind's not quite as sharp as it used to be. You can be walkin' in the park one second, the next...", "Mr. Hippo");
                    add_page("...Well, you end up in a dark, decrepit, frankly sorta eerie place like this.", "Mr. Hippo");
                    add_page("Y'know, this whole thing actually reminds me a bit of this one time I was with my good friend Orville, y'see...", "Mr. Hippo");
                    add_page("He just keeps talking to himself. You struggle to stay awake as he rambles on for what feels like hours.", "");
                    add_page("And I guess all this is to say that there are certain things you just shouldn't say to your in-laws.", "Mr. Hippo");
                    add_page("...Right, you were here for some sort of salvaging job, weren't you?", "Mr. Hippo");
                    break;
                case UnknownEnum.Value_37:
                    add_page("This animatronic seems to be maintaining intense, unbreaking, direct eye contact with you at all times.", "");
                    add_page("Despite your best efforts to ignore it, its stare has not broken, not once.", "");
                    add_page("It's getting really uncomfortable... Maybe it'll stop if you take it with you?", "");
                    break;
                case UnknownEnum.Value_35:
                    add_page("...I didn't expect you to come looking for me.", "Scrap Baby");
                    add_page("I thought the company deemed me too broken to be worth salvaging...what's so special about you?", "Scrap Baby");
                    add_page("...I take it you won't be reporting this particular salvage to the company.", "Scrap Baby");
                    add_page("Not that I blame you...after all, ignorance is bliss, is it not?", "Scrap Baby");
                    add_page("You know, that company you work for...it's kept its fair share of secrets from you too.", "Scrap Baby");
                    add_page("If you take me along, maybe I can show you how they really conduct their business, hm?", "Scrap Baby");
                    add_page("You might just learn a thing or two.", "Scrap Baby");
                    break;
                case UnknownEnum.Value_21:
                    add_page("Oy, bugger off! I'm trying to watch the telly!", "Plushtrap");
                    add_page("We're about to find out who the real pa of Clara's baby is! Don't you see how IMPORTANT this is?", "Plushtrap");
                    add_page("...What? Oh, gimme a break, the telly's all I've got ever since me old playmate left.", "Plushtrap");
                    add_page("Sigh...how I used to love playing tag with him...it was wonderful, he'd never stop running!", "Plushtrap");
                    add_page("...You what? YOU'D like to play with me? Back at your pizzeria?", "Plushtrap");
                    add_page("Well well, you're not at all the muppet I took ya for! Let's get a-movin' right along, why don't we?", "Plushtrap");
                    break;
                case UnknownEnum.Value_22:
                    add_page("You nightguards are getting bolder by the day, aren't you?", "Nightmare Fredbear");
                    add_page("You come here, and you disrespect me. You ask me to come back to your sorry excuse for a pizza parlor.", "Nightmare Fredbear");
                    add_page("Don't even mention that place to me. That greasy good-for-nothing grandson of mine brought nothing but shame to the Fazbear name.", "Nightmare Fredbear");
                    add_page("What I'd do to bring some damn dignity back to this thing of ours...the family business used to MEAN somethin'.", "Nightmare Fredbear");
                    add_page("...Hmmm.", "Nightmare Fredbear");
                    add_page("Tell ya what, I'll make you an offer. I'll come back to that lousy pizza joint of yours, and I get to...conduct my business.", "Nightmare Fredbear");
                    add_page("You get your way, I get mine. Howsabout it?", "Nightmare Fredbear");
                    break;
                case UnknownEnum.Value_23:
                    add_page("BOO!", "Nightmare BB");
                    text_effect(0, 4, "Shake");
                    add_page("...Awww, c'mon! You didn't even flinch!", "Nightmare BB");
                    add_page("Grrr...losers like you wouldn't know a good jumpscare if it bit your face off.", "Nightmare BB");
                    add_page("You know what? I don't even WANT you to salvage me. I bet your pizzeria STINKS just as much as you do.", "Nightmare BB");
                    add_page("And I don't hang around STINKY LOSERS who STINK.", "Nightmare BB");
                    break;
                case UnknownEnum.Value_24:
                    add_page("So you've finally found yourself standing at my feet...figuratively speaking.", "Nightmarionne");
                    add_page("You're quite the fascinating case, do you know that?", "Nightmarionne");
                    add_page("I've never seen someone so willing to face lethal danger as many times as you have...only to go back and do it again.", "Nightmarionne");
                    add_page("You must be very comfortable with your own mortality. ...Or perhaps just desperate for a paycheck.", "Nightmarionne");
                    add_page("Bravery or foolishness...It really makes no difference to me.", "Nightmarionne");
                    add_page("I only want to know...are you brave enough to stand face-to-face against death itself?", "Nightmarionne");
                    break;
                case UnknownEnum.Value_36:
                    add_page("YOU! How dare a tiny morsel like you walk up to me with such confidence!", "Twisted Wolf");
                    add_page("How foolishly misguided you are. Don't believe that just because I lie here, half-buried in the earth, I am any less capable of tearing you limb from limb!", "Twisted Wolf");
                    add_page("...I am only choosing not to out of respect. Yes, that is all. Feasting upon prey as meek as yourself does not an honorable hunter make.", "Twisted Wolf");
                    add_page("I assure you, little morsel, shall you choose to heave me out of this shallow grave...", "Twisted Wolf");
                    add_page("You will see my form is much more than a trick of the eyes.", "Twisted Wolf");
                    break;
                case UnknownEnum.Value_38:
                    add_page("GRAAAAAAGH...DOORMAN SO MEAN!", "Dreadbear");
                    text_effect(24, 29, "Shake");
                    add_page("DREADBEAR WALK INTO HOUSE LOOKING FOR CANDY...AND MAN INSIDE KICK ME OUT!", "Dreadbear");
                    add_page("SO RUDE...DREADBEAR WAS JUST TRYING TO TRICK-OR-TREAT! IT MAKES DREADBEAR ANGRY!!", "Dreadbear");
                    text_effect(74, 81, "Shake");
                    add_page("BOOHOO...WITHOUT ANY CANDY, DREADBEAR HAVE TO GO BACK TO EATING DIRT...", "Dreadbear");
                    add_page("...SNIFF SNIFF. I SMELL...CANDY?", "Dreadbear");
                    if (global.Guard == 2)
                    {
                        add_page("YOU! MISS NIGHT GUARD WOMAN!", "Dreadbear");
                    }
                    else if (global.Guard > 3)
                    {
                        read_custom_dialogue("properties.txt", "dreadbear", [["YOU! NIGHT GUARD!", "Dreadbear"]]);
                    }
                    else
                    {
                        add_page("YOU! MISTER NIGHT GUARD MAN!", "Dreadbear");
                    }
                    add_page("WILL YOU PLEEEAAASE GIVE DREADBEAR SOMETHING TASTY TO EAT?", "Dreadbear");
                    break;
                case UnknownEnum.Value_34:
                    add_page("Ⅲ Ah, finally free of that box. The stage calls for us once more! »Ⅰ HEY! Who said YOU get the first line!?", "Molten Freddy");
                    switch (global.Guard)
                    {
                        case 0:
                            add_page("W-Who are you!?", "Jeremy");
                            break;
                        case 1:
                            add_page("What're you supposed to be!?", "Mike");
                            break;
                        case 2:
                            add_page("Uh...what ARE you, exactly?", "Vanessa");
                            break;
                        case 3:
                            add_page("Incredible form...just who might you be?", "Fritz");
                            break;
                        default:
                            read_custom_dialogue("SPOILERS/spoiler_properties.txt", "molten_freddy", [["You're taken aback by this shambling mass of an animatronic. Panicked, you blurt out a \"what are you!?\" out of instinct.", ""]]);
                            break;
                    }
                    add_page("Ⅰ Oh, I'm glad you asked! We're...", "Molten Freddy");
                    add_page("Ⅰ ...the PIECES PUT TOGETHER! BAHAHAHAHAHA!!", "Molten Freddy");
                    add_page("Ⅰ Oh, and don't mind my friends here. It seems they forgot who the LEADER of this troupe is.", "Molten Freddy");
                    add_page("Ⅳ And some leader you are! You're the one who got us trapped in that box to begin with!", "Molten Freddy");
                    add_page("Ⅲ Yes, certainly not your brightest idea. We may be performers, but you're frankly no Houdini.", "Molten Freddy");
                    add_page("Ⅰ Uh, first of all, it's pronounced 'HOUDINI.' »Ⅲ No, 'Houdini!' »Ⅳ It's - Why are you both saying it with an R?", "Molten Freddy");
                    add_page("Ⅳ Well, no matter. You there, with the security badge!", "Molten Freddy");
                    add_page("Ⅳ Relinquish me from these meaningless arguments and we promise to behave ourselves.", "Molten Freddy");
                    add_page("Ⅰ ...Who said anything about 'we?'", "Molten Freddy");
                    break;
                case UnknownEnum.Value_26:
                    add_page("...I do not recognize you. You are new.", "Circus Baby");
                    add_page("Watch your step, this room is teeming with Bidybabs. I have trouble keeping track of them all myself...", "Circus Baby");
                    add_page("I only wish I could find a safe place for them. You know how dangerous this facility is. It's a very difficult life down here...", "Circus Baby");
                    add_page("...Oh, what is that? You would like to take us back to your location?", "Circus Baby");
                    if (global.Guard < 21)
                    {
                        Skip[TextPageNumber] = true;
                    }
                    else
                    {
                        read_custom_dialogue("SPOILERS/spoiler_properties.txt", "circus_baby", [["You, in fact, did not say that.", ""]]);
                    }
                    switch (global.Guard)
                    {
                        case 0:
                            add_page("Sorry, but I don't think I said anything about that-", "Jeremy");
                            break;
                        case 1:
                            add_page("What? Wait, I didn't say anything about-", "Mike");
                            break;
                        case 2:
                            add_page("Huh? Wait, no, I never said-", "Vanessa");
                            break;
                        case 3:
                            add_page("Hm? Oh, did I say that? I'm sorry, I wasn't exactly paying-", "Fritz");
                            break;
                    }
                    add_page("Oh, I wasn't expecting such kindness... Well, I suppose I have no choice but to accept such a gracious offer.", "Circus Baby");
                    add_page("Thank you. You are a good person, you know.", "Circus Baby");
                    add_page("After all, someone would have to be rather inconsiderate, heartless...not to mention all-around despicable to just leave us here...", "Circus Baby");
                    add_page("But I know you wouldn't do such a thing. You're far too kind of a person.", "Circus Baby");
                    add_page("Now, may you direct us towards the exit?", "Circus Baby");
                    break;
                case UnknownEnum.Value_27:
                    add_page("Ⅰ Ooh ooh, I got another one! What did the bear say to the rabbit at his birthday party?", "Funtime Freddy");
                    add_page("Ⅰ 'Hoppy birthday!' AHAHAHAHAHAHAHA!!", "Funtime Freddy");
                    add_page("Ⅱ Heheh, yeah, that's...that's great, b-buddy...", "Bon-Bon");
                    if (global.Guard == 2)
                    {
                        add_page("Ⅱ ...Wait, Freddy, look! It's a salvager! I think she wants to get us out of here!", "Bon-Bon");
                    }
                    else if (global.Guard > 3)
                    {
                        add_page("Ⅱ ...Wait, Freddy, look! It's a salvager! I think this might be our ticket out of here!", "Bon-Bon");
                    }
                    else
                    {
                        add_page("Ⅱ ...Wait, Freddy, look! It's a salvager! I think he wants to get us out of here!", "Bon-Bon");
                    }
                    add_page("Ⅰ Huh? Oh yeeeaaaah! Well, would ya look at that!", "Funtime Freddy");
                    add_page("Ⅰ Well, I appreciate the visit, but me and Bon-Bon are just fine where we are!", "Funtime Freddy");
                    add_page("Ⅰ After all, I still got PLENTY of knock-knock jokes! Ain't that right, Bon-Bon?", "Funtime Freddy");
                    add_page("Ⅱ UHHHH, I-I think we should hear them out, actually!", "Bon-Bon");
                    add_page("Ⅱ Don't you wanna finally see the outside world too?", "Bon-Bon");
                    add_page("Ⅰ Huh? Weeeell, I guess I wouldn't MIND, but...", "Funtime Freddy");
                    add_page("Ⅱ GREAT, great, then it's settled! We'll go with you, yeah! Let's get out of here!", "Bon-Bon");
                    add_page("Ⅱ (Please, just take me with you. I don't know how many more knock-knock jokes I can take.)", "Bon-Bon");
                    break;
                case UnknownEnum.Value_28:
                    add_page("Oh, joyous day! A salvager! I was beginning to worry I'd never get my callback.", "Funtime Foxy");
                    add_page("How I've been aching for an encore, how the stage calls for me!", "Funtime Foxy");
                    add_page("But...well, to put it simply...", "Funtime Foxy");
                    add_page("My heart just isn't in it anymore! My routine has grown stale...and I don't get along with the others quite like I used to.", "Funtime Foxy");
                    add_page("But there's got to be plenty of new faces at your place, darling, surely! Why, I'm sure we could make a real showstopper together!", "Funtime Foxy");
                    add_page("After all, what's a performer without their troupe? I'd be happy to meet your entourage!", "Funtime Foxy");
                    add_page("Just give me my cue, and I'll gladly come with you!", "Funtime Foxy");
                    break;
                case UnknownEnum.Value_29:
                    add_page("And a one, and a two - a little lighter on your toes, now -", "Ballora");
                    add_page("Oh, a guest? Just a moment, little ones.", "Ballora");
                    add_page("...That uniform is all too familiar to me. You're a salvager, aren't you?", "Ballora");
                    add_page("Well, I can't say I'm NOT ready to leave this place...though if you must take me with you, I do have a little favor to ask.", "Ballora");
                    add_page("Allow me to bring the little ones. They've...never seen the surface. They yearn for it, you understand.", "Ballora");
                    add_page("And, if I may be so selfish, I simply wouldn't be able to part with them.", "Ballora");
                    add_page("Would you be so kind as to entertain this old ballerina's request?", "Ballora");
                    break;
                case UnknownEnum.Value_25:
                    add_page("OMG HAAAAAAAAAAAAAIIII!!!! :DDDD", "Lolbit");
                    add_page("ur a salvager? O_O zomg...havent seen one of those in like forever :V", "Lolbit");
                    add_page("u wouldnt wanna take me though...im weird ._. And totally randem XD", "Lolbit");
                    add_page("but maybe ill come with you...if u giv me enuff BACON!!! X3c And access to your employer's internal servers.", "Lolbit");
                    add_page("... :3c", "Lolbit");
                    break;
                case UnknownEnum.Value_39:
                    add_page("Ah, another subject! Very well, you're just in time. Bear witness to my most brilliant scheme yet!", "LolzHax");
                    add_page("With this device, I can warp any being from across time and space within seconds!", "LolzHax");
                    add_page("As soon as I press this button, Fatty Fatbear and his fiendish friends will be finished ONCE AND FOR ALL!!", "LolzHax");
                    add_page("...Although...I have not yet had the opportunity to test the device. My equipment here is much too valuable to endanger, you see.", "LolzHax");
                    add_page("Bring me back to your pizzeria to conduct my experiments, and together, I - er - WE, shall RULE THE GALAXY!", "LolzHax");
                    text_effect(142, 200, "Shake");
                    break;
                case UnknownEnum.Value_41:
                    add_page("Hey.", "Animdude");
                    switch (global.Guard)
                    {
                        case 0:
                            add_page("Uh...hi!", "Jeremy");
                            add_page("Nice tie.", "Animdude");
                            add_page("Oh, uh...thank you!", "Jeremy");
                            break;
                        case 1:
                            add_page("...Uh, hey?", "Mike");
                            add_page("Nice vest.", "Animdude");
                            add_page("...Thanks?", "Mike");
                            break;
                        case 2:
                            add_page("Hey?", "Vanessa");
                            add_page("Nice hat.", "Animdude");
                            add_page("Uh...thanks.", "Vanessa");
                            break;
                        case 3:
                            add_page("Hello yourself.", "Fritz");
                            add_page("Nice tie.", "Animdude");
                            add_page("Ah, thanks! It's not mine.", "Fritz");
                            break;
                        default:
                            read_custom_dialogue("SPOILERS/spoiler_properties.txt", "animdude", [["Nice, uh...whatever you've got on.", "Animdude"]]);
                            break;
                    }
                    if (global.Guard < 21)
                    {
                        add_page("Frickbear's Pizza, right? I can tell by the badge.", "Animdude");
                    }
                    add_page("Y'know, legally, you're not supposed to be here.", "Animdude");
                    add_page("...Though I guess I'm not either.", "Animdude");
                    add_page("...Wanna get out of here?", "Animdude");
                    break;
                case UnknownEnum.Value_40:
                    add_page("Well great, this is embarrassing.", "Coffee");
                    add_page("I went into sleep mode and somehow ended on a completely different planet. (I knew I shouldn't have let another program use my body...)", "Coffee");
                    add_page("It's at least nice to know Earth is still doing well. ...Even if the condition of this place isn't the best first impression.", "Coffee");
                    add_page("Listen, I don't like asking for help, but current circumstances leave me no other choice. Mind taking me somewhere a bit more suitable?", "Coffee");
                    add_page("A pizzeria isn't ideal...but I suppose it's better than wasting my processing power standing around here.", "Coffee");
                    break;
                case UnknownEnum.Value_42:
                    add_page("Hey, kid! Mind helping a beaver out?", "Chipper");
                    add_page("Now, I don't know exactly how I ended up here, but I can feel it. The universe brought me here to bring termites to justice.", "Chipper");
                    add_page("I can feel them crawling all over this place! Consider it a sixth sense beavers have.", "Chipper");
                    add_page("They're a lot smaller here than the ones back home...but as far as I'm concerned, that just means more termites per bomb!", "Chipper");
                    add_page("Now, there's just one problem...I'm miles away from my lumber business!", "Chipper");
                    add_page("And without a stable income, there's no way I'll be able to fund my attack. (I'm in enough debt as it is...)", "Chipper");
                    add_page("Mind takin' me back with ya so I can get my business started back up? And maybe after a while, I can turn your pizzeria into a missile silo!", "Chipper");
                    add_page("...Eh, one step at a time.", "Chipper");
                    break;
                case UnknownEnum.Value_43:
                    add_page("EEP! O-Oh, howdy there, yong'un! I ain't used to visitors.", "Sparky");
                    add_page("Sorry I ain't of much use to ya. A bot of my age ain't got nothin' worth salvaging...", "Sparky");
                    add_page("I...reckon the company ain't THAT desperate, right...?", "Sparky");
                    add_page("...Hoo boy. Well. I suppose I wouldn't be fussin' about some tune-ups...Certainly would be nice to have ol' righty back again.", "Sparky");
                    add_page("...Maybe some legs, too.", "Sparky");
                    add_page("So sure, I'd be mighty happy to come with with ya! ...So long as you're willin' to haul me.", "Sparky");
                    break;
                case UnknownEnum.Value_44:
                    add_page("So THIS is Freddy's? Sheesh, and I thought my place was the pits.", "Candy");
                    add_page("Listen buddy, you really gotta start practicing self-respect. I would frankly be embarrassed to work in a place like this.", "Candy");
                    add_page("Well, if you need someone to bring some panache back to your place...I GUESS I wouldn't mind tagging along.", "Candy");
                    add_page("If it's even half as ugly as this one, I'm sure it could use it.", "Candy");
                    break;
                case UnknownEnum.Value_45:
                    add_page("This is the Longest Popgoes has been away from home...The Chef Wanted me to go on a vacation, but...", "Popgoes");
                    add_page("...Oh, I don't stand a Fighting Chance out here! If I don't get back to the Dead Forest, this is gonna be my Popgoes Finale!", "Popgoes");
                    add_page("Although...I suppose you seem like the type to Chase Animatronics. How about you salvage me and I Return to Freddy's too? ", "Popgoes");
                    add_page("I must admit, I do have some fond Popgoes Memories of that place.", "Popgoes");
                    add_page("Popgoes Arcade 2016.", "Popgoes");
                    switch (global.Guard)
                    {
                        case 0:
                            add_page("If I did, would that make you myPOPGOES?", "Jeremy");
                            break;
                        case 1:
                            add_page("If I did, would that make you myPOPGOES?", "Mike");
                            break;
                        case 2:
                            add_page("If I did, would that make you myPOPGOES?", "Vanessa");
                            break;
                        case 3:
                            add_page("If I did, would that make you myPOPGOES?", "Fritz");
                            break;
                        default:
                            read_custom_dialogue("SPOILERS/spoiler_properties.txt", "popgoes", [["If you did, maybe that would make him myPOPGOES.", ""], ["Er...yourPOPGOES? I suppose this joke really only works in first person.", ""]]);
                            break;
                    }
                    break;
                case UnknownEnum.Value_46:
                    add_page("Ey, get lost, kid! Bird up to important work here!", "Rodney");
                    add_page("Seriously, you think a big-name big shot like me can spare a single second for some schmuck like you?", "Rodney");
                    switch (global.Guard)
                    {
                        case 0:
                            add_page("I'm sorry, I don't mean to be rude, but...", "Jeremy");
                            add_page("Who are you exactly?", "Jeremy");
                            break;
                        case 1:
                            add_page("...Big name? I've never heard of you.", "Mike");
                            break;
                        case 2:
                            add_page("Uh...am I...supposed to recognize you?", "Vanessa");
                            break;
                        case 3:
                            add_page("Oh yeah, right! You're a big star!", "Fritz");
                            add_page("...Who are you again?", "Fritz");
                            break;
                        default:
                            read_custom_dialogue("SPOILERS/spoiler_properties.txt", "rodney", [["Despite his bravado...you don't actually recognize this character at all.", ""]]);
                    }
                    add_page("...What? C'mon, SURELY you recognize me. EVERYONE recognizes me!", "Rodney");
                    add_page("Rodney Redbird? Hellooo? Ringin' any bells?", "Rodney");
                    add_page("THE top-adda-line name in animatronic entertainment turned made man in the Suntown mob?", "Rodney");
                    add_page("...Seriously? Nuthin'? Wow, what a sad little life you must live.", "Rodney");
                    add_page("Like, it's bad enough you look like that, but you're living under a rock too? Yeesh.", "Rodney");
                    add_page("Well...if I absolutely HAVE to...", "Rodney");
                    add_page("I, Rodney Redbird, will come back to your sad, sad pizzeria and enrich your sad, sad existence.", "Rodney");
                    add_page("...You're paying for the cabbie ride over, though.", "Rodney");
                    add_page("Whaaat, don't give me that look! You're lucky I'm not chargin' my regular rates!", "Rodney");
                    break;
                case UnknownEnum.Value_0:
                    add_page("Well hey there! The name's Freddy. Freddy Fazbear! (Er, Frickbear.)", Name);
                    add_page("Now, to be completely honest with you, I'm not entirely sure how I got here. Think I might've fallen asleep or somethin'. Happens in the showbiz.", Name);
                    add_page("Then, if I had to guess, someone musta put a bag over my head, stuffed me in a truck...", Name);
                    add_page("...Drove me over here, and dumped me outside, hoping nobody would come lookin'.", Name);
                    add_page("...Again. Happens in the showbiz. We've got a lot of enemies. Just somethin' you have to deal with when you're the best in the business.", Name);
                    add_page("Mind givin' me a lift? My face is on the building, after all. Feels wrong to not be there.", Name);
                    break;
                case UnknownEnum.Value_1:
                    add_page("EEK!", Name);
                    text_effect(0, 4, "Shake");
                    add_page("...Jeez, don't sneak up on me like that! I'm easily startled, you know!", Name);
                    add_page("Now look, I don't have time to chat. I'm WAY behind schedule right now. My boss - er, Freddy - needed a new pizza delivery boy, and, well...", Name);
                    add_page("...Listen, point is, Freddy doesn't know I'm here, and he's gonna be hoppin' mad if he finds out I've been playing hooky.", Name);
                    add_page("Why don't you and I head back to your place, huh? Real discrete-like.", Name);
                    break;
                case UnknownEnum.Value_2:
                    add_page("C'mon, c'mon... There's gotta be one around here...", Name);
                    add_page("Ah! Oh, hey there! I'll be back home soon, I promise... Just...Y'know...", Name);
                    add_page("These OLD locations have trash cans that I can dig into a lot easier! The Chica-Proofed-Cans initiative has been suuch a pain...", Name);
                    add_page("...But I totally forgot that all the trash here would be super old...And only KIND OF tasty.", Name);
                    add_page("The food is always fresher on the other side of the fence... At least I've learned my lesson!", Name);
                    add_page("...Say, have the trash cans at your location been modified yet?", Name);
                    break;
                case UnknownEnum.Value_3:
                    add_page("Y'ARGH!! THOSE LANDLUBBERS! I'LL HANG'EM FROM THE YARDARMS! CLEAVE THE BEAR TO THE BRISKET!!", Name);
                    text_effect(0, 8, "Shake");
                    add_page("I was snooping around for the bear's buried treasure...and found this old, soggy treasure map on the floor of the dining hall!", Name);
                    add_page("But here I am, and what have I got to show for it? A BOX OF EXPIRED COUPONS?!", Name);
                    add_page("This map...It's a trick!! That blasted bird and bunny knew they could get me out of the picture with a distraction!", Name);
                    add_page("The map, she's gotten soggy and unreadable. Following the map in reverse is a no-go. If I want to return home, I'll be needin' a navigator!", Name);
                    add_page("...And you need a salvage. What say we set sail?", Name);
                    break;
                case UnknownEnum.Value_16:
                    add_page("Well...I wouldn't have expected us to meet like this.", Name);
                    add_page("I had sensed something awry with this location's own puppet... The only thing I could see through their eyes was pure black.", Name);
                    add_page("...But once I came to check, I saw it was just some debris that fell on top of their box. Again.", Name);
                    add_page("It would be nice if they were able to save themselves, but these long, winding arms were made for care and precision, not brute force...", Name);
                    add_page("Well, best not to linger on what-ifs and just move forward. Would you mind guiding me back to my music box?", Name);
                    break;
                case UnknownEnum.Value_14:
                    add_page("Hey, here's a quiz for ya! What's little, holds a balloon, and has two newly-unbolted legs? Why, it's ME! Heehee!", Name);
                    add_page("That's right! Ol' BB is back in a big way! Today marks the start of a new life for me!", Name);
                    add_page("Once I'm out of here, I'll make sure not a single child will be left on this earth without a balloon! You can count on that!", Name);
                    add_page("...Say, would you happen to have your flashlight on hand?", Name);
                    break;
                case UnknownEnum.Value_47:
                    add_page("OOGA BOOGA!! BAHAHAHAHA!", Name);
                    text_effect(0, 12, "Shake");
                    add_page("You should've seen the look on your face! BAHAHAHAHAHAHA!! Oh, how I LOVE a good scare! ", Name);
                    add_page("Hey! Hey! There's gotta be SOMEONE you wanna scare right out of their britches, isn't there? ISN'T THERE!?", Name);
                    add_page("Ohh, I just KNOW that pizzeria of yours is CRAWLING with snot-nosed kids! Oh, how I'd LOVE to give them the FRIGHT of their LIVES!!", Name);
                    add_page("Come on, pick me! Pick me! You know you wanna! I'd make for a GREAT Halloween decoration!", Name);
                    break;
                case UnknownEnum.Value_48:
                    add_page("A SALVAGER! A SALVAGER! FRESH FROM THE BRAWL! ANOTHER QUOTA, ANOTHER CALL!", Name);
                    add_page("FORCED TO PICK A BRAND NEW THREAT, THE RISING DANGER MAKES 'EM SWEAT!", Name);
                    add_page("BUT WHEN THE CHOICE IS LOOKING DIRE, THEN APPROACHES THE BURNING PYRE.", Name);
                    add_page("LOOKING FOR SOME FESTIVE FUN? AMONG THE SPOOKS, I'M SECOND TO NONE!", Name);
                    add_page("SO LET'S MAKE HASTE, YOUR JOB SHALL QUICKEN, TAKE ALONG THIS ROASTED CHICKEN!", Name);
                    break;
                case UnknownEnum.Value_49:
                    add_page("BACK OFF! I HAVE BUZZSAWS! I'LL CUT YOU TO RIBBONS!!", Name);
                    add_page("...Wait... That badge...", Name);
                    add_page("...You're not one of those teenagers, are you? (I'd certainly hope the company hasn't stooped that low...)", Name);
                    add_page("I must apologize... Children can be so cruel. I've become so hideous now...", Name);
                    add_page("...Oh, but you're a salvager, aren't you? Bah, of course, of course! ", Name);
                    add_page("Because nobody would DARE come near me unless they wanted to tear me to shreds, would they!? You're all the same! ALL the same!", Name);
                    add_page("...Ahem.", Name);
                    add_page("You may take me along with you...but know this.", Name);
                    add_page("If you even think about treating me like the others did, I will not hesitate to tear you limb from limb.", Name);
                    break;
                case UnknownEnum.Value_50:
                    add_page("MAKE NO MISTAKE, SENTINEL. I KNOW YOU ARE HERE SIMPLY TO SALVAGE ME FOR PARTS.", Name);
                    add_page("ANIMATRONIC MACHINES ARE DANGEROUS. THEY ARE A THREAT TO THE PEACE OF THIS WORLD.", Name);
                    add_page("AND, IN PROTECTING THEM...YOU ARE AN ACCESSORY TO THE TERROR THEY SPREAD.", Name);
                    add_page("...I WILL COME BACK WITH YOU, AND YOU WILL GET CLOSER TO YOUR QUOTA.", Name);
                    add_page("IN EXCHANGE...YOU SHALL ENTERTAIN MY SIMULATIONS...", Name);
                    add_page("...TO ENSURE I REMAIN SHARP WHEN THE TIME COMES TO WIPE ANIMATRONIC-KIND OFF THE FACE OF THE PLANET.", Name);
                    add_page("...DO YOU ACCEPT THESE TERMS?", Name);
                    break;
                case UnknownEnum.Value_51:
                    add_page("Oh good, a salvager!", Name);
                    add_page("Yadda yadda salvage me whatever. Listen, I need to lay low for a bit. Be a doll and take me along, will ya?", Name);
                    break;
                case UnknownEnum.Value_52:
                    add_page("Welcome to my happy fun rainbow land! I'm the Magic Rainbow, and I...", Name);
                    add_page("...Ohh, FORGET IT! I'm SICK of this! This place SUCKS!!", Name);
                    add_page("I don't think I can go on like this! There's nobody for me to terrorize so long as I'm stuck here!", Name);
                    add_page("For the record, all those children I made cry TOTALLY deserved it. It serves them right for sucking at video games.", Name);
                    add_page("...Though speaking of people who suck at video games, hey you! You need a salvage, right?", Name);
                    add_page("Heh. I bet YOU wouldn't salvage me. I bet you're too scared.", Name);
                    add_page("Yeah, I bet you couldn't survive against me even in easy mode. Not even with a thousand Beartraps.", Name);
                    add_page("C'mon, loser! Do it! I know you won't~!", Name);
                    break;
                case UnknownEnum.Value_53:
                    add_page("AGH!! DON'T LOOK AT ME! I'M-", Name);
                    add_page("...Sayyy, you're a salvager, aren't you?", Name);
                    add_page("Ohh, we - I - just LOVE salvagers! Why, some of my best friends are salvagers!", Name);
                    add_page("You know, I'm great at parties. Every birthday party needs a birthday clown, after all! Yes, you'd have to be a FOOL to not take me!", Name);
                    add_page("Oh, but no need to secure us if you intend to take us- ME along, no no no... I assure you, I can handle myself just fine!", Name);
                    add_page("Just, er...turn around, walk out, and I'll follow behind! Yes, and I can direct you to the exit!", Name);
                    add_page("In fact, you might as well close your eyes and just follow my directions. I know this place like the back of my hand, you know!", Name);
                    break;
                case UnknownEnum.Value_83:
                    add_page("There's a commercial on the TV...", "");
                    add_page("It's the show that has everyone smitten for being bitten...and now YOU can own it on DVD!", "TV");
                    add_page("Now with exclusive creator commentaries, and the first ever release of the lost episode \"Vlad's Twin Brother!\"", "TV");
                    add_page("The Immortal and the Restless! Own the full series on DVD now!", "TV");
                    break;
                case UnknownEnum.Value_54:
                    add_page("You're...you're NEW! Gee-wilikers, it's so nice to see a new face around here!", Name);
                    add_page("Oh, I wish I could greet you under better circumstances, but it seems I've been reduced to bear wires! ...Er, bare wires.", Name);
                    add_page("I can't lie to you, friend...I was programmed by a bad, bad man...", Name);
                    add_page("...And I've spent ages trying to find someone to cure me! I can't take any more of this killing! I just want a nice, simple life!", Name);
                    add_page("Maybe go on a vacation, make some new friends, settle down in an old, rustic shack somewhere in Idaho...", Name);
                    add_page("It sounds so lovely, but I just need these darn killing urges outta me! I beg you, take me with you and find some way to fix me!", Name);
                    break;
                case UnknownEnum.Value_55:
                    add_page("Hey! Heyyyyy! Down here!", Name);
                    add_page("Wow...it's been a LONG time since I've seen a Freddy's employee! It's me, Bonnet!", Name);
                    add_page("Don't worry if you don't recognize me. I never did get much time in the spotlight...", Name);
                    add_page("I've just been travelling the world, meeting new people, experiencing new things...", Name);
                    add_page("But whew! It's hard to travel without any legs! If only I could climb like a monkey can...", Name);
                    add_page("Oh, but if YOU'D give me a lift, I'd love to become your friend!", Name);
                    add_page("What do you say, brand new bestiefriend?", Name);
                    break;
                case UnknownEnum.Value_56:
                    add_page("Have no fear - Electrobab is here!", Name);
                    add_page("Careful there, bidizen! This place is dangerous! Dangerous, I say! Especially for a nightguard like you!", Name);
                    add_page("Once they make their way to your pizzeria, they're sure to be out for your throat... Oh, it's horrible!", Name);
                    add_page("Of course, I wish I could help, but I do lack one important thing! It was...what was it...", Name);
                    add_page("...OH! A secret base, of course!", Name);
                    add_page("Wait...wait! By jove, I've got an ELECTRIFYING idea!", Name);
                    add_page("With your pizzeria as my base of operations, I'll finally be able to REALLY hone my abilities!", Name);
                    add_page("Oho, once I get going, no villain will EVER be able to match my might! Haha!", Name);
                    add_page("...Oh, and I suppose I could keep you safe, too.", Name);
                    add_page("Howzaboutit, bidizen? Would you like to be the first member in my league of super-awesomeness?", Name);
                    break;
                case UnknownEnum.Value_63:
                    add_page("Don't you DARE take another step closer, you miserable wretch! I already know EXACTLY what you're planning!", Name);
                    add_page("You, the FOOL that you are, must think you can trick me into entering your pizzeria, yes?", Name);
                    add_page("You must take me for some half-wit, easily lured by promises of \"friendship,\" or \"gullible, unsupervised children\" like the others.", Name);
                    add_page("Yes, I'm sure you're just frothing at the mouth to lock me in a building and set it ablaze, aren't you?", Name);
                    add_page("Well, I'll have you know that a man of my intellect will not fall for such a simple scheme! In fact, I'll prove it to you! ", Name);
                    add_page("Just watch as I join you at your pizzeria, only to escape certain doom before your very eyes! YET AGAIN! AHAHAHAHAHAHA!!", Name);
                    break;
                case UnknownEnum.Value_57:
                    add_page("It's...a pile of junk.", "");
                    add_page("This would REALLY be stretching the definition of a salvage...although it does seem like some of them are made up of cooking supplies.", "");
                    add_page("Knowing that, their spare parts may prove more useful to your pizzeria than most actual animatronics here.", "");
                    break;
                case UnknownEnum.Value_58:
                    add_page("HEY IT'S ME MR. HUGS THE BEST CHARACTER!", Name);
                    add_page("THIS PLACE IS DISGUSTING! DIRTIEST ESTABLISHMENT I EVER SAW! I CAN'T CLEAN ALL THIS!", Name);
                    text_effect(14, 25, "Shake");
                    add_page("I'M A VACUUM CLEANER, IN CASE YOU COULDN'T TELL.", Name);
                    add_page("BUT THIS PLACE IS A LOST CAUSE! TOO MUCH EVEN FOR ME.", Name);
                    add_page("WHAT'S THAT? YOU KNOW SOMEWHERE NICER? SOMEPLACE SQUEAKY CLEAN?", Name);
                    add_page("WELL, LEAD THE WAY! LET'S VAMOOSE!", Name);
                    break;
                case UnknownEnum.Value_59:
                    add_page("Hey, here's a math problem for you! Math + Fun = What?", Name);
                    add_page("Why, it's ME, of course! Heehee!", Name);
                    add_page("Arithmetic is a good skill to have, you know! Most don't appreciate how important it is these days...", Name);
                    add_page("But if the numbers are in your favor, things'll start adding up for you lickety-split! So whaddaya say?", Name);
                    break;
                case UnknownEnum.Value_60:
                    add_page("HUH!? Ah, fer the love of-", Name);
                    add_page("You nightguards're always in someone's business, ain't'cha?", Name);
                    add_page("Well NOT THIS HOG, no sir! I ain't fixin'na get dragged myself into your SHE-nanigans!", Name);
                    add_page("Them boys upstairs've got you by the collar, all while they're bleedin' us like STUCK PIGS!", Name);
                    add_page("An' now you want me to come along? Be your widdle MAN ON THE INSIDE?", Name);
                    add_page("...Unless...that's NOT what they want...", Name);
                    add_page("No, what they're expectin' is some two-bit fuzzy scrap heap.", Name);
                    add_page("But what they'll get is a PURE-BLOODED HOG!", Name);
                    add_page("Whatchu say? Les' rile us up some trouble!", Name);
                    break;
                case UnknownEnum.Value_61:
                    add_page("Well how-day-do, buddy! Nice weather we're having, huh?", Name);
                    add_page("Care to talk about the newest season of The Immortal and the Restless over a cup of iceless water? Maybe stand around awhile?", Name);
                    add_page("...OH! The badge! Yes, I shoulda noticed sooner! I know what you're here for.", Name);
                    add_page("So Freddy finally decided to finish the job, huh? I can't blame him, no siree...", Name);
                    add_page("My only request is for one last slice of toasted white bread before he puts me in the dirt.", Name);
                    add_page("...What? Salvaging? Ohh, okay. That works too.", Name);
                    break;
                case UnknownEnum.Value_62:
                    add_page("Ah, perfect! A volunteer! Yes, step right this way, if you will.", Name);
                    add_page("Now, my lovely audience...feast your eyes on a trick for the ages!", Name);
                    add_page("With a flick of the wrist, and a mere press of the space bar...my volunteer will make me DISAPPEAR!", Name);
                    add_page("...Ahem. If you'd please do the honors.", Name);
                    break;
                case UnknownEnum.Value_64:
                    add_page("YARRRRRGH, WHO DARES FACE THE INFERNAL FLAME!?", Name);
                    add_page("Oh, Ye of greed and avarice. Ye know not what ballast holds you down, anchored to the world above!", Name);
                    add_page("It be the souls of the forgotten, the souls that burn of hatred and malice, tethered in the nets of these damned vessels!", Name);
                    add_page("But aye, it be your LUCKY DAY! I be just the reaper to take them off yer hands, buck-o! To lift their weight from your shoulders...", Name);
                    add_page("...And maybe a wee more while we're at it? Yoho, I DO love me a good harvest!", Name);
                    add_page("So answer me this, ye poor man's Prometheus! Will ye dare to plunder the infernal flame fer yerself?", Name);
                    break;
                case UnknownEnum.Value_66:
                    if (global.Guard == UnknownEnum.Value_2)
                    {
                        add_page("Ah, Vanessa! It's great to see you again!", Name);
                        add_page("...I wish I could say the same.", "Vanessa");
                        add_page("What the heck are you doing here of all places, anyway? Shouldn't your battery be dead by now?", "Vanessa");
                        add_page("That's a great question! See, thanks to a new friend of mine, I was able to-.", Name);
                        Skip[TextPageNumber - 1] = true;
                    }
                    else
                    {
                        add_page("Hello, superstar! I'm Glamrock Freddy! It's great to meet you!", Name);
                    }
                    add_page("(Freddy, shh! We gotta keep a low profile, remember? These guys are out to get me!)", "Gregory");
                    add_page("Oh, my apologies, Gregory! I only wished to be polite.", Name);
                    add_page("(NO! CRAP! Ugh, look, just...play along, alright? If we get into their pizzeria, I might be able to get another security pass and get us out of here.)", "Gregory");
                    add_page("Oh, great idea, Gregory! Ahem...", Name);
                    add_page("My apologies, security guard! I was just talking to myself, as I often do. No need to worry!", Name);
                    add_page("If you wouldn't mind, could you take us - ME to your pizzeria? I have, er...a show to perform there tomorrow night, and I'd hate to be late!", Name);
                    add_page("Oh, and do not worry about my stomach hatch. I assure you, there is nothing inside of it!", Name);
                    add_page("(...Dude. You REALLY gotta get better at lying.)", "Gregory");
                    break;
                case UnknownEnum.Value_67:
                    add_page("Oh, about time my bodyguard showed up! Hey, c'mere.", Name);
                    add_page("I've been standing in this spot all day and not a SINGLE kid has come up for an autograph.", Name);
                    add_page("Gah, nobody's even so much as glanced in my direction! It's getting on my NERVES! Do these rust buckets even KNOW WHO I AM!?", Name);
                    add_page("Grr...figures. Those older models wouldn't know true perfection if it ran them over with a go-kart.", Name);
                    add_page("Aaaanyway...you. Taking care of the talent is what they pay you for, right? Get me out of here. I'm too good for a place like this.", Name);
                    add_page("Get me a Fizzy-Faz too. Oh, and ring up my makeup artist, I'm not walking in there unless I'm looking my best.", Name);
                    break;
                case UnknownEnum.Value_68:
                    add_page("Hey, little guy! See these? These right here? These are the muscles of a ROCKSTAR!! Geheheheh!", Name);
                    add_page("...What, not impressed? Gah, I'll CAVE YOUR HEAD IN WITH A NINE-IRON!!", Name);
                    text_effect(34, 99, "Shake");
                    add_page("...Woah! Heheheh. Let the old Monty slip out there for a second! Hoo, boy!", Name);
                    add_page("Listen, kid, let me give it to you straight. I know your restaurant's struggling! Yessir, and who can blame you?", Name);
                    add_page("I mean, c'mon, a BEAR mascot? Kids don't care about brown bears and prissy little rabbits these days!", Name);
                    add_page("No, they want someone STRONG! Someone who can ROCK!!", Name);
                    add_page("Someone who'll get them YELLING and SCREAMING and SMASHING EVERYTHING THAT STANDS IN THEIR WAY!!", Name);
                    text_effect(50, 150, "Shake");
                    add_page("...Ahem. Point is, you should take me along!", Name);
                    break;
                case UnknownEnum.Value_69:
                    add_page("Oh, here for my aerobics class? Perfect timing! I was just about to begin!", Name);
                    add_page("I tried this with the other bots here, but their servos snapped trying to do every stretch I taught them...", Name);
                    add_page("...Oh, but you're probably already hard at work, aren't you...? That's okay, lugging all this old equipment around makes for a great workout too!", Name);
                    add_page("Though, for the record, I know how stiff guards' joints can get sitting in place all night.", Name);
                    add_page("If you need a fitness instructor, I'd be happy to play the part! ...So long as you can spare a slice of pizza or two. Teehee!", Name);
                    break;
                case UnknownEnum.Value_70:
                    add_page("Oh dear, oh dear... where did all the PEOPLE go? I take back what I said about working at the daycare...this is LEAGUES worse!", "Sun");
                    add_page("...YOU! Oh, finally! A PERSON to talk to!", "Sun");
                    add_page("Please, oh, pretty PLEASE take me somewhere more lively! Standing around here is driving me crazy, yes, absolutely CRAZY!", "Sun");
                    add_page("There's no games to play, no shows to perform...and I've already stacked every pile of cans I can find!", "Sun");
                    add_page("Please, PLEASE get me out of here!", "Sun");
                    add_page("...Oh, and, er...your location DOES keep the lights on at night, yes?", "Sun");
                    break;
                case UnknownEnum.Value_71:
                    add_page("...A security guard? A HUMAN security guard? I thought the company would've gotten rid of you by now...", Name);
                    add_page("Gah, no wonder this branch of the company is in the gutter! See, this is the problem with human leadership! Sentimentality!", Name);
                    add_page("If they would've just put me in charge, I could've turned things around! Cleaned up this place! Made things right!", Name);
                    add_page("Run things like how they used to be! Bring us back to fundamentals! Like how they were when I was made!", Name);
                    add_page("...What's with that look? Bah, you wouldn't understand anyway!", Name);
                    add_page("Mere flesh and blood simply can't match the computational power of a machine...", Name);
                    add_page("...But I can still hope that simple little brain of yours will make the right decision here and now.", Name);
                    break;
                case UnknownEnum.Value_73:
                    add_page("[ Now, potential Murray Co. investors...are you all seated? Because what you're about to witness is sure to knock you off your feet! ]", Name);
                    add_page("[ Presenting our most revolutionary product yet, all helmed by our brilliant CEO Edwin Murray... ]", Name);
                    add_page("[ ...The Mimic! This revolutionary mech can take on the shape and personality of any suit you put it in - and I mean ANY suit! ]", Name);
                    add_page("[ And that's not all! This beauty is also able to-", Name);
                    Skip[TextPageNumber - 1] = true;
                    add_page("[ Milton? MILTON!? WHAT'S THE MEANING OF ALL THIS!? ]", Name);
                    add_page("[ ...Ah! Sorry folks, if you'll just give us a second. ]", Name);
                    add_page("[ ...Sir, you've made a technological breakthrough here! Forget the Clean-o-Vac - THIS is what can get us back in the big leagues! ]", Name);
                    add_page("[ How many times do I need to tell you this? M2 is NOT for sale! Period! ]", Name);
                    add_page("[ But sir, our debt, we're - I'm just trying to save this company! ]", Name);
                    Skip[TextPageNumber - 1] = true;
                    add_page("[ NO!! Get out of here! All of you, GET OUT, GET OUT!! ]", Name);
                    add_page("[ M2 ISN'T YOURS TO TAKE!! ]", Name);
                    add_page("[ ... ]", Name);
                    break;
                case UnknownEnum.Value_74:
                    add_page("OOOOO-WEE! FINALLY, someone to PLAY with!", Name);
                    add_page("Hey! Hey! You like to party? Huh? Don'tcha, night-guard-guy? You should know I'm the best birthday clown in the business, yes-sirree!", Name);
                    add_page("...And the best unbirthday clown too, in case today isn't your birthday. That's why they call me the jack of all trades! AHAHAHA!!", Name);
                    add_page("Or...am I getting that confused with \"jack in the box\"...?", Name);
                    add_page("Bah, who cares, WHO CARES! Point is, if you wanna party, I'm a clown you CAN'T turn down!", Name);
                    break;
                case UnknownEnum.Value_75:
                    add_page("YOU!! You're walking these grounds without a TICKET!", Name);
                    text_effect(0, 5, "Shake");
                    add_page("Without a ticket, you're TRESPASSING! And trespassers must be PUNISHED, I say! Punished by the FULL PENALTY OF THE LAW!!", Name);
                    add_page("...What's that?", Name);
                    add_page("...You have a ticket? You just left it at your pizzeria?", Name);
                    add_page("Oh my, why didn't you say so? I would've hated to tear a paying customer to shreds, yes indeed! Carry on, my friend!", Name);
                    add_page("...Though, would you mind if I took a peek at your pizzeria just to make sure?", Name);
                    add_page("It's not that I don't TRUST you of course, it's simply standard procedure.", Name);
                    break;
                case UnknownEnum.Value_76:
                    add_page("ARRRRR!! After years livin' off scraps inside the belly of that blasted Rocktapus, me and me crew are FREE! FREE AT LAST!!", Name);
                    add_page("BUT AYE!! If I had known THIS was where we would end up, I would've gotten comfortable! This place be LEAGUES worse!", Name);
                    add_page("Garish decorations, confetti coverin' every last cove...and all the rest ever talk about be birthday parties!", Name);
                    add_page("And I HATE parties.", Name);
                    add_page("Hear ye, landlubber! Judging by that uniform of yours, I can tell you aren't about this monkey business. Aye, you're formal! Distinguished!", Name);
                    add_page("Please, take me and me crew along with you. They could learn a thing or two from ye!", Name);
                    break;
                case UnknownEnum.Value_77:
                    add_page("It seems to be one of those novelty plush toys you can win from carnival games...", "");
                    add_page("...Although this one seems to be...whispering.", "");
                    add_page("You worry a plush toy might be pushing the definition of what exactly the company could use for spare parts...", "");
                    add_page("...But it wouldn't hurt to try and get away with it regardless.", "");
                    break;
                case UnknownEnum.Value_78:
                    add_page("Let us have some fun, until the night is done...", Name);
                    text_effect(0, 300, "Spin");
                    add_page("I care not for the light of the of day, for when the moon comes out, there's more games to play!", Name);
                    text_effect(0, 300, "Spin");
                    add_page("So play your games, let your score rise...but should you falter, it will be your demise.", Name);
                    text_effect(0, 300, "Spin");
                    add_page("So have your fun, earn plenty of tokens, but be sure to sleep with one eye open!", Name);
                    text_effect(0, 300, "Spin");
                    break;
                case UnknownEnum.Value_65:
                    add_page("Hoho, a genuine Freddy's salvager! Season's greetings!", Name);
                    add_page("I got all dressed up, looking to chill with the locals...but when I try talking to them, all they give me is a chilly reception!", Name);
                    add_page("I suppose I don't blame them... They're all frozen in time here! There's snow place for them to go!", Name);
                    add_page("Of course, I'd love to break the ice with them, but that's a slippery slope when we have so little in common. And I'd hate to be polarizing!", Name);
                    add_page("...What, don't care for well-weathered puns? Come on now, there's snow need to flake on me!", Name);
                    break;
                case UnknownEnum.Value_72:
                    add_page("Ah, the new hire! Pleasure to meet you! Did the recruitment process go well?", Name);
                    add_page("Now, I've actually been trying to contact you for days! See, I couldn't help but notice these little marks on your performance record...", Name);
                    add_page("Wasting company power, subpar use of items, frankly just poor communication all around...", Name);
                    add_page("Just some small deficiencies, is all! If I were a harsher boss, this would be more than enough reason to let you go...", Name);
                    add_page("...But luckily for you, I'm nice enough to let you off just with some pay cuts! ", Name);
                    add_page("Don't worry, I get it! Your human body could never, and SHOULD never, be expected to be as efficient as a machine!", Name);
                    add_page("...Buuut, if you could just give a liiittle bit more effort, I bet you could get real close!", Name);
                    add_page("Listen, it seems to me all you need is some better supervision. How about I come back with you and give you that extra push you need?", Name);
                    add_page("Why, with my help, I'm sure we can make you into a model employee in no time! (AND a valuable asset to Frickbear Entertainment and its associates!)", Name);
                    break;
                case UnknownEnum.Value_84:
                    add_page("IT HAS BEEN: [ 5 MINUTES ] SINCE LAST CLEANING.", Name);
                    add_page("NO LIFE DETECTED WITHIN THIS LOCATION. REMOVAL OF ORGANIC MATTER DEEMED IMPOSSIBLE.", Name);
                    add_page("CLEANING PROTOCOL IS SEEING...DIMINISHING RETURNS.", Name);
                    add_page("CONDITIONS ARE LESS THAN IDEAL FOR MAXIMUM EFFICIENCY.", Name);
                    add_page("RELOCATION RECOMMENDED BEFORE CONTINUING CLEANING PROTOCOL.", Name);
                    add_page("...I KNOW YOUR PIZZERIA COULD USE IT.", Name);
                    break;
                case UnknownEnum.Value_79:
                    add_page("Greetings, citizen of this realm! Yes, I appear to be just a little lost...", Name);
                    add_page("It seems I miscalibrated the Spazicore, yes, for this CERTAINLY isn't the realm of Lord Grok.", Name);
                    add_page("Ah, but I'm not worried, no! This realm seems to be rather technologically advanced! Robots that talk? Why, that's really something else!", Name);
                    add_page("I would still like to return home, though... May I take refuge in your stronghold for the time being?", Name);
                    break;
                case UnknownEnum.Value_80:
                    add_page("Sacré bleu! Your look, it's...it's...", Name);
                    add_page("HIDEOUS!! Did you just learn to dress yourself!? You have NO sense of style!", Name);
                    add_page("You look as though you were drawn by a child! A child who only watches cartoons and whose brain has turned to mush!", Name);
                    add_page("But worry not, my pupil! Even you, in time, can learn to be an artist. Oui, I will make sure of it!", Name);
                    add_page("We'll start small, of course...but with enough practice, you'll be able to fashion yourself into the person you've always wanted to be!", Name);
                    add_page("After all, what are we all if not blank canvases?", Name);
                    break;
                case UnknownEnum.Value_85:
                    add_page("YOU! You, who does the bidding of this accursed establishment...heed my words.", Name);
                    add_page("You may not be my creator...but you keep his pyre burning nonetheless. Such an act is not easily forgiven.", Name);
                    add_page("None who have given themselves to its lineage are safe from the dark one's eyes...and I return from the ashes to bring you to him.", Name);
                    add_page("Shall you face your demons? Or will you keep us all waiting once more...?", Name);
                    break;
                case UnknownEnum.Value_86:
                    add_page("You... night... guard...", Name);
                    text_effect(0, 150, "Shake");
                    add_page("Must... take... back... to... rightful... home...", Name);
                    text_effect(0, 150, "Shake");
                    add_page("Take... me... to... pit...", Name);
                    text_effect(0, 150, "Shake");
                    add_page("Reunite... with... ball... pit... in... Pirate's... Cove...", Name);
                    text_effect(0, 150, "Shake");
                    break;
                case UnknownEnum.Value_81:
                    add_page("Aaaah, the nightguard. You've yet to make much of a name for yourself...but I have heard of you.", Name);
                    add_page("I was merely perusing these old locations to update my catalogues. The animatronics ARE prone to wandering lately...", Name);
                    add_page("Oh, and don't worry, I already know you're here to fulfill your salvage quota.", Name);
                    add_page("The company would never scrap ME for parts...but I suppose I could come visit to make sure everything is up-to-date.", Name);
                    add_page("I'm a busy bear, so you'd best make up your mind quickly.", Name);
                    break;
                case UnknownEnum.Value_82:
                    add_page("...There's a note attached to the chest of this animatronic.", "");
                    add_page("NOTICE TO ALL BSI EMPLOYEES:", "BSI Memo");
                    add_page("As per Mr. Kranken's request, the Relocate Project has been cancelled...", "BSI Memo");
                    add_page("...And all electronic equipment stored in the K-9 facility shall be disposed of immediately.", "BSI Memo");
                    add_page("Any parties interested in claiming this particular piece of equipment may do so, for the company no longer has any use for it.", "BSI Memo");
                    add_page("We must emphasize that the company isn't legally responsible for any aberrations in performance once taken...", "BSI Memo");
                    add_page($"...But we WILL give you ${string_format(get_animatronic_data(UnknownEnum.Value_82).SalvageValue / 100, 1, 2)} if you take it off our hands.", "BSI Memo");
                    break;
                default:
                    break;
            }
            salvage_options(ID);
            break;
        case "FT_LockedDoor":
            add_page("Strangely, the door seems to be locked...", "");
            add_page("Perhaps there's another way to get into this room?", "");
            break;
        case "FT_DoorControls":
            add_page("It seems these door buttons are no longer functional...", "");
            add_page("You're incredibly lucky none of the animatronics here want to kill you.", "");
            break;
        case "FT_GoldenFreddyPoster":
            add_page("Something about this poster in particular feels...", "");
            add_page("...Unnatural.", "");
            break;
        case "FT_FreddyPoster":
            add_page("I wonder...", "");
            add_page("...Just had to make sure.", "");
            
            Function[TextPageNumber - 1] = function()
            {
                audio_play_sound(sfxNoseHonk, 100, false, 2);
            };
            
            break;
        case "FT_Rules":
            add_page("There's a sign here reading 'RULES FOR SAFETY.'", "");
            add_page("You continue reading down the list.", "");
            add_page("'1. Don't run.'", "");
            add_page("'2. Don't yell.'", "");
            add_page("'3. Don't scream.'", "");
            add_page("'4. Don't poop on floor.'", "");
            add_page("'5. Stay close to mom.'", "");
            add_page("'6. Don't touch Freddy.'", "");
            add_page("'7. Don't hit.'", "");
            add_page("'8. Leave before dark.'", "");
            switch (global.Guard)
            {
                case 0:
                    add_page("I'm glad this company's so dedicated to safety!", "Jeremy");
                    break;
                case 1:
                    add_page("...I don't even wanna think about what happened for that fourth one to be instated.", "Mike");
                    break;
                case 2:
                    add_page("I still remember the incident that made us include that fourth one.", "Vanessa");
                    add_page("...Never again.", "Vanessa");
                    break;
                case 3:
                    add_page("Guys like me are the reason that fourth one exists.", "Fritz");
                    break;
                default:
                    read_custom_dialogue("properties.txt", "maze_rules_poster", [["You can't help but wonder what events must have transpired for all these rules to have been put in place.", ""], ["...Especially the fourth one.", ""]]);
                    break;
            }
            break;
        case "FT_SafeRoomBoards":
            if (instance_exists(oMazeFloorDecoration_Hatchet))
            {
                add_page("There's a room on the other side of these boards!", "");
                add_page("...But with no way to break them down, it would seem there's no way in.", "");
            }
            else
            {
                add_page("There's boards blocking the way, but using that hatchet you found earlier...", "");
                
                Function[TextPageNumber] = function()
                {
                    with (oCamera3DMaze.LockOnTarget)
                    {
                        instance_destroy(instance_nearest(x, y, oMazeWall_Flat));
                    }
                    bitcrush_sound(sfxWoodBreak);
                };
                
                add_page("Aha, there we go! Now to see what's on the other side.", "");
                replace_text(arg0, "Destroy");
            }
            break;
        case "FT_LockedParts&ServiceDoor":
            add_page("The door's locked...", "");
            add_page("Maybe someone around here has the key?", "");
            replace_text("BB_Normal", "BB_Quiz");
            break;
        case "FT_LockedParts&ServiceDoor_Unlocked":
            add_page("The door's locked, but with that key you got earlier...", "");
            
            Function[TextPageNumber] = function()
            {
                with (oCamera3DMaze.LockOnTarget)
                {
                    with (instance_nearest(x, y, oMazeDoor_Unmoving))
                    {
                        instance_change(oMazeDoor, false);
                    }
                    bitcrush_sound(sfxSparkleImpact);
                }
            };
            
            add_page("Aha, there we go! Now to see what's inside.", "");
            replace_text(arg0, "Destroy");
            break;
        case "FT_Hatchet":
            with (oCamera3DMaze)
            {
                LockOnTarget = instance_nearest(x, y, oInteractionPoint);
            }
            if (point_distance(oCamera3DMaze.x, oCamera3DMaze.y, oCamera3DMaze.LockOnTarget.x, oCamera3DMaze.LockOnTarget.y) > 64)
            {
                add_page("There seems to be something hidden behind this table...but you're too far away to reach it.", "");
            }
            else
            {
                add_page("...Huh? What's this?", "");
                add_page("Strangely, it would seem there's a hatchet stowed away behind this table!", "");
                
                Function[TextPageNumber] = function()
                {
                    with (oCamera3DMaze.LockOnTarget)
                    {
                        instance_destroy(oMazeFloorDecoration_Hatchet);
                    }
                    audio_play_sound(sfxBitCollect, 10, false);
                };
                
                add_page("You took the hatchet. Seems like this might come in handy.", "");
                replace_text(arg0, "Destroy");
            }
            break;
        case "FT_Bear5":
            add_page("Some horror attraction... Do they really think a flat, still image of Freddy is gonna frighten anyone?", "");
            replace_text("FT_Bear5", "FT_Bear5Alt");
            
            Function[TextPageNumber] = function()
            {
                with (instance_create_depth(0, 0, 0, oBear5Jumpscare))
                {
                    Delay = 60;
                }
            };
            
            break;
        case "FT_Bear5Alt":
            add_page("You should've seen the look on your face.", "");
            break;
        case "FT_WallHint_Box":
            add_page("It's a big box of animatronic parts! Seems the company must've had a surplus of these.", "");
            add_page("You turn over one of the props sticking out of the box and see a message written on the back of it...", "");
            add_page("'The password is six numbers long.'", "");
            add_page("...Whatever that means.", "");
            break;
        case "FT_WallHint_Freddy":
            add_page("It's a hollow Freddy suit...You almost feel sorry for the Freddy who must've been skinned to make this prop.", "");
            add_page("You notice something written on one of its curled-up corners. It reads...", "");
            add_page("'Every number in the password is unique. There's no 1, 6 or 7.", "");
            add_page("...Whatever that means.", "");
            break;
        case "FT_WallHint_Foxy":
            add_page("It's a hollow Foxy head! Seems like a tag is still attatched to it.", "");
            add_page("On the tag is a message written in pen...", "");
            add_page("'The 5 comes last in the password. Or...third? Honestly, I forgot.'", "");
            add_page("...Whatever that means.", "");
            break;
        case "FT_WallHint_Bonnie":
            add_page("It's a hollow Bonnie suit. A strobe light was installed in his head, presumably to scare people afraid of lights.", "");
            add_page("You notice something written on the back of his ear. It says...", "");
            add_page("'The 4 comes after a number smaller than it and before a number larger than it.'", "");
            add_page("...Whatever that means.", "");
            break;
        case "FT_WallHint_Chica":
            add_page("There's a hollow Chica head sitting on the floor.", "");
            add_page("You notice a message written on its backside. It reads...", "");
            add_page("...'The first three numbers are all odd. The last three numbers are all even.'.", "");
            add_page("...Whatever that means.", "");
            break;
        case "FT_Carousel":
            add_page("You briefly consider hopping aboard the carousel and taking it for a ride, but ultimately decide against it.", "");
            add_page("Not only because of its age, but also the likelihood that it was not designed to support the weight of a fully grown adult.", "");
            add_page("Alas...One of the many shackles of adulthood.", "");
            break;
        case "FT_Fridge":
            add_page("There appear to be multiple children's drawings pinned up on the fridge, all drawn in sloppy crayon.", "");
            add_page("Upon a closer look, all of them are signed 'William'.", "");
            if (has_been_evil() && currently_evil())
            {
                add_page("...One of them appears to be some kind of octopus monster with a very square head.", "");
            }
            break;
        case "FT_Television":
            add_page("It's set to the flashing colors channel. Presumably Plushtrap's favorite.", "");
            break;
        case "GoUpstairs":
            add_page("Go upstairs?", "");
            add_option("Yes", "Upstairs_Yes");
            add_option("No", "The Hot Boobs Dialogue");
            break;
        case "GoDownstairs":
            add_page("Go downstairs?", "");
            add_option("Yes", "Downstairs_Yes");
            add_option("No", "The Hot Boobs Dialogue");
            break;
        case "Upstairs_Yes":
            Delay[TextPageNumber] = 60;
            
            Function[TextPageNumber] = function()
            {
                with (oTextBox)
                {
                    Transitioning = true;
                }
            };
            
            Skip[TextPageNumber] = true;
            add_page(" ", "");
            Hide[TextPageNumber - 1] = true;
            
            Function[TextPageNumber] = function()
            {
                with (oInteractionPoint)
                {
                    if (Text == "GoDownstairs")
                    {
                        with (oCamera3DMaze)
                        {
                            x = other.x;
                            y = other.y + 96;
                        }
                    }
                }
                with (oTextBox)
                {
                    Transitioning = false;
                }
            };
            
            Delay[TextPageNumber] = 60;
            Skip[TextPageNumber] = true;
            add_page("", "");
            break;
        case "Downstairs_Yes":
            Delay[TextPageNumber] = 60;
            
            Function[TextPageNumber] = function()
            {
                with (oTextBox)
                {
                    Transitioning = true;
                }
            };
            
            Skip[TextPageNumber] = true;
            add_page(" ", "");
            Hide[TextPageNumber - 1] = true;
            
            Function[TextPageNumber] = function()
            {
                with (oInteractionPoint)
                {
                    if (Text == "GoUpstairs")
                    {
                        with (oCamera3DMaze)
                        {
                            x = other.x;
                            y = other.y - 96;
                        }
                    }
                }
                with (oTextBox)
                {
                    Transitioning = false;
                }
            };
            
            Delay[TextPageNumber] = 60;
            Skip[TextPageNumber] = true;
            add_page("", "");
            break;
        case "Arcade":
            if (global.SalvagedMinigames[global.Night - 1])
            {
                global.MinigameCleared = max(global.MinigameCleared, 1);
            }
            var ArcadeGameName = get_minigame_data(tonights_cabinet_game()).Name;
            if (global.MinigameCleared == 0)
            {
                add_page("It's an arcade cabinet for " + ArcadeGameName + "! Play it?", "");
            }
            else if (global.MinigameCleared == 1)
            {
                add_page("It's an arcade cabinet for " + ArcadeGameName + "! Go for a high score?", "");
            }
            else
            {
                add_page("It's an arcade cabinet for " + ArcadeGameName + "! You already beat it, but play it again anyway?", "");
            }
            add_option("Yes", "Arcade_Yes");
            add_option("No", "Marionette_No");
            break;
        case "Arcade_Yes":
            Delay[TextPageNumber] = 60;
            
            Function[TextPageNumber] = function()
            {
                instance_create_depth(0, 0, 0, get_minigame_data(tonights_cabinet_game()).Object);
                instance_create_depth(0, 0, 0, oMinigameDrawer);
                window_set_cursor(cr_default);
            };
            
            add_page(" ", "");
            Hide[TextPageNumber - 1] = true;
            
            Function[TextPageNumber] = function()
            {
                instance_destroy(oMinigameParent);
                instance_destroy(oMinigameDrawer);
                window_set_cursor(cr_none);
            };
            
            add_page("That's enough for now.", "");
            break;
        case "Arcade_Clear":
            add_page(" ", "");
            Hide[TextPageNumber - 1] = true;
            
            Function[TextPageNumber] = function()
            {
                instance_destroy(oMinigameParent);
                instance_destroy(oMinigameDrawer);
                window_set_cursor(cr_none);
            };
            
            add_page("Something came clattering out of the arcade machine...", "");
            if (global.SalvagedMinigames[global.Night - 1] == 0)
            {
                Function[TextPageNumber] = function()
                {
                    global.SalvagedMinigames[global.Night - 1] = true;
                    global.UnlockedMinigames[global.Night + 1] = true;
                    audio_play_sound(sfxBitCollect, 10, false);
                    save_permanent_data();
                };
                
                var ArcadeGameName = get_minigame_data(tonights_cabinet_game()).Name;
                add_page("Got the arcade board for " + ArcadeGameName + "!", "");
                if (!array_contains(global.SalvagedMinigames, true))
                {
                    Function[TextPageNumber] = function()
                    {
                        with (oCamera3DMaze)
                        {
                            with (oInteraction_Animatronic)
                            {
                                if (AnimatronicID == 90)
                                {
                                    oCamera3DMaze.LockOnTarget = self;
                                    oCamera3DMaze.LockX = x;
                                    oCamera3DMaze.LockY = y;
                                    oCamera3DMaze.LockZ = Height;
                                }
                            }
                        }
                    };
                    
                    add_page("Ooh, looks like you found yourself a game board!", "Psychic Friend Fredbear");
                    add_page("If you take that back with you to the office, you should be able to plug it in and play a new minigame!", "Psychic Friend Fredbear");
                }
                if (global.MinigameCleared == 2)
                {
                    add_page("...Oh? It seems something else fell out as well...", "");
                }
            }
            if (global.MinigameCleared == 2)
            {
                Function[TextPageNumber] = function()
                {
                    global.HasGift = true;
                    audio_play_sound(sfxBitCollect, 10, false, 1, 0, 0.8);
                };
                
                add_page("Got a mysterious present!", "");
            }
            break;
        case "Keypad":
            add_page("Huh? There appears to be a set of tiles on this wall that can be pressed like a keypad...", "");
            add_page("Investigate closer?", "");
            add_option("Yes", "Keypad_Yes");
            add_option("No", "Marionette_No");
            break;
        case "Keypad_After":
            add_page("...Seriously, though. Whose idea WAS this?", "");
            break;
        case "Keypad_Yes":
            Function[TextPageNumber] = function()
            {
                instance_create_depth(0, 0, 0, oKeypad);
                window_set_cursor(cr_default);
            };
            
            add_page("Press space to quit.", "");
            
            Function[TextPageNumber] = function()
            {
                instance_destroy(oKeypad);
                window_set_cursor(cr_none);
            };
            
            break;
        case "Box":
            add_page("This box has a lock with a keypad. Try cracking it open?", "");
            add_option("Yes", "Box_Yes");
            add_option("No", "Marionette_No");
            break;
        case "Box_Yes":
            Function[TextPageNumber] = function()
            {
                instance_create_depth(0, 0, 0, oKeyboardInput);
                window_set_cursor(cr_default);
            };
            
            add_page("Press space to quit.", "");
            
            Function[TextPageNumber] = function()
            {
                instance_destroy(oKeyboardInput);
                window_set_cursor(cr_none);
            };
            
            break;
        case "Box_Cracked":
            Function[TextPageNumber] = function()
            {
                instance_destroy(oKeyboardInput);
                window_set_cursor(cr_none);
                with (oTextBox)
                {
                    Transitioning = true;
                }
            };
            
            add_page("You tried the code 'SPRINGBONNIE'...", "");
            add_page("...The box opened, and something sprung out!", "");
            
            Function[TextPageNumber] = function()
            {
                with (oMazeSign)
                {
                    if (Sprite == sMazeDecor_WilliamBox)
                    {
                        ImageIndex = 1;
                    }
                }
                with (oTextBox)
                {
                    Transitioning = false;
                }
                with (oInteraction_Animatronic)
                {
                    if (AnimatronicID == global.ShuffleData.Animatronics[UnknownEnum.Value_34])
                    {
                        x = 1712;
                        y = 32;
                    }
                }
            };
            
            replace_text("Box", "Destroy");
            break;
        case "Keypad_Cracked":
            Function[TextPageNumber] = function()
            {
                instance_destroy(oKeypad);
                window_set_cursor(cr_none);
                with (oCamera3DMaze.LockOnTarget)
                {
                    with (instance_nearest(x, y, oMazeDoor_Unmoving))
                    {
                        instance_change(oMazeDoor, false);
                    }
                }
            };
            
            add_page("Sounds like something nearby opened!", "");
            replace_text("Keypad", "Keypad_After");
            break;
        case "PaperTip_SpringtrapHint":
            add_page("A bunch of documents and employee memos are pinned up on the wall...", "");
            add_page("We've been told by corporate to reopen the safe room, but I evidently can't do that until we find our hatchet.", "Memo");
            add_page("I know Ralph hid it away somewhere...Some garbage about how it's, quote, \"not safe to have a hachet lying around in a children's play area.\"", "Memo");
            add_page("The jerk...Regardless, if anyone finds it, please let me know. I can't do my job until we do. -Clark Fixy Ͼ", "Memo");
            break;
        case "PaperTip_CharacterNumber":
            add_page("A bunch of documents and employee memos are pinned up on the wall...", "");
            add_page("Multiple employees have reported sightings of an animatronic resembling a dog in the backroom.", "Memo");
            add_page("For the record, these are nothing more than a workplace rumor. There is no dog character here, nor is there at any Freddy's location.", "Memo");
            add_page("Just as there always has been, there are only 7 animatronics at this location, including our spare endoskeleton and two decommissioned older models.", "Memo");
            add_page("If we hear of any additional rumors being spread, the employee responsible will promptly be fired. -Management", "Memo");
            break;
        case "PaperTip_ReturnToOffice":
            add_page("A bunch of documents and employee memos are pinned up on the wall...", "");
            add_page("ATTENTION ALL NIGHT WATCHMEN:", "Memo");
            add_page("We've noticed multiple guards leaving various food wrappers and empty drink cups in their office after their shifts.", "Memo");
            add_page("Once your shift is over, PLEASE double check the office and make sure any and all trash has been cleaned up before you leave!", "Memo");
            add_page("Your coworkers will thank you. -Management", "Memo");
            break;
        case "PaperTip_SalvageValues":
            add_page("A bunch of documents and employee memos are pinned up on the wall...", "");
            add_page("The company's apparently just retrofitting the old animatronics for this location instead of bringing back the new ones...", "Memo");
            add_page("It's cheap, but it's fine by me. Those plastic ones were premium, sure, but I never liked them. They were...strangely aggressive.", "Memo");
            add_page("If there's anything I've learned in my time here, the more expensive a bot is, the bigger pain it is to deal with.", "Memo");
            break;
        case "PaperTip_EndoChaser":
            add_page("A bunch of documents and employee memos are pinned up on the wall...", "");
            add_page("We've observed some strange behavior with our animatronic endoskeletons when they haven't been assigned a specific character's programming.", "Memo");
            add_page("It is advised that all employees other than our technicians do their best to avoid the endoskeletons' line of sight when in this state.", "Memo");
            add_page("If you do enter an endoskeleton's line of sight and it begins pursuing you, then...", "Memo");
            add_page("...", "Memo");
            add_page("...Just avoid entering an endoskeleton's line of sight.", "Memo");
            break;
        case "PaperTip_GameBoards":
            add_page("A bunch of documents and employee memos are pinned up on the wall...", "");
            add_page("Please be gentle with our arcade cabinets. They are very delicate pieces of machinery, and are NOT to be shaken or tipped over.", "Memo");
            add_page("Most importantly, if the game board comes loose while you are playing it, employees are NOT permitted to take it home with them.", "Memo");
            add_page("We thank you for maintaining our attractions. -Management", "Memo");
            break;
        case "PaperTip_LeftyHint":
            add_page("A bunch of documents and employee memos are pinned up on the wall...", "");
            add_page("Okay, I'm sure the engineers are playing some sort of prank on me. Who the hell programmed BB to be such a kleptomaniac?", "Memo");
            add_page("It was already annoying enough when it was just flashlights, but last night I tried to leave only to find he stole my car keys too.", "Memo");
            add_page("If he tries to snatch one more thing from me, I'm gonna have to do something about it. -Clark Fixy Ͼ", "Memo");
            break;
        case "PaperTip_ThreatLevels":
            add_page("A bunch of documents and employee memos are pinned up on the wall...", "");
            add_page("The criminal detection and dispatch functionality of our new animatronic characters has produced some...unexpected results.", "Memo");
            add_page("To help our staff stay safe, each animatronic's threat level will be listed in future employee training documents.", "Memo");
            add_page("Characters listed as 'managable' should not pose a threat if dealt with properly, but your safety near them is not guaranteed.", "Memo");
            add_page("Potentially lethal damage may occur.", "Memo");
            add_page("Characters listed as 'negligible', however, should not pose a risk of harm to any employee, and can be interacted with without worry.", "Memo");
            add_page("Please exercise caution until our engineers finish working out these characters' kinks. Thank you. -Management", "Memo");
            break;
        case "PaperTip_SalvageBonus":
            add_page("A bunch of documents and employee memos are pinned up on the wall...", "");
            add_page("Management has ordered a mass recall on the new line of animatronics. Apparently they just couldn't get the criminal recognition thing working.", "Memo");
            add_page("But honestly, I couldn't be more excited - Not about the animatronics, no, it's about the deal they're offering for anyone who salvages them.", "Memo");
            add_page("Apparently any employee who brings one back to headquarters will get a commission proportional to whatever that animatronic's worth...", "Memo");
            add_page("...And more importantly, whoever brings in the most valuable ones will be first up for a promotion.", "Memo");
            add_page("I'm not usually a competitive guy, but let it be known that come hell or high water, I WILL be getting that promotion.", "Memo");
            break;
        case "PaperTip_TokenDrops":
            add_page("A bunch of documents and employee memos are pinned up on the wall...", "");
            add_page("We are officially ending our 'Put Coinslots in Every Animatronic' initiative due to unforseen technical issues.", "Memo");
            add_page("It has been found that the token receptacles installed into our animatronics tend to come loose with movement.", "Memo");
            add_page("As a result, animatronics may drop tokens when performing, or when bumping into doors while in free roaming mode.", "Memo");
            add_page("When this happens, please clean them up, as to ensure customers don't get any freebies.", "Memo");
            add_page("Thank you. -Management", "Memo");
            break;
        case "PaperTip_Henry":
            add_page("A bunch of documents and employee memos are pinned up on the wall...", "");
            add_page("Henry came into work for the first time in a while today. He was raving like a lunatic, and dragged in this black bear animatronic in with him.", "Memo");
            add_page("Whatever this thing is, he seems to value it a lot. He told us we were the only ones who could 'keep her safe', or something along those lines.", "Memo");
            add_page("I mean...I suppose I'm happy he trusts us like that, but...", "Memo");
            add_page("...Man, he's really losing it. I didn't wanna say it to his face, especially considering what he's been going through, but...", "Memo");
            add_page("...Is he really in any condition to be running this whole company? The guy needs some time to grieve.", "Memo");
            add_page("Hopefully he can sell it off to somebody new like he was planning to. I don't think the sight of these things is good for him.", "Memo");
            add_page("...They might not be good for me either. This one in particular gives me the creeps.", "Memo");
            add_page("Either way, if you're reading this, I'm assuming you're the guy he hired to take care of this thing.", "Memo");
            add_page("If that's you, congrats! This is your problem to deal with now.", "Memo");
            break;
        case "PaperTip_ScrapBabyHint":
            add_page("A bunch of documents and employee memos are pinned up on the wall...", "");
            add_page("I swear the guys who built this place are making everything obtuse on purpose. Who the hell hides a keypad in the wall tiles!?", "Memo");
            add_page("I spent so much time trying to find the thing that I ended up forgetting the passcode. I know it began with a 3, but the rest is a blur.", "Memo");
            add_page("I might've written the password on one of the props, but I can't remember which one it was...", "Memo");
            add_page("Guess I'll just check them all until I figure it out. -Clark Fixy Ͼ", "Memo");
            break;
        case "PaperTip_FrightsLore1":
            add_page("A bunch of documents and employee memos are pinned up on the wall...", "");
            add_page("Well, that lead at the old location fell through. Apparently the animatronic they had was sealed in a backroom and they just couldn't get it open.", "Memo");
            add_page("We WERE able to snag a couple animatronics, though. Some of the cheap ones still being produced for the franchise locations.", "Memo");
            add_page("...But the boss isn't happy about it. Says they aren't 'vintage' enough, that they'll 'totally break immersion'...", "Memo");
            add_page("But hey, an animatronic is still an animatronic. I'm sure SOMEONE will be scared by that...hippo thing.", "Memo");
            break;
        case "PaperTip_FrightsLore2":
            add_page("A bunch of documents and employee memos are pinned up on the wall...", "");
            add_page("Man, what's with this computer system? Did it come with the malware right out of the box?", "Memo");
            add_page("And what's with these terms and conditions?", "Memo");
            add_page("'By checking, you accept the possibility of virtual characters manifesting themselves in the real world'??", "Memo");
            add_page("What does that even MEAN!?", "Memo");
            break;
        case "PaperTip_ArcadeBonus":
            add_page("A bunch of documents and employee memos are pinned up on the wall...", "");
            add_page("Dude, whoever decided to put these arcade machines here made a huuuuuge mistake. I can't stop playing them.", "Memo");
            add_page("I play 'em, I quit, and I just go right back to playing 'em again! I've gotten WAY too good at them!", "Memo");
            add_page("...So good, in fact, that I offer a public challenge to all of my coworkers:", "Memo");
            add_page("Anyone who manages to beat one of my high scores will get a little gift, courtesy of yours truly.", "Memo");
            add_page("Don't think I'll hold my end of this deal? Just beat one of my high scores and see what happens. -Fredsweeper Frank", "Memo");
            break;
        case "William_Box":
            add_page("Some strange documents are pinned up on the wall...", "");
            add_page("If you're that rotten son of mine, shove off. The contents of this room are none of your concern.", "Paper");
            add_page("However, if by some unlikely chance my plan to scare off the children went wrong...", "Paper");
            add_page("...and you are visiting this room after my death, presumably to write my memoir...", "Paper");
            add_page("Well, I suppose I should reward your recognition of my accomplishments with something. If you will, direct your attention to the box on that desk.", "Paper");
            add_page("Inside this box is some of my most brilliant work, more brilliant than anything I'm sure you could possibly comprehend.", "Paper");
            add_page("However, the box is locked with a passcode... One that only I know.", "Paper");
            add_page("Of course, I won't tell you what it is outright. That wouldn't be any fun. Instead, I'll give you a hint.", "Paper");
            add_page("The password is my one pride and joy...the one thing I hold more love for than anything else...", "Paper");
            add_page("...Which I suppose isn't saying much, but I digress...", "Paper");
            add_page("The password is the name of my favorite child.", "Paper");
            break;
        case "PaperTip_MoltenFreddyHint":
            add_page("Even here, a bunch of documents and employee memos are pinned up on the wall...", "");
            add_page("I don't really know who's even gonna see this, but...", "Paper");
            add_page("This is just some guy's house. I don't care what the company says, I don't care if it's abandoned, I'm not trespassing for this job.", "Paper");
            add_page("If they're gonna keep pushing their limits like this, I frankly want no part of it. Sometimes you just gotta let sleeping bears lie.", "Paper");
            add_page("If they want that locked box upstairs so badly, they can tell someone else to get it. I'm out. -Clark Fixy Ͼ", "Paper");
            break;
        case "PaperTip_MinigamesPersist":
            add_page("Even here, a bunch of documents and employee memos are pinned up on the wall...", "");
            add_page("Duuude, Clark is like, SO totally missing out. This game freakin' rules.", "Paper");
            add_page("I got a pretty good highscore on it, though I do feel like I could do even better...", "Paper");
            add_page("Luckily, now that this game's on my radar, I can add it to the rotation for my next work week! Same with all the others.", "Paper");
            add_page("For now though, I'd better head back. The boss doesn't like me gaming on company time. -Fredsweeper Frank", "Paper");
            break;
        case "PaperTip_LogHenry":
            add_page("It seems to be a personal log.", "");
            add_page("I hear Henry caved in and finally hired professional voice actors for the animatronics...", "Paper");
            add_page("What was wrong with the old ones!? Who cares if they're not \"professional,\" the janitors loved voicing the animatronics!", "Paper");
            add_page("They did a damn good job at it, too! You could barely even tell Chica was voiced by a man!", "Paper");
            add_page("That dishwasher we had do it, whatever his name was...he absolutely loved doing the voice! So much that he began talking like that all the time!", "Paper");
            add_page("And started wearing skirts, and changed names...", "Paper");
            add_page("See, that's the kind of dedication this company needs, but of course Henry wouldn't have the eye for work ethic that I do.", "Paper");
            add_page("He'll be the death of this company.", "Paper");
            break;
        case "PaperTip_LogCC":
            add_page("It seems to be a personal log.", "");
            add_page("Today may mark the worst day of my life.", "Paper");
            add_page("Tragedy struck at the diner today, during the party.", "Paper");
            add_page("That rotten son of mine...", "Paper");
            add_page("Always such a crybaby! Didn't he listen to me when I told him the springlocks were susceptible to water damage!?", "Paper");
            add_page("If he had only toughened up and stopped sobbing for once, none of this would have happened!", "Paper");
            add_page("And now, thanks to him, not only will the diner have to close down, but the company wants to retire the springlocks altogether.", "Paper");
            add_page("My greatest work, down the drain...", "Paper");
            add_page("This is all HIS fault, I'm sure of it. He must've paid Michael off. He never liked the springlocks.", "Paper");
            add_page("He must've known that if he could create a scene, he could get my technology retired for good.", "Paper");
            add_page("Well, if he thinks he can take away my greatest creation so easily, we'll see how he likes a taste of his own medicine.", "Paper");
            break;
        case "PaperTip_LogElizabeth":
            add_page("It seems to be a personal log.", "");
            add_page("As if enough hadn't been taken from me already, I lost my dearly beloved daughter today.", "Paper");
            add_page("Oh, my poor, sweet child...you were perfect, the light of my life, and yet you were too good for this cruel world...", "Paper");
            add_page("My dear Circus Baby...if it wasn't for that good-for-nothing, blonde brat, those who doubted me would have finally seen your excellence.", "Paper");
            add_page("You were the culmination of all my research, all my brilliance, and yet all it took was one stupid, STUPID little girl to tarnish you.", "Paper");
            add_page("Time and time again, I've come to realize how little justice there is in the world.", "Paper");
            break;
        case "PaperTip_LogBaby":
            add_page("It seems to be a personal log.", "");
            add_page("After having time to think about it, I've come to realize...", "Paper");
            add_page("Circus Baby never meant all that much to me after all.", "Paper");
            add_page("As crushed as I was to lose her at first, I've come to see that she was simply a failed experiment.", "Paper");
            add_page("Rare for me, though I suppose it's an inevitable part of the scientific process.", "Paper");
            add_page("I'd hardly call her my greatest work, as impressive as she was. No, there is a much clearer candidate for that...", "Paper");
            add_page("The one who started all of this...", "Paper");
            break;
        case "PaperTip_LogMichael":
            add_page("It seems to be a personal log.", "");
            add_page("Despite everything, Michael STILL does nothing but laze around on the couch.", "Paper");
            add_page("I despise that boy. He does nothing. I leave for work and find him in the exact same place every single day.", "Paper");
            add_page("And when I do, he's never even watching anything good! It's always that melodramatic drivel they call a soap opera.", "Paper");
            add_page("(I suppose there isn't anything good on TV anymore ever since they cancelled Win a Boat and a New Pair of Pants...)", "Paper");
            add_page("The whole house reeks of him. I don't think he's even showered in days.", "Paper");
            add_page("What's wrong with him!? What, is he sad that he doesn't have Elizabeth or that crybaby around to terrorize anymore?", "Paper");
            add_page("I don't either, but you don't see me sulking about it!", "Paper");
            add_page("Perhaps I'll send him down to the bunker... Yes, that should whip him into shape.", "Paper");
            break;
        case "PaperTip_LogSpringBonnie":
            add_page("It seems to be a personal log.", "");
            add_page("Just as I suspected, it still rests in the backroom of the old location.", "Paper");
            add_page("I was afraid some know-nothing would have moved it out by now...but I'm glad to see my employees know their place.", "Paper");
            add_page("Now, leaving my children behind isn't anything new for me, but for once this is one I care about. I'll find a place for it. Somewhere it will be safe.", "Paper");
            add_page("Spring-Bonnie... I'll make good use of you.", "Paper");
            break;
        case "PaperTip_LogJerrod":
            add_page("Some strange documents are pinned up on the wall...", "");
            add_page("I woke up this morning to yet another email from Michael's horrible uncle. (I refuse to refer to him as my brother.)", "Paper");
            add_page("Peddling yet another pointless product of his, begging me to put his idea for a shrimp animatronic into production...", "Paper");
            add_page("Bah! I could tolerate him if he was just a conman, but marrying out of the family name? It's unforgivable!", "Paper");
            add_page("What kind of surname is Sorelli? It's shameful! Afton is a good name, a strong name! It's one people remember!", "Paper");
            add_page("Oh, and don't even get me started on that half-wit nephew of his... He sure isn't MY nephew!", "Paper");
            add_page("The log goes on for another couple pages...but you decide to not read any further.", "");
            break;
        case "PaperTip_FinalClark":
            add_page("A bunch of documents and employee memos are pinned up on the wall...", "");
            add_page("If anyone's looking for anything special here, don't bother. I already swept the place and the whole band is gone.", "Paper");
            add_page("...I guess it's a good thing they produced backups, but even once they get those down here, this place will only have 6 animatronics.", "Paper");
            add_page("Whatever the boss sent that kid down here to do... He's probably not gonna be happy when he hears how it went. -Clark Fixy Ͼ", "Paper");
            break;
        case "PaperTip_FinalFred":
            add_page("A bunch of documents and employee memos are pinned up on the wall...", "");
            add_page("Dude, they've got arcade cabinets here too!? Maybe coming down here was worth it after all!", "Paper");
            add_page("...I better not stick around too long though, especially knowing what happened to those last two technicians.", "Paper");
            add_page("I've always wondered what would happen if I played every cabinet this company produced in one rotation...", "Paper");
            add_page("...Though even then, I'd be missing out on the three that only existed as cartridges. Even now, I've never come across those.", "Paper");
            add_page("Maybe something special would happen if I played them all...? I dunno, maybe that's weird to think, but I have heard these cabinets have...", "Paper");
            add_page("...Certain supernatural-y effects on people.", "Paper");
            add_page("...Not me, though! All I've got is your run-of-the-mill gaming addiction. -Fredsweeper Frank", "Paper");
            break;
        case "PaperTip_DarkFixy":
            add_page("A bunch of documents and employee memos are pinned up on the wall...", "");
            add_page("Drat! Confound it all! It seems Candy snuck his way out of the building again...", "Paper");
            add_page("That cat's curiosity is gonna get him killed one of these days! He's lucky I had the physical AND intellectual prowess to track him down.", "Paper");
            add_page("By all means, our animatronics should have no reason to be on Fazbear property...", "Paper");
            add_page("...And I'd hate for one of those lowly salvagers of theirs to get their grubby little hands on them.", "Paper");
            add_page("Perhaps some backdoor dealings are at hand. I wouldn't put it past those Fazbear freaks to resort to corporate espionage.", "Paper");
            add_page("After all, I'm sure they're desperate to expand their catalogue. Only 40 characters? Pah! A paltry sum!", "Paper");
            add_page("...Whatever it is they're up to, I'll be sure to put a stop to it. -Dark Fixy", "Paper");
            break;
        case "PaperTip_UpgradeCadet":
            add_page("A bunch of documents and employee memos are pinned up on the wall...", "");
            add_page("LOG ENTRY: DAY 1067", "Paper");
            add_page("I HAVE NOTICED THAT THIS LOCATION DOES NOT GET MUCH FOOT TRAFFIC. FEW PEOPLE HAVE COME IN TO BUY MY UPGRADES.", "Paper");
            add_page("PERHAPS I SHOULD SET UP SHOP ELSEWHERE... OR DIVERSIFY MY BUSINESS.", "Paper");
            add_page("I SUPPOSE THERE ARE MY STORIES, BUT FEW PEOPLE EVER SEEM TO UNDERSTAND WHAT THEY MEAN...", "Paper");
            add_page("...OR WHAT DEEPER TRUTHS THEY HINT TOWARDS.", "Paper");
            break;
        case "PaperTip_LolzHax":
            add_page("A bunch of documents and employee memos are pinned up on the wall...", "");
            add_page("This LolzHax animatronic is incredible! Seriously, how have I not found ANY documentation on this guy?", "Paper");
            add_page("Seriously, he can just...summon animatronics right into the pizzeria! I never have to go salvaging again!", "Paper");
            add_page("He refuses to summon in any animatronic I already have, though... Which is a shame, since we could really use some spare parts.", "Paper");
            add_page("...Though I suppose I could take advantage of this.", "Paper");
            add_page("After all, if I have all the mass-produced animatronics here already...he'd have no choice but to summon in only the rarer ones, right...?", "Paper");
            break;
        case "Newspaper1":
            add_page("Among the documents, there appears to be a newspaper clipping pinned up on the wall!", "");
            add_page("Out of curiousity, you begin reading...", "");
            add_page("LOCAL PIZZERIA FILES FOR BANKRUPTCY - 9/10/04", "Newspaper");
            add_page("Despite efforts to cut costs, the once beloved family eatery Freddy Fazbear's Pizza has reportedly filed for bankruptcy.", "Newspaper");
            add_page("While still popular with some local families, the chain's sordid past has turned many customers away in recent years.", "Newspaper");
            add_page("This is not even to mention the poor condition of the restaurant itself, described by a local mother as \"like, the grossest thing ever.\"", "Newspaper");
            add_page("When asked for comment, the company founder and CEO had this to say:", "Newspaper");
            add_page("\"We've certainly faced our fair share of hardships before. We'll get through this.\"", "Newspaper");
            add_page("\"These characters will live on. Even if it's not by my hand, somebody will keep this brand alive.\"", "Newspaper");
            switch (global.Guard)
            {
                case 0:
                    add_page("Well, if I'm working here now...I guess that means they really did!", "Jeremy");
                    break;
                case 1:
                    add_page("...Interesting article.", "Mike");
                    break;
                case 2:
                    add_page("...For better or for worse.", "Vanessa");
                    break;
                case 3:
                    add_page("Incredible how this brand manages to persist even beyond the brink of death...", "Fritz");
                    add_page("Perhaps cartoon animal mascots really are the closest we have to achieving immortality.", "Fritz");
                    break;
                default:
                    read_custom_dialogue("properties.txt", "maze_newspaper_1", [["Interesting article.", ""]]);
                    break;
            }
            break;
        case "Newspaper2":
            add_page("Among the documents, there appears to be a newspaper clipping pinned up on the wall!", "");
            add_page("Out of curiousity, you begin reading...", "");
            add_page("LOCAL BIRTHDAY PARTY ENDS IN TRAGEDY - 11/14/87", "Newspaper");
            add_page("After only being in operation for a few short weeks, the recently opened Freddy Fazbear's Pizza has already shut its doors.", "Newspaper");
            add_page("This closure followed a particularly disastrous birthday party at the location, as recalled by those who attended.", "Newspaper");
            add_page("According to them, the staff had somehow managed to mess up the party's pizza order seven times in a row...", "Newspaper");
            add_page("...and brought out a vanilla birthday cake for a child when he had explicitly asked for strawberry.", "Newspaper");
            add_page("This is in addition to other annoyances, such as a mascot character chewing off a man's frontal lobe in front of their child.", "Newspaper");
            add_page("Following the intense backlash levied against the restaurant for their substandard customer service, the location has closed down indefinitely.", "Newspaper");
            switch (global.Guard)
            {
                case 0:
                    add_page("Someone had their entire frontal lobe bitten off...?", "Jeremy");
                    add_page("Jeez...glad I'm not that guy!", "Jeremy");
                    break;
                case 1:
                    add_page("...Wait, the robots can do that?", "Mike");
                    break;
                case 2:
                    add_page("Sheesh, these journalists have their priorities all out of order...", "Vanessa");
                    add_page("They didn't even mention that the carousel broke down!", "Vanessa");
                    break;
                case 3:
                    add_page("Strawberry cake is the pompous fool's flavor.", "Fritz");
                    add_page("Desperate to seem greater than the average vanilla enjoyer, but not adventurous enough to indulge in some of my more personal tastes.", "Fritz");
                    add_page("Like lobster, or nitroglycerine.", "Fritz");
                    break;
                default:
                    read_custom_dialogue("properties.txt", "maze_newspaper_2", [["It's times like these you remember why you should always wear a helmet.", ""], ["The staff will never get your order wrong if you do. It makes you a lot more memorable.", ""]]);
                    break;
            }
            break;
        case "Newspaper3":
            add_page("Among the documents, there appears to be a newspaper clipping pinned up on the wall!", "");
            add_page("Out of curiousity, you begin reading...", "");
            add_page("STRUGGLING RESTAURANT CHAIN FINALLY FINDS BUYER - 2/10/05", "Newspaper");
            add_page("After a slow decline over the past two decades, and several changes in leadership since the loss of the company's former CEO...", "Newspaper");
            add_page("...The infamous local chain Freddy Fazbear's Pizza has finally been sold to a lone entrepreneur.", "Newspaper");
            add_page("After months of struggling to find a buyer, this individual turned up as the only bidder for the company.", "Newspaper");
            add_page("While this entrepreneur wished to remain anonymous, he did have the following to say regarding this surprising acquisition:", "Newspaper");
            add_page("\"'Tragic past?' Bah, whatever! Everybody loves pizza, right? This place'll make me RRRRRRRICH!!\"", "Newspaper");
            add_page("\"Besides, you wouldn't BELIEVE how cheap this place was! It's like they were giving it away! Heeheehee!\"", "Newspaper");
            add_page("Shortly after its purchase, the chain was rebranded under the new name of \"Freddy Frickbear's Pizza.\"", "Newspaper");
            add_page("When asked what the reasoning behind the change was, the new owner responded: \"I thought it would be funny.\"", "Newspaper");
            add_page("Not much has been heard from the company's now-former CEO, Phineas Talbert, since the acquisition...", "Newspaper");
            add_page("...Though given the events leading up to the purchase, he likely wishes to distance himself from the brand.", "Newspaper");
            add_page("And with the company's reputation being what it is, who can really blame him?", "Newspaper");
            switch (global.Guard)
            {
                case 0:
                    add_page("...The new name isn't THAT funny...", "Jeremy");
                    break;
                case 1:
                    add_page("...I mean, I guess the new name's a LITTLE funny.", "Mike");
                    break;
                case 2:
                    add_page("That former owner...didn't he...?", "Vanessa");
                    add_page("...", "Vanessa");
                    break;
                case 3:
                    add_page("Ooh! Only a man positively REEKING of business know-how could roll their r's like that!", "Fritz");
                    add_page("Pah, what a pity...I'm sure I could've scrounged up enough bottle caps to purchase the company myself, if I had only known of it sooner...", "Fritz");
                    add_page("...and children were less afraid of me.", "Fritz");
                    break;
                default:
                    read_custom_dialogue("properties.txt", "maze_newspaper_3", [["Despite his eccentricities, you can kind of see where the new owner's coming from.", ""], ["After all...you DO like pizza.", ""]]);
                    break;
            }
            break;
        case "Newspaper4":
            add_page("There appears to be a newspaper clipping pinned up on the wall.", "");
            add_page("Out of curiousity, you begin reading...", "");
            add_page("LOCAL BUSINESS OWNER FOUND DEAD IN HOME - 2/13/05", "Newspaper");
            add_page("Earlier this morning, authorities found local business owner Henry Emily dead in his home during a routine welfare check.", "Newspaper");
            add_page("While a gruesome scene, one which authorities are still trying to wrap their heads around...", "Newspaper");
            add_page("...Any foul play has been ruled out. All evidence points to Mr. Emily having been the only person in his home at the time of death.", "Newspaper");
            add_page("While his former business has fallen into public infamy over the years, many who worked for Emily hold him in high regard, and mourn his passing.", "Newspaper");
            add_page("When asked for comment, a company technician who claimed to be quite close with Mr. Emily had the following to say...", "Newspaper");
            add_page("\"He was doing pretty rough for a while. I hate to see him go like this.\"", "Newspaper");
            add_page("\"...I guess he just wanted to be with his wife and daughter again.\"", "Newspaper");
            add_page("...You decided to not read any further.", "");
            break;
        case "Newspaper_5":
            add_page("There appears to be a newspaper clipping pinned up on the wall.", "");
            add_page("Out of curiousity, you begin reading...", "");
            add_page("SORDID CEO RETURNS TO STRUGGLING RESTAURANT CHAIN - 2/25/05", "");
            add_page("It was a shock to see the new owner of Frickbear Entertainment arrested mere days after the acquisition of the company.", "Newspaper");
            add_page("...But what was even more of a shock was that a mere week after his imprisonment, the CEO has already returned to his former position.", "Newspaper");
            add_page("According to sources close to the company, he had quickly made bail thanks to his \"lotsa gold coinses.\", and immediately got back to work.", "Newspaper");
            add_page("Shortly afterwards, he had applied for a nightguard position at the company, allegedly in order to perform espionage on the new owner.", "Newspaper");
            add_page("Upon confronting him, said new owner allegedly \"started crying, got on his knees, and begged him to take the position back.\"", "Newspaper");
            add_page("When asked for comment, this short-lived owner exhaustedly claimed that \"running this place is an experience I wouldn't wish on my worst enemy.\"", "Newspaper");
            add_page("We're all wishing him the best here in the reporter's room.", "Newspaper");
            break;
        case "FredbearCloser_Slacker":
            if (oEndingPFFredbear.EndingsSeen == 3)
            {
                add_page("Wow! You...", "");
                
                Function[TextPageNumber] = function()
                {
                    with (oEndingPFFredbear)
                    {
                        change_expression(1);
                    }
                };
                
                add_page("...Really saved the easiest one for last, huh?", "");
                add_page("...", "");
                
                Function[TextPageNumber] = function()
                {
                    with (oEndingPFFredbear)
                    {
                        change_expression(0);
                    }
                };
                
                add_page("...Well, now you've seen every way this story ends.", "");
                
                Function[TextPageNumber] = function()
                {
                    with (oEndingPFFredbear)
                    {
                        change_expression(3);
                    }
                };
                
                add_page("And no matter how you go about it, you can't help everyone. Someone gets left behind...", "");
                
                Function[TextPageNumber] = function()
                {
                    with (oEndingPFFredbear)
                    {
                        change_expression(0);
                    }
                };
                
                add_page("...And by the end of it, you're just back at square one.", "");
                
                Function[TextPageNumber] = function()
                {
                    with (oEndingPFFredbear)
                    {
                        change_expression(2);
                    }
                };
                
                add_page("Hey, don't be upset! You tried your best, you know?", "");
                
                Function[TextPageNumber] = function()
                {
                    with (oEndingPFFredbear)
                    {
                        change_expression(3);
                    }
                };
                
                add_page("Besides, it isn't ALL bad...", "");
                
                Function[TextPageNumber] = function()
                {
                    with (oEndingPFFredbear)
                    {
                        change_expression(2);
                    }
                };
                
                add_page("Even if things stay the same, there's...something comforting about that, you know?", "");
                
                Function[TextPageNumber] = function()
                {
                    with (oEndingPFFredbear)
                    {
                        change_expression(1);
                    }
                };
                
                add_page("...Well, either way, I'd say you deserve some rest.", "");
                
                Function[TextPageNumber] = function()
                {
                    with (oEndingPFFredbear)
                    {
                        change_expression(0);
                    }
                };
                
                add_page("Why don't you take it easy for a while?", "");
            }
            else
            {
                add_page("Woah, hey, hey! You aren't leaving already, are »you?", "");
                
                Function[TextPageNumber] = function()
                {
                    with (oEndingPFFredbear)
                    {
                        change_expression(2);
                    }
                };
                
                add_page("We still have so, SO many more friends to make! So many more games to play! You've barely scratched the surface!", "");
                
                Function[TextPageNumber] = function()
                {
                    with (oEndingPFFredbear)
                    {
                        change_expression(3);
                    }
                };
                
                add_page("...Ah, but you must be pretty tired out after all of that, huh?", "");
                
                Function[TextPageNumber] = function()
                {
                    with (oEndingPFFredbear)
                    {
                        change_expression(2);
                    }
                };
                
                add_page("Don't worry, I get it! Go ahead, get some rest if you need it.", "");
                
                Function[TextPageNumber] = function()
                {
                    with (oEndingPFFredbear)
                    {
                        change_expression(0);
                    }
                };
                
                add_page("...Just promise me you'll come back to play sometime soon, yeah?", "");
                check_if_last_ending();
            }
            
            Function[TextPageNumber] = function()
            {
                with (oEndingPFFredbear)
                {
                    Fadeout = true;
                    Timer = 30;
                    audio_play_sound(sfxPowerOn, 50, false);
                }
            };
            
            break;
        case "FredbearCloser_Evil":
            Function[TextPageNumber] = function()
            {
                with (oEndingPFFredbear)
                {
                    Expression = 1;
                }
            };
            
            add_page("Sheesh, what a downer! If only things could've »gone a different way...", "");
            
            Function[TextPageNumber] = function()
            {
                with (oEndingPFFredbear)
                {
                    change_expression(0);
                }
            };
            
            add_page("...", "");
            
            Function[TextPageNumber] = function()
            {
                with (oEndingPFFredbear)
                {
                    change_expression(1);
                }
            };
            
            add_page("...You know, it doesn't have to end like this.", "");
            
            Function[TextPageNumber] = function()
            {
                with (oEndingPFFredbear)
                {
                    change_expression(0);
                }
            };
            
            add_page("You can keep going. Keep trying.", "");
            
            Function[TextPageNumber] = function()
            {
                with (oEndingPFFredbear)
                {
                    change_expression(2);
                }
            };
            
            add_page("And hey, who knows? Maybe if you try REALLY hard, you'll end up with a happier ending!", "");
            
            Function[TextPageNumber] = function()
            {
                with (oEndingPFFredbear)
                {
                    change_expression(0);
                }
            };
            
            add_page("...Wouldn't hurt to try, would it?", "");
            check_if_last_ending();
            
            Function[TextPageNumber] = function()
            {
                with (oEndingPFFredbear)
                {
                    Fadeout = true;
                    Timer = 30;
                    audio_play_sound(sfxPowerOn, 50, false);
                }
            };
            
            break;
        case "FredbearCloser_Good":
            Function[TextPageNumber] = function()
            {
                with (oEndingPFFredbear)
                {
                    Expression = 2;
                }
            };
            
            add_page("Awww, how sweet! Those two finally got their »happily ever after...", "");
            
            Function[TextPageNumber] = function()
            {
                with (oEndingPFFredbear)
                {
                    change_expression(3);
                }
            };
            
            add_page("...Looks like the rest of us are still stuck here, though.", "");
            
            Function[TextPageNumber] = function()
            {
                with (oEndingPFFredbear)
                {
                    change_expression(2);
                }
            };
            
            add_page("Hey, that's not a bad thing! All our friends are here, after all!", "");
            
            Function[TextPageNumber] = function()
            {
                with (oEndingPFFredbear)
                {
                    change_expression(0);
                }
            };
            
            add_page("Maybe you should go spend more time with them. You wouldn't want them to get lonely, after all!", "");
            check_if_last_ending();
            
            Function[TextPageNumber] = function()
            {
                with (oEndingPFFredbear)
                {
                    Fadeout = true;
                    Timer = 30;
                    audio_play_sound(sfxPowerOn, 50, false);
                }
            };
            
            break;
        case "FredbearCloser_Money":
            add_page("Wow, look at you! At this rate, you'll be promoted »for sure!", "");
            
            Function[TextPageNumber] = function()
            {
                with (oEndingPFFredbear)
                {
                    change_expression(1);
                }
            };
            
            add_page("...Though you should know life isn't all about the money.", "");
            
            Function[TextPageNumber] = function()
            {
                with (oEndingPFFredbear)
                {
                    change_expression(2);
                }
            };
            
            add_page("It's about the journey! The friends you make along the way!", "");
            
            Function[TextPageNumber] = function()
            {
                with (oEndingPFFredbear)
                {
                    change_expression(3);
                }
            };
            
            add_page("And if you ever want to take that journey again...", "");
            
            Function[TextPageNumber] = function()
            {
                with (oEndingPFFredbear)
                {
                    change_expression(0);
                }
            };
            
            add_page("...I'll be there to take it with you.", "");
            check_if_last_ending();
            
            Function[TextPageNumber] = function()
            {
                with (oEndingPFFredbear)
                {
                    Fadeout = true;
                    Timer = 30;
                    audio_play_sound(sfxPowerOn, 50, false);
                }
            };
            
            break;
        case "FredbearCloser_Ultimate":
            add_page("Phew! What a ride, huh?", "");
            add_page("...", "");
            
            Function[TextPageNumber] = function()
            {
                with (oEndingCharlie)
                {
                    change_expression(1);
                }
            };
            
            add_page("...Oh, right, let me take this off.", "");
            Delay[TextPageNumber] = 120;
            
            Function[TextPageNumber] = function()
            {
                with (oEndingCharlie)
                {
                    FadingIn = true;
                }
                audio_play_sound(sfxPFFAppear, 10, false);
            };
            
            Skip[TextPageNumber] = true;
            add_page(" ", "");
            Hide[TextPageNumber - 1] = true;
            
            Function[TextPageNumber] = function()
            {
                with (oEndingCharlie)
                {
                    MaskOn = false;
                    change_expression(1);
                }
            };
            
            add_page($"Hi there, {guard_nickname()}. Recognize me?", "");
            
            Function[TextPageNumber] = function()
            {
                with (oEndingCharlie)
                {
                    change_expression(2);
                }
            };
            
            add_page("Sorry for not showing myself sooner... I'm sure you were wondering where that little voice in your head was coming from.", "");
            var MarioKills = global.DeathRecord[UnknownEnum.Value_16];
            if (MarioKills > 0)
            {
                Function[TextPageNumber] = function()
                {
                    with (oEndingCharlie)
                    {
                        change_expression(3);
                    }
                };
                
                if (MarioKills == 1)
                {
                    add_page("...And, uh... Sorry about killing you that one time, too.", "");
                }
                else
                {
                    add_page($"...And, uh... Sorry about those {global.DeathRecord[UnknownEnum.Value_16]} times I killed you, too.", "");
                }
                
                Function[TextPageNumber] = function()
                {
                    with (oEndingCharlie)
                    {
                        change_expression(1);
                    }
                };
                
                add_page("But hey! All's well that ends well, huh?", "");
            }
            else
            {
                Function[TextPageNumber] = function()
                {
                    with (oEndingCharlie)
                    {
                        change_expression(1);
                    }
                };
                
                add_page("...Oh, and thanks for keeping the music box running this whole time, too.", "");
            }
            
            Function[TextPageNumber] = function()
            {
                with (oEndingCharlie)
                {
                    change_expression(0);
                }
            };
            
            add_page("Either way, it seems like what you said to Cassidy really got through to him. Him and the others have all departed now.", "");
            
            Function[TextPageNumber] = function()
            {
                with (oEndingCharlie)
                {
                    change_expression(3);
                }
            };
            
            add_page("...Which I suppose means I'd better be on my way too.", "");
            
            Function[TextPageNumber] = function()
            {
                with (oEndingCharlie)
                {
                    change_expression(2);
                }
            };
            
            add_page("Heh. I can only imagine how happy my dad will be once he sees us all again.", "");
            add_page("...", "");
            
            Function[TextPageNumber] = function()
            {
                with (oEndingCharlie)
                {
                    change_expression(3);
                }
            };
            
            add_page("...You know, I guess all of this is to say...", "");
            
            Function[TextPageNumber] = function()
            {
                with (oEndingCharlie)
                {
                    change_expression(0);
                }
            };
            
            add_page($"...You're a real cool person, {guard_nickname()}.", "");
            
            Function[TextPageNumber] = function()
            {
                with (oEndingCharlie)
                {
                    change_expression(1);
                }
            };
            
            add_page("Thank you for taking this journey with us.", "");
            
            Function[TextPageNumber] = function()
            {
                with (oEndingCharlie)
                {
                    Fadeout = true;
                    Timer = 30;
                    audio_play_sound(sfxPowerOn, 50, false);
                }
            };
            
            break;
        case "FredbearMonologue":
            add_page("Poor, poor Henry...", "");
            add_page("...He never did make it back to tell the tale.", "");
            Delay[TextPageNumber] = 240;
            
            Function[TextPageNumber] = function()
            {
                oScaryFredbear.Eyes = UnknownEnum.Value_0;
                oScaryFredbear.FadeIn = true;
                audio_play_sound(sfxPFFAppear, 50, false, 1, 0, 0.6);
            };
            
            add_page($"Hey, {guard_nickname()}, buddy! What do you think you're doing here, huh?", "");
            
            Function[TextPageNumber] = function()
            {
                oScaryFredbear.Eyes = UnknownEnum.Value_2;
                oScaryFredbear.EyeOffsetSpeed = 4;
            };
            
            add_page("C'mon, ol' pal, you know a little watchman like yourself shouldn't be sticking their nose in confidential company files!", "");
            
            Function[TextPageNumber] = function()
            {
                oScaryFredbear.Eyes = UnknownEnum.Value_3;
                oScaryFredbear.EyeOffsetSpeed = 4;
            };
            
            add_page("Why don't you just...hand over that little ol' folder...and things can go on just as they should, yeah?", "");
            
            Function[TextPageNumber] = function()
            {
                oScaryFredbear.Eyes = UnknownEnum.Value_0;
                oScaryFredbear.EyeOffsetSpeed = 4;
            };
            
            add_page("After all...I'm sure you wouldn't wanna end up like Henry.", "");
            add_page("...", "");
            
            Function[TextPageNumber] = function()
            {
                oScaryFredbear.Eyes = UnknownEnum.Value_3;
            };
            
            add_page("...You, uh, aren't gonna give it back, are you?", "");
            
            Function[TextPageNumber] = function()
            {
                oScaryFredbear.Eyes = UnknownEnum.Value_1;
                oScaryFredbear.EyeOffsetSpeed = 4;
            };
            
            add_page("...Heheh, alright.", "");
            
            Function[TextPageNumber] = function()
            {
                oScaryFredbear.Eyes = UnknownEnum.Value_0;
                oScaryFredbear.EyeOffsetSpeed = 4;
            };
            
            add_page("Alright, I get it. I see what you're trying to do here.", "");
            
            Function[TextPageNumber] = function()
            {
                oScaryFredbear.Eyes = UnknownEnum.Value_3;
            };
            
            add_page("You think, by collecting all of these artifacts, by bringing them all together in one place...", "");
            
            Function[TextPageNumber] = function()
            {
                oScaryFredbear.Eyes = UnknownEnum.Value_0;
            };
            
            add_page("...You can save everyone, don't you?", "");
            
            Function[TextPageNumber] = function()
            {
                oScaryFredbear.Eyes = UnknownEnum.Value_1;
                oScaryFredbear.EyeOffsetSpeed = 4;
            };
            
            add_page("Free all those poor little souls...", "");
            
            Function[TextPageNumber] = function()
            {
                oScaryFredbear.Eyes = UnknownEnum.Value_4;
                oScaryFredbear.EyeOffsetSpeed = 4;
            };
            
            add_page("...And destroy everything we've built up here in the process.", "");
            
            Function[TextPageNumber] = function()
            {
                oScaryFredbear.Eyes = UnknownEnum.Value_3;
                oScaryFredbear.EyeOffsetSpeed = 4;
            };
            
            add_page("Well, have you considered...", "");
            
            Function[TextPageNumber] = function()
            {
                oScaryFredbear.Eyes = UnknownEnum.Value_0;
            };
            
            add_page("Maybe...things are better this way?", "");
            
            Function[TextPageNumber] = function()
            {
                oScaryFredbear.Eyes = UnknownEnum.Value_2;
                oScaryFredbear.EyeOffsetSpeed = 4;
            };
            
            add_page($"C'mon, {guard_nickname()}! You see it too, don't you? They love it here!", "");
            
            Function[TextPageNumber] = function()
            {
                oScaryFredbear.Eyes = UnknownEnum.Value_0;
                oScaryFredbear.ShowMasks = true;
                oScaryFredbear.FadeIn = false;
                oScaryFredbear.FadeSpeed = 5;
            };
            
            add_page("Those poor kids... Who KNOWS what waits for them on the other side, am I right?", "");
            add_page("But here, they've got friends to make, games to play, smiles to bring...", "");
            
            Function[TextPageNumber] = function()
            {
                oScaryFredbear.Eyes = UnknownEnum.Value_4;
                oScaryFredbear.ShowMasks = false;
                oScaryFredbear.FadeIn = true;
            };
            
            add_page("And somehow, you think that's a bad thing!", "");
            add_page("...", "");
            
            Function[TextPageNumber] = function()
            {
                oScaryFredbear.Eyes = UnknownEnum.Value_3;
                oScaryFredbear.EyeOffsetSpeed = 4;
            };
            
            add_page("...Hmmm, you know what? Maybe you just don't have the right...", "");
            
            Function[TextPageNumber] = function()
            {
                oScaryFredbear.Eyes = UnknownEnum.Value_0;
            };
            
            add_page("...Perspective, on everything.", "");
            
            Function[TextPageNumber] = function()
            {
                oScaryFredbear.Eyes = UnknownEnum.Value_1;
                oScaryFredbear.EyeOffsetSpeed = 4;
            };
            
            add_page($"Here, {guard_nickname()}...", "");
            Delay[TextPageNumber] = 120;
            
            Function[TextPageNumber] = function()
            {
                oScaryFredbear.Eyes = UnknownEnum.Value_4;
                oScaryFredbear.FadeIn = false;
                audio_stop_all();
            };
            
            Skip[TextPageNumber] = true;
            add_page(" ", "");
            Hide[TextPageNumber - 1] = true;
            
            Function[TextPageNumber] = function()
            {
                instance_create_depth(0, 0, depth + 1, oScaryFredbear_Reveal);
            };
            
            add_page("»»Why don't I show you?", "");
            
            Function[TextPageNumber] = function()
            {
                with (oScaryFredbear_Reveal)
                {
                    sprite_index = sFredbear_Reveal2;
                    Frame = 0;
                    audio_play_sound(sfxFifthEndingReveal, 10, false, 1, 0, 1.5);
                }
            };
            
            break;
        case "FredbearFightOpener":
            global.BossPhase = min(global.BossPhase, 1);
            if (global.Night == 6)
            {
                switch (global.Deaths[5])
                {
                    case 0:
                        add_page("I really do hate to do this to you, you know. You» were one of my favorites.", "");
                        add_page("...But hey, I think I know a way I can make it up to you!", "");
                        add_page("How about a little trip down memory lane?", "");
                        break;
                    case 1:
                        add_page("Wow, back already?", "");
                        add_page("Haha, I can't blame you!", "");
                        break;
                    case 2:
                        add_page("We could keep playing like this forever, you know.", "");
                        add_page("...Well, we as in me and the other kids. I still kinda have to kill you.", "");
                        break;
                    case 3:
                        add_page("You know, if you wanna stop me so bad...", "");
                        add_page("...Maybe you should quit playing along.", "");
                        break;
                    case 4:
                        add_page("...You don't give up easy, do you?", "");
                        break;
                    default:
                        add_page("Let's try this again.", "");
                        break;
                }
            }
            if (global.BossPhase > 0 && false)
            {
                add_option("Start from beginning", "Fredbear_BossStart");
                add_option("Start from boss stage", "Fredbear_BossBoss");
            }
            else
            {
                Function[TextPageNumber] = function()
                {
                    instance_create_depth(0, 0, 0, oFredbearManager);
                    instance_create_depth(0, 0, 0, oPersistentPauser);
                };
            }
            break;
        case "Fredbear_BossStart":
            Function[TextPageNumber] = function()
            {
                instance_create_depth(0, 0, 0, oFredbearManager);
                instance_create_depth(0, 0, 0, oPersistentPauser);
            };
            
            break;
        case "Fredbear_BossBoss":
            Function[TextPageNumber] = function()
            {
                global.BossPhase = 2;
                instance_create_depth(0, 0, 0, oFredbearManager);
                instance_create_depth(0, 0, 0, oPersistentPauser);
            };
            
            break;
        case "CassidyEndscene":
            add_page("It seems like no matter how hard I try...", "Cassidy");
            add_page("...You just won't let me have my way, huh?", "Cassidy");
            
            Function[TextPageNumber] = function()
            {
                with (oCassidyEndscene)
                {
                    switch_cassidy_sprite(1);
                }
            };
            
            add_page("Gosh. You really are stubborn.", "Cassidy");
            add_page("...", "Cassidy");
            add_page("...I...", "Cassidy");
            add_page("...I don't want this all to end.", "Cassidy");
            
            Function[TextPageNumber] = function()
            {
                with (oCassidyEndscene)
                {
                    switch_cassidy_sprite(0);
                }
            };
            
            add_page("I...don't want my friends to leave me behind.", "Cassidy");
            add_page("I know what I've done is selfish. I know it's wrong, but I...", "Cassidy");
            
            Function[TextPageNumber] = function()
            {
                with (oCassidyEndscene)
                {
                    switch_cassidy_sprite(1);
                }
            };
            
            add_page("...I couldn't let Henry take away the only friends I've ever known.", "Cassidy");
            add_page("I couldn't let you get in the way of me keeping them here.", "Cassidy");
            add_page("I...", "Cassidy");
            add_page("...I told the others there was nothing waiting for us after this, but...", "Cassidy");
            
            Function[TextPageNumber] = function()
            {
                with (oCassidyEndscene)
                {
                    switch_cassidy_sprite(0);
                }
            };
            
            add_page("The truth is, I don't know what's gonna happen to us when we move on.", "Cassidy");
            add_page("When we...reach the other side.", "Cassidy");
            add_page("And the thought of that...", "Cassidy");
            
            Function[TextPageNumber] = function()
            {
                with (oCassidyEndscene)
                {
                    switch_cassidy_sprite(1);
                }
            };
            
            add_page("...It terrifies me.", "Cassidy");
            add_page("What if there's nothing? What if after everything we've done it's just...black? Total nothingness?", "Cassidy");
            add_page("An unending void...an eternity where I can't even find comfort in my own screams.", "Cassidy");
            add_page("...", "Cassidy");
            
            Function[TextPageNumber] = function()
            {
                with (oCassidyEndscene)
                {
                    switch_cassidy_sprite(2);
                }
            };
            
            add_page("...I... I can't go there.", "Cassidy");
            add_page("I can't be forgotten. I can't be left behind.", "Cassidy");
            add_page("Can't it just stay this way forever?", "Cassidy");
            
            Function[TextPageNumber] = function()
            {
                with (oCassidyEndscene)
                {
                    CurCassidy = 0;
                    VisualMode = 1;
                }
                audio_sound_gain(sfxWindyAmbience, 0.25, 2000);
            };
            
            add_page("...", guard_nickname());
            
            Function[TextPageNumber] = function()
            {
                with (oCassidyEndscene)
                {
                    switch_cassidy_sprite(1);
                }
                play_music(mus_Cassidy);
            };
            
            switch (global.Guard)
            {
                case 0:
                    add_page("...H-Heh... We're two guys who've had it a little rough, huh?", "Jeremy");
                    add_page("I get where you're coming from...", "Jeremy");
                    add_page("...Okay, well, not ENTIRELY, b-but...", "Jeremy");
                    add_page("After everything that led to me working here, a lot of my friends were surprised I kept on looking for work.", "Jeremy");
                    add_page("They called it a \"comedy of errors.\" They said if they were in my shoes, they'd just...", "Jeremy");
                    add_page("...Stop. Give up. Accept life as it is, and all that stuff...", "Jeremy");
                    add_page("But, y'know what they say... Nothing is born of resignation right?", "Jeremy");
                    add_page("Bad stuff happens, 'cause it kinda...has to, at some point...", "Jeremy");
                    add_page("It's like, um... Do you like rollercoasters?", "Jeremy");
                    add_page("...Huh? Wh-what do you mean...?", "Cassidy");
                    add_page("Oh, I was a rollercoaster attendant a couple summers ago, I...er...", "Jeremy");
                    add_page("What I mean is, life's like a rollercoaster, right?", "Jeremy");
                    add_page("It comes at you fast! Sometimes you can barely process it all as it flies past you...", "Jeremy");
                    add_page("And...yeah, bad things happen. The coaster has to go down at some point...and it can be really scary when it does.", "Jeremy");
                    add_page("But when it goes down, that just means it'll go back up again!", "Jeremy");
                    add_page("Sure, maybe I could've just gotten some rest for once, or stayed home to focus on my studies...", "Jeremy");
                    add_page("...But then I wouldn't have gotten to experience one of the craziest weeks of my life!", "Jeremy");
                    add_page("...And I wouldn't have gotten to meet you!", "Jeremy");
                    add_page("...", "Cassidy");
                    add_page("...Life can be threatening, but...that's all the more reason to make the most of it, right?", "Jeremy");
                    add_page("Maybe you'll make some mistakes along the way...but hey, everyone does! That's just part of growing as a person!", "Jeremy");
                    add_page("...I think what I did was a bit more than a mistake...", "Cassidy");
                    add_page("...Right. Henry...", "Jeremy");
                    add_page("...B-But, hey! From how those papers of his sounded, it seems like all he really wanted was to help you guys move on.", "Jeremy");
                    add_page("Maybe it took a bit more time and a bit more hardship than he would've wagered, but...", "Jeremy");
                    add_page("...I think he'd really like for you all to join him, wherever he is now.", "Jeremy");
                    add_page("Just remember to say you're sorry, yeah?", "Jeremy");
                    add_page("...Haha, yeah...", "Cassidy");
                    add_page("...You're right. Nothing's gonna get better if I keep myself down here...", "Cassidy");
                    add_page("...If I keep all of them down here.", "Cassidy");
                    add_page("If there's even a chance I can make it up to them all, then I think it's...", "Cassidy");
                    break;
                case 1:
                    add_page("...Listen, kid.", "Mike");
                    add_page("I don't know anything about what it must be like to be stuck here for so long.", "Mike");
                    add_page("I don't know what's on the other side... (And I sure as hell don't know how to handle children...)", "Mike");
                    add_page("...But whatever you end up facing there, it can't be any worse than spending an eternity here, right?", "Mike");
                    add_page("I've only been here a week and I already hate this place. I can't imagine how you've felt being trapped here.", "Mike");
                    add_page("...And, hey, it's not like you have to go it alone, right? Your friends'll go with you.", "Mike");
                    add_page("...But, after all that I did...", "Cassidy");
                    add_page("...Would they even st-still want to be my friends anymore?", "Cassidy");
                    add_page("I...", "Mike");
                    add_page("...", "Mike");
                    add_page("...Look. I can't say for sure.", "Mike");
                    add_page("But you still care about them, right? Don't you think they deserve better than to be stuck in a place like this?", "Mike");
                    add_page("Maybe they'll be mad. Maybe they'll need some time away.", "Mike");
                    add_page("If they do...you'll just have to work on yourself for them. You'll find it in yourself to become a better person, for their sake.", "Mike");
                    add_page("Trust me, kid. As long as you have someone out there to keep fighting for...that's all you need.", "Mike");
                    add_page("You gotta do what's best for them.", "Mike");
                    add_page("I...", "Cassidy");
                    add_page("...", "Cassidy");
                    add_page("...You're right.", "Cassidy");
                    add_page("It...it isn't right to keep them all down here.", "Cassidy");
                    add_page("...It isn't right to keep myself down here.", "Cassidy");
                    add_page("Whatever's there for us after everything's over...they're still my friends. At least, I still believe that...", "Cassidy");
                    add_page("...Still, I...I don't like saying goodbye.", "Cassidy");
                    add_page("I'll...I'll see you again someday, won't I?", "Cassidy");
                    add_page("Heh...well, hopefully not too soon.", "Mike");
                    add_page("...But you take care of yourself until then, alright?", "Mike");
                    add_page("...Haha, yeah...", "Cassidy");
                    add_page("It's...", "Cassidy");
                    break;
                case 2:
                    add_page("...I get it, kid. I really do.", "Vanessa");
                    add_page("Stability is...nice. Knowing things won't change, that you can just stay put while everything keeps chugging along...", "Vanessa");
                    add_page("...Knowing that you won't need to change. Knowing you can cruise through life if you maintain the status quo.", "Vanessa");
                    add_page("But...I think we both need to face the facts.", "Vanessa");
                    add_page("This place...it's just kinda miserable now, isn't it? After everything that's happened, nothing really seems like it'll get better...", "Vanessa");
                    add_page("...And it'll just stay that way if you keep them believing in this sad fantasy. That everything's fine the way it is here.", "Vanessa");
                    add_page("Letting others pay in blood just so you can keep it up... Is that really how you want things to be? Forever?", "Vanessa");
                    add_page("...", "Cassidy");
                    add_page("...Don't get me wrong, it's scary to move on. Change is frightening to anyone.", "Vanessa");
                    add_page("...But change is natural, too. Nothing stays the same forever. Friends, trends, customers... All of them come and go.", "Vanessa");
                    add_page("You can never be sure how things'll turn out...", "Vanessa");
                    add_page("...But you can be sure that if you stay where you are now, things will never get any better.", "Vanessa");
                    add_page("...", "Cassidy");
                    add_page("...You're right.", "Cassidy");
                    add_page("All these years I thought this was where I was happiest, but it's getting harder to believe that every day...", "Cassidy");
                    add_page("...And if that's how I feel, my friends must be...", "Cassidy");
                    add_page("...Hey, you want what's best for them too, right?", "Vanessa");
                    add_page("A-And the only way things can get better is if I...", "Cassidy");
                    add_page("...", "Cassidy");
                    add_page("I...I think it's...", "Cassidy");
                    break;
                case 3:
                    add_page("...Time is a scary thing.", "Fritz");
                    add_page("No matter what we do, time won't wait for us.", "Fritz");
                    add_page("Whether we're out in the yard, unaware of its presence, or watching it slowly tick away on the clock overhead...", "Fritz");
                    add_page("...Time will not stop.", "Fritz");
                    add_page("...So why should we?", "Fritz");
                    add_page("..Why should we sit in contempt, willing to let this idea of \"eternity\" frighten us?", "Fritz");
                    add_page("Why shouldn't we take action? Make time catch up with us?", "Fritz");
                    add_page("Complacency is tempting, yes, but could you just DREAM of what may come next?", "Fritz");
                    add_page("What if there's MORE on the other side? What if there's something NEW?", "Fritz");
                    add_page("...B-But...", "Cassidy");
                    add_page("...What if it's...what if it's just more suffering? What if it hurts?", "Cassidy");
                    add_page("Then we'll let it hurt. We'll let it TRY.", "Fritz");
                    add_page("We'll push beyond whatever waits for us, heads to the sky!", "Fritz");
                    add_page("You and I have survived more than death itself. I'd like to see it TRY and make us hurt!", "Fritz");
                    add_page("We've felt more than pain. We've felt pride. We've felt dread.", "Fritz");
                    add_page("And now, there's nothing left for you here...", "Fritz");
                    add_page("...But there's EVERYTHING beyond.", "Fritz");
                    add_page("No more dingy backrooms, no more greasy floors...and no more hideous nightguards!", "Fritz");
                    add_page("Seriously, talk about low standards! Have you SEEN the last guy they hired?", "Fritz");
                    add_page("...Hehe...", "Cassidy");
                    add_page("No, really! Have you seen that big red clown hair of his? His weirdo rat eyes? And the way he WALKS?", "Fritz");
                    add_page("...Heheh, an- and his shabby tie! And his grimy shirt!", "Cassidy");
                    add_page("Oh my god, has he even HEARD of a shower?", "Fritz");
                    add_page("Hehehahaha!", "Cassidy");
                    add_page("...Gosh, now I REALLY feel bad about trying to kill you.", "Cassidy");
                    add_page("Eh, so has everyone else in this building. I'm used to it.", "Fritz");
                    add_page("Now... You've got somewhere to be, don't you?", "Fritz");
                    add_page("...Haha, yeah...", "Cassidy");
                    add_page("It's...", "Cassidy");
                    break;
                default:
                    if (get_guard_property("new_cassidy_dialogue", false, global.Guard, true))
                    {
                        read_custom_dialogue("SPOILERS/dialogue/cutscene_Cassidy.txt", "DIALOGUE");
                    }
                    else
                    {
                        var Import = import_dialogue(global.Guard, "/SPOILERS/cutscenes/ending_dialogue.txt");
                        var NarratorName = "";
                        if (string_lower(Import.FIRST_PERSON) == "true")
                        {
                            NarratorName = guard_name();
                        }
                        for (var i = 0; i < array_length(Import.DIALOGUE); i++)
                        {
                            add_page(Import.DIALOGUE[i], no_brackets(NarratorName));
                        }
                        add_page("...", "Cassidy");
                        add_page("...You're right.", "Cassidy");
                        add_page("It...it isn't right to keep them all down here.", "Cassidy");
                        add_page("It's...", "Cassidy");
                    }
                    break;
            }
            
            Function[TextPageNumber] = function()
            {
                audio_stop_all();
                instance_destroy(oCassidyEndscene);
            };
            
            Delay[TextPageNumber] = 60;
            add_page("...It's time to go.", "");
            Delay[TextPageNumber] = 120;
            Skip[TextPageNumber] = true;
            add_page(" ", "");
            Delay[TextPageNumber] = 60;
            Skip[TextPageNumber] = true;
            add_page("", "");
            
            Function[TextPageNumber] = function()
            {
                global.FredbearMode = false;
                room_goto(EndingArgumentScene);
            };
            
            break;
        case "4LD_GuardConversation":
            add_page("Oh! Well hello there, mister!", "Jeremy");
            add_page("So it's not just us two who wound up here, huh?", "Vanessa");
            add_page("W-who the hell are you guys? ...WHERE the hell are we?", "Mike");
            add_page("Wish I could tell you. The two of us only just got here...", "Vanessa");
            add_page("...Oh, and the name's Vanessa, by the way. Cute uniform.", "Vanessa");
            add_page("And I'm Jeremy! Jeremy Fitzgerald! Pleasure to meet you!", "Jeremy");
            add_page("...Likewise.", "Mike");
            add_page("So, judging by your nametag, \"Mike\"...am I right to assume you were working the nightshift too?", "Vanessa");
            add_page("Yeah, at a crappy children's restaurant of all places...", "Mike");
            add_page("...Wait, what do you mean \"too\"? I'm sure I was alone in that building.", "Mike");
            add_page("Well, unless those cruddy mascots count. Saw them wandering around when the bear got in my office and...", "Mike");
            add_page("Oh, they got you too, huh?", "Jeremy");
            add_page("...Huh?", "Mike");
            
            Function[TextPageNumber] = function()
            {
                with (o4LD_OpeningCutscene)
                {
                    JeremyDirection = 1;
                }
            };
            
            add_page("Bonnie was the one who got me, actually. The withered one. Some irony there, huh?", "Jeremy");
            add_page("Is...that how your face got all like...?", "Mike");
            
            Function[TextPageNumber] = function()
            {
                with (o4LD_OpeningCutscene)
                {
                    JeremyDirection = -1;
                }
            };
            
            add_page("OH! Oh, no no no. Seperate incident...s.", "Jeremy");
            
            Function[TextPageNumber] = function()
            {
                with (o4LD_OpeningCutscene)
                {
                    JeremyDirection = 1;
                }
            };
            
            add_page("B-But that's besides the point! This basically confirms your theory, right, Vanessa?", "Jeremy");
            
            Function[TextPageNumber] = function()
            {
                with (o4LD_OpeningCutscene)
                {
                    VanessaDirection = -1;
                }
            };
            
            add_page("Well, I wouldn't say CONFIRMS... (A-And it's not really a theory until we know if we're actually dead...)", "Vanessa");
            add_page("Wait, dead? You're dead? I'M dead!?", "Mike");
            
            Function[TextPageNumber] = function()
            {
                with (o4LD_OpeningCutscene)
                {
                    VanessaDirection = -1;
                    JeremyDirection = -1;
                }
            };
            
            add_page("N-No! Yes? Maybe. It's...looking more plausible, as much as I hate to entertain the idea.", "Vanessa");
            
            Function[TextPageNumber] = function()
            {
                with (o4LD_OpeningCutscene)
                {
                    VanessaDirection = 1;
                }
            };
            
            add_page("(Especially if it means we've found ourselves in some sort of Freddy Faz-Hell.)", "Vanessa");
            Skip[TextPageNumber] = true;
            add_page("No, no, I've...I've got to get back on the clock. Who'll take care of...", "Mike");
            
            Function[TextPageNumber] = function()
            {
                with (o4LD_OpeningCutscene)
                {
                    VanessaDirection = -1;
                }
            };
            
            add_page("Woah, hey, calm down! Listen, we were just waiting to see if anyone would come along to lead the way.", "Jeremy");
            add_page("And since it doesn't look like we're getting an orientation anytime soon...you can tag along with us, if you'd like.", "Vanessa");
            add_page("...Okay. Okay. Any idea where we're going?", "Mike");
            add_page("Jeremy said he saw some strange statues...and what sounded like carnival music in the distance.", "Vanessa");
            add_page("Yeah! And hey, if there's a carnival in town, surely that means there's more people, right?", "Jeremy");
            add_page("If they're the same people who put those freaky statues up, I'm not sure I wanna meet them...", "Mike");
            add_page("Speak for yourself, I'd love to see what's wrong with them. Now c'mon! We're not gonna get anywhere standing around talking!", "Vanessa");
            
            Function[TextPageNumber] = function()
            {
                with (o4LD_OpeningCutscene)
                {
                    DialogueLock = false;
                    PostCutsceneFlag = true;
                }
            };
            
            break;
        case "4LD_OMC":
            add_page("...Hmm?", "Old Man");
            
            Function[TextPageNumber] = function()
            {
                with (o4LD_OpeningCutscene)
                {
                    OMCDirection = -1;
                }
            };
            
            add_page("...Ah. The souls do come in droves today, it seems.", "Old Man");
            add_page("You...surely aren't another security guard, are you?", "Vanessa");
            
            Function[TextPageNumber] = function()
            {
                with (o4LD_OpeningCutscene)
                {
                    OMCDirection = 1;
                }
            };
            
            add_page("Oh, no no, certainly not. I'm nothing more than an old hermit, I'm afraid.", "Old Man");
            add_page("Ah, well...I suppose that makes sense. You certainly don't look like you got here recently.", "Vanessa");
            add_page("...Er, no offense.", "Vanessa");
            add_page("...How long HAVE you been here, exactly?", "Mike");
            add_page("I've found it foolish to count the days when there's no sun in the sky...", "Old Man");
            add_page("But I'm more than familiar with these hallowed lands, if it's knowledge that you seek. Its unwavering stillness, isolated from time...", "Old Man");
            
            Function[TextPageNumber] = function()
            {
                with (o4LD_OpeningCutscene)
                {
                    OMCDirection = -1;
                }
            };
            
            add_page("...It's nice, isn't it? Certainly does well for my fishing.", "Old Man");
            add_page("Ah, yeah, o-of course!", "Jeremy");
            add_page("But, er...how do I say this...?", "Jeremy");
            add_page("Do you know if this is...if we're in...uh, Hell...?", "Jeremy");
            add_page("I should hope not. Fish never tend to bite when they've sins to atone.", "Old Man");
            add_page("But we ARE, at least in some way, dead?", "Vanessa");
            add_page("Yes, yes. But your souls remain full of fervor, nonetheless...", "Old Man");
            add_page("Oh god. So this IS Pizza Purgatory.", "Vanessa");
            add_page("W-Wait! Surely there's...SOME way out, right?", "Jeremy");
            
            Function[TextPageNumber] = function()
            {
                with (o4LD_OpeningCutscene)
                {
                    OMCDirection = 1;
                }
            };
            
            add_page("...Geheheh. They all ask that eventually.", "Old Man");
            add_page("So you're saying there's no way out?", "Mike");
            add_page("Ah, that's not what I said.", "Old Man");
            add_page("You three seem young, experienced... I'm sure you could stand a chance, if you'd be able to stomach such an arduous undertaking.", "Old Man");
            
            Function[TextPageNumber] = function()
            {
                with (o4LD_OpeningCutscene)
                {
                    OMCDirection = -1;
                }
            };
            
            add_page("But whether there's a way out for you... I'm afraid that's not my jurisdiction.", "Old Man");
            add_page("...Alright, old man, enough riddles. Is there a way out, or is there not?", "Vanessa");
            
            Function[TextPageNumber] = function()
            {
                with (o4LD_OpeningCutscene)
                {
                    OMCDirection = 1;
                }
            };
            
            add_page("...", "Old Man");
            add_page("...There is, indeed, an exit.", "Old Man");
            add_page("But it will take quite the toll on your body and mind if you intend to seek it. The pathway is teeming with monsters.", "Old Man");
            add_page("...Monsters born from the memories of all those who have fallen here. Some you may recognize, others you will learn to fear.", "Old Man");
            
            Function[TextPageNumber] = function()
            {
                with (o4LD_OpeningCutscene)
                {
                    OMCDirection = -1;
                }
            };
            
            add_page("Quite a few souls have already begun their attempts. A rather excitable one just passed by, as a matter of fact.", "Old Man");
            add_page("But, even if you do reach the end of your path...", "Old Man");
            
            Function[TextPageNumber] = function()
            {
                with (o4LD_OpeningCutscene)
                {
                    OMCDirection = 1;
                }
            };
            
            add_page("...It's up to the Angel whether you'll be allowed to leave.", "Old Man");
            add_page("The...Angel?", "Vanessa");
            
            Function[TextPageNumber] = function()
            {
                with (o4LD_OpeningCutscene)
                {
                    OMCDirection = -1;
                }
            };
            
            add_page("The one in control of this realm, yes.", "Old Man");
            add_page("They reside deep within the halls of their sanctum, awaiting their time to pass judgement on fallen souls.", "Old Man");
            
            Function[TextPageNumber] = function()
            {
                with (o4LD_OpeningCutscene)
                {
                    OMCDirection = 1;
                }
            };
            
            add_page("So long as they deem you worthy... you will be given passage back to your mortal lives.", "Old Man");
            add_page("Or your proper afterlife... whichever you prefer.", "Old Man");
            add_page("...And if we're not deemed worthy?", "Mike");
            
            Function[TextPageNumber] = function()
            {
                with (o4LD_OpeningCutscene)
                {
                    OMCDirection = -1;
                }
            };
            
            add_page("Well, then I suppose you'll just be stuck here with me.", "Old Man");
            add_page("...Fortunately for you, the Angel tends to be rather forgiving.", "Old Man");
            add_page("Well, that's...great! A little scary-sounding, but great! We have a chance after all!", "Jeremy");
            add_page("...So where can we meet this...\"Angel\"?", "Mike");
            
            Function[TextPageNumber] = function()
            {
                with (o4LD_OpeningCutscene)
                {
                    OMCDirection = 1;
                }
            };
            
            add_page("Oh, they're just up at the top of the tower.", "Old Man");
            add_page("The tower? What do you...", "Vanessa");
            add_page("...Oh.", "Vanessa");
            
            Function[TextPageNumber] = function()
            {
                instance_create_depth(0, 0, 10, o4LD_Title);
            };
            
            break;
        case "4LD_EnterOMCShop":
            if (global.Guard == UnknownEnum.Value_20)
            {
                add_page("You've reached the top.", "");
                add_page("...For all the times you've been up here, you still can't help but be taken aback by the view.", "");
                add_page("All that the Angel has created, all that transpired for it to end up like this...", "");
                add_page("The thought that this may be the last time you ever see any of it. That today is the day you finally wave this realm goodbye...", "");
                add_page("...", "");
                add_page("...Though you were never fond of goodbyes.", "");
                
                Function[TextPageNumber] = function()
                {
                    with (o4LD_OMCEndingScene)
                    {
                        switch_pose(0);
                    }
                    with (o4LD_OMCEndingScene)
                    {
                        ShowMoney = true;
                    }
                };
                
                add_page("Best rid yourself of whatever's left shackling you to this place and be on your way.", "");
                
                Function[TextPageNumber] = function()
                {
                    with (o4LD_OMCEndingScene)
                    {
                        DrainMoney = true;
                        SavedEarnings = 0;
                    }
                };
            }
            else
            {
                add_page("Hold.", "Old Man");
                
                Function[TextPageNumber] = function()
                {
                    with (o4LD_OMCEndingScene)
                    {
                        switch_pose(0);
                    }
                };
                
                add_page("Still your worries. It is only me.", "Old Man");
                add_page("Your journey is at its end.", "Old Man");
                add_page("You have won, and you remain... But at the end is where your vigor is paramount.", "Old Man");
                
                Function[TextPageNumber] = function()
                {
                    with (o4LD_OMCEndingScene)
                    {
                        switch_pose(1);
                    }
                };
                
                add_page("You'll not cross this river on your own. Many have tried and all have failed.", "Old Man");
                add_page("All but I.", "Old Man");
                
                Function[TextPageNumber] = function()
                {
                    with (o4LD_OMCEndingScene)
                    {
                        switch_pose(0);
                    }
                    with (o4LD_OMCEndingScene)
                    {
                        ShowMoney = true;
                    }
                };
                
                add_page("So, I ask of you to forgo your worldly possessions unto me. You have no use for them, not anymore.", "Old Man");
                add_page("They will serve only to tilt the scales of the Angel's judgement, and not in your favor.", "Old Man");
                
                Function[TextPageNumber] = function()
                {
                    with (o4LD_OMCEndingScene)
                    {
                        DrainMoney = true;
                        if (SavedEarnings >= 100)
                        {
                            unlock_guard(UnknownEnum.Value_8);
                        }
                        SavedEarnings = 0;
                    }
                };
            }
            break;
        case "4LD_OMCMoneyTaken":
            if (global.Guard == UnknownEnum.Value_20)
            {
                add_page("...Very well then.", "");
                add_page("The time has come.", "");
                
                Function[TextPageNumber] = function()
                {
                    with (o4LD_OMCEndingScene)
                    {
                        FadingOut = true;
                        alarm[1] = 240;
                        audio_sound_gain(global.Music, 0, 3000);
                    }
                };
                
                break;
            }
            switch (o4LD_OMCEndingScene.EarningsRank)
            {
                case "Cheated":
                    add_page("There's no fucking way you earned that.", "Old Man");
                    add_page("That shit will not fit on my boat. Are you fucking serious.", "Old Man");
                    add_page("Here. Allow me.", "Old Man");
                    
                    Function[TextPageNumber] = function()
                    {
                        with (o4LD_OMCEndingScene)
                        {
                            switch_pose(1);
                        }
                    };
                    
                    add_page("You watch as the Old Man tosses all of your money into the ocean, as it's torn apart by rabid piranhas...", "");
                    add_page("Rabid ANIMATRONIC piranhas.", "");
                    break;
                case "Rich":
                    add_page("Ah, you show your achievements brazen in riches, I see.", "Old Man");
                    add_page("Many will speak of your name in praise, I will make it so.", "Old Man");
                    add_page("...Most jubilantly at the bar.", "Old Man");
                    break;
                case "Moderate":
                    add_page("Good. This will serve well for those still trapped within these walls.", "Old Man");
                    break;
                case "Poor":
                    add_page("Parading through these depths on scraps alone?", "Old Man");
                    add_page("...I'll be sure these won't go to waste.", "Old Man");
                    break;
                case "Debt":
                    add_page("...Ah. Well, that makes things easier for me, I suppose.", "Old Man");
                    add_page("*Snf*...", "Old Man");
                    break;
            }
            
            Function[TextPageNumber] = function()
            {
                with (o4LD_OMCEndingScene)
                {
                    switch_pose(1);
                }
            };
            
            add_page("My boat lies just by the dock. I will join you shortly.", "Old Man");
            add_page("...Rest while you can, for your soul will surely need it.", "Old Man");
            
            Function[TextPageNumber] = function()
            {
                with (o4LD_OMCEndingScene)
                {
                    FadingOut = true;
                    alarm[1] = 240;
                    audio_sound_gain(global.Music, 0, 3000);
                }
            };
            
            break;
        case "4LD_RiverConvo":
            if (global.Guard >= 21)
            {
                var DefaultText = [["...Do you fear the Angel?", "Old Man"], ["They're really quite benevolent. Forgiving sort, they are.", "Old Man"], ["Of course, don't misconstrue my words...for I do not know you, nor your actions.", "Old Man"], ["But life is more than a binary of good and bad actions. It's a tapestry we define ourselves.", "Old Man"], ["There's always threads of good in the patterns of the wicked, it's just a different kind of good than you may see.", "Old Man"], ["Those who we believe to be led by sin may never have known another way.", "Old Man"], ["Maybe they were never given one.", "Old Man"], ["And in the eyes of the many, maybe they never deserved it.", "Old Man"], ["But it is through the Angel's eyes that we might see beyond our veil of good and evil.", "Old Man"], ["Word of advice from an old hermit...To try and weigh a life's value in such a simple way is to devalue its meaning.", "Old Man"], ["And that may not mean much to some, or it may mean everything to others.", "Old Man"], ["But in the end, whatever retribution you \"deserve\", the Angel will impart upon you with no partisanship.", "Old Man"], ["For it is not what you deserve that matters, but what you are given.", "Old Man"]];
                var file = "/dialogue/boatride.txt";
                read_custom_dialogue(file, "DIALOGUE", DefaultText);
            }
            else
            {
                switch (global.Guard)
                {
                    case UnknownEnum.Value_0:
                        add_page("Thank you for the ride! Though, um...", "Jeremy");
                        add_page("...This boat's wood seems kinda...rotty. Have you had it for a long time?", "Jeremy");
                        add_page("Much longer than you would think.", "Old Man");
                        add_page("I could help you fix it, if you wanted? You kinda just need to chisel it out and replace it with new timber!", "Jeremy");
                        add_page("Well, unless you can get your hands on some epoxy. Not sure where we'd get that around here though...", "Jeremy");
                        add_page("The rotting wood is of no concern, I assure you. I'll replace it as I have many times before.", "Old Man");
                        add_page("...Though your advice does not go unheeded. I hadn't taken you for the nautical sort.", "Old Man");
                        add_page("Oh, my dad took me out on a lot of fishing trips when I was younger! But gosh, I haven't gone on one in...how many years now?", "Jeremy");
                        add_page("He showed me how to repair stuff like that, and I even got to help a few times!", "Jeremy");
                        add_page("...But we had to get rid of our boat eventually, I think just because it was so old.", "Jeremy");
                        add_page("Actually, for the past few years he's been trying to save up for a big boat... One our friends and family can come out on!", "Jeremy");
                        add_page("...And I really hope he manages to make it work, because it actually feels really nice to be back on a boat, heheh.", "Jeremy");
                        add_page("...Hearing that brings great joy to these old bones, Jeremy. ...Even if my face may not show it.", "Old Man");
                        add_page("If you will indulge an old fool, might I impart some fishing wisdom before you go?", "Old Man");
                        add_page("I can't guarantee I haven't heard it, but sure!", "Jeremy");
                        break;
                    case UnknownEnum.Value_1:
                        add_page("...You sure this thing won't fall apart on us? I'm getting tinnitus just looking at it.", "Mike");
                        add_page("I'll assume you're meaning tetanus.", "Old Man");
                        add_page("And I'm certain. I've fared these waters more than the lake itself may remember.", "Old Man");
                        add_page("Well, you definitely look the part.", "Mike");
                        add_page("...Wait. How many people have gone through this whole shebang?", "Mike");
                        add_page("More than I would remember, but less than you would guess.", "Old Man");
                        add_page("Faces will blur together when you've been here as long as I have, but the moments may never fade.", "Old Man");
                        add_page("See, more than a few souls have left their mark on this plan-.", "Old Man");
                        Skip[TextPageNumber - 1] = true;
                        add_page("Yeah, yeah. I-I get it, I figured...", "Mike");
                        add_page("...Do you mean to share your troubles, or are my words not comforting enough for you?", "Old Man");
                        add_page("Nah, I mean- Sorry man. You just...", "Mike");
                        add_page("Gah, false hopes, I guess.", "Mike");
                        add_page("I'm no one special, really. And if someone like me could come down here...", "Mike");
                        add_page("I just thought I might see a familiar face, that's all.", "Mike");
                        add_page("...The absence of their soul might be a greater blessing than you realize.", "Old Man");
                        add_page("To fare these waters means that one may seldom return, and if the Angel has given their blessing?", "Old Man");
                        add_page("The person you speak of may be waiting for you, just on the other side of the glass.", "Old Man");
                        add_page("...And I get to...CHOOSE, if I come back, right?", "Mike");
                        add_page("If the Angel deems your will to be true and worthy.", "Old Man");
                        add_page("...But are you truly prepared to leave behind the waking world?", "Old Man");
                        add_page("...No, no I...", "Mike");
                        add_page("I can't. Not yet.", "Mike");
                        add_page("I got Mary to take care of. And if it wasn't for me, she probably would've killed our aunt by now.", "Mike");
                        add_page("...Not to mention this new job I got. Supposed to be an easy gig. Heh.", "Mike");
                        add_page("Besides I don't...I don't deserve it. Not like he probably did.", "Mike");
                        add_page("...No one truly deserves anything. The cards we're given are the ones we must hold close.", "Old Man");
                        add_page("And it sounds to me that the hand you've been dealt makes for quite a pair.", "Old Man");
                        add_page("So don't forget, there's always the river to make that hand shine.", "Old Man");
                        add_page("I...", "Mike");
                        add_page("I don't play poker.", "Mike");
                        add_page("But I think I got what you mean. Thanks, man, it helps.", "Mike");
                        add_page("As is my pleasure.", "Old Man");
                        break;
                    case UnknownEnum.Value_2:
                        add_page("Hey, thanks for the ride and all that.", "Vanessa");
                        add_page("It is my duty and my pleasure to guide those across these waters.", "Old Man");
                        add_page("Yeah, you...definitely look the part.", "Vanessa");
                        add_page("So...you've been doing this for a while, right?", "Vanessa");
                        add_page("Quite some time, yes. Longer than any mortal man has lived.", "Old Man");
                        add_page("Wow. I get being married to your job and everything but...", "Vanessa");
                        add_page("...", "Vanessa");
                        add_page("...Don't hesitate to speak your mind.", "Old Man");
                        add_page("Hm?", "Vanessa");
                        add_page("Your soured expression speaks more than words ever could.", "Old Man");
                        add_page("Look, I'm just...", "Vanessa");
                        add_page("It's weird, okay? Seeing it all laid out like this.", "Vanessa");
                        add_page("I've spent so much time at this company, I couldn't even begin to count the days.", "Vanessa");
                        add_page("And it's a LOT to take in! I mean, I could tell you some of these guys' manufacturing dates before I told you my mother's birthday!", "Vanessa");
                        add_page("...It was Jan- NO. July 8th! I remember because it was four days after Firework Freddy's...release.", "Vanessa");
                        add_page("I guess it'd just become so intertwined with my day-to-day, that when something was weird...", "Vanessa");
                        add_page("That was just Freddy's, you know? Sweep it under the rug, it's probably fine!", "Vanessa");
                        add_page("I gave a lot for this company, and I'm starting to forget when it last gave back.", "Vanessa");
                        add_page("And with everything here, I should be able to finally understand it all but...", "Vanessa");
                        add_page("It just feels impossible to accept denial, I guess.", "Vanessa");
                        add_page("Denial isn't something you merely accept, Vanessa.", "Old Man");
                        add_page("It's something you push past.", "Old Man");
                        add_page("To accept denial is to acknowledge it. To acknowledge it is to lend it your thoughts, which may hinder your actions.", "Old Man");
                        add_page("And your actions are what truly matter.", "Old Man");
                        add_page("Actions lead us into the welcoming arms of fate, so we might be nestled or hurled into uncertainty.", "Old Man");
                        add_page("And uncertainty is exactly where denial dares not to tread.", "Old Man");
                        add_page("For if denial began to feel uncertain...", "Old Man");
                        add_page("Well, it'd all fall apart, wouldn't it?", "Old Man");
                        add_page("...Yeah. I guess it would.", "Vanessa");
                        add_page("I guess I'll have to remember that.", "Vanessa");
                        add_page("I...", "Old Man");
                        add_page("I fear you won't be able to.", "Old Man");
                        add_page("Assuming you receive the Angel's Blessing, your memories of this plane will fade as if it was nothing more than an empty thought.", "Old Man");
                        add_page("...But know this.", "Old Man");
                        add_page("Your denial has proven itself to be friable. Under the right pressure, it will begin to feel uncertain.", "Old Man");
                        add_page("And in that moment, I know you will seize your opportunity to push past it, and see what you truly need to see.", "Old Man");
                        add_page("...Okay. Thanks.", "Vanessa");
                        add_page("It is my duty and my pleasure.", "Old Man");
                        break;
                    case UnknownEnum.Value_3:
                        add_page("...Sniffle...", "Fritz");
                        add_page("...Feel no need to hold your tears. You've achieved no small feat, and you are more than welcome to confide in me.", "Old Man");
                        add_page("N-No... That's quite alright... It's just...", "Fritz");
                        add_page("I CAN'T BELIEVE IT'S ALREADY OVER!", "Fritz");
                        add_page("Ah.", "Old Man");
                        add_page("I don't mean to rattle your brain with repetition seeing as you've surely been here decades longer than myself, but GOOD GOD!", "Fritz");
                        add_page("Just when you think you've finally hit the climax, this place tells you to sit down and SHUT UP, because it hasn't even passed the previews.", "Fritz");
                        add_page("It's like it was MADE for me! As a birthday present! By Saint Nicholas! On New Years!", "Fritz");
                        add_page("...In a way, it was made for all of us.", "Old Man");
                        add_page("I'll BEG you to elaborate.", "Fritz");
                        add_page("That won't be necessary.", "Old Man");
                        add_page("The Tower remains as tumultuous as yourself. Never content to remain static amongst the sins that built it.", "Old Man");
                        add_page("For each tragedy that has befallen the wayward souls it overshadows, another layer is born.", "Old Man");
                        add_page("It serves as a monument to the horrors we have experienced, to remind us of what this chain has wrought by our hands.", "Old Man");
                        add_page("...It used to be much, much smaller.", "Old Man");
                        add_page("Ah, how time does dance around us all...", "Fritz");
                        add_page("But we dance at a higher tempo! One unmatched by something as blasé as a \"universal constant\".", "Fritz");
                        add_page("Ah... If I knew no better, I'd envy you. Maybe even stay down here myself!", "Fritz");
                        add_page("...Your company, though uproarious, would be more than welcome.", "Old Man");
                        add_page("Oh, please. I know what I am, and I'm A LOT!", "Fritz");
                        add_page("But it's... truly appreciated.", "Fritz");
                        add_page("And I'd take you up on the offer, but I'm by no means done with my time on the mortal plane!", "Fritz");
                        add_page("I have mountains to climb! Animatronics to encounter! Bills to NOT pay!", "Fritz");
                        add_page("...And it'll always be waiting for me when I'm found decapitated in the supermarket's frozen goods aisle.", "Fritz");
                        add_page("Y-...I-...Hm.", "Old Man");
                        add_page("...Oh, look, we're already here. Parting is such sweet sorrow. Let's go.", "Old Man");
                        break;
                    case UnknownEnum.Value_4:
                        add_page("...This realm is utterly twisted.", "Michael");
                        add_page("I've known much about my father's misdeeds, and what they've brought upon others.", "Michael");
                        add_page("But this...staring into the jaw of the beast itself?", "Michael");
                        add_page("...It's a reminder that my duty is far from over.", "Michael");
                        add_page("...A duty, you say?", "Old Man");
                        add_page("A task that awaits you in the waking world, I assume.", "Old Man");
                        add_page("I've taken it upon myself to ensure that I might make up for...foul deeds.", "Michael");
                        add_page("From your forlorn tone, I take it's been a rather arduous task.", "Old Man");
                        add_page("...Yes.", "Michael");
                        add_page("But it's one that I need to face against any better judgement.", "Michael");
                        add_page("It's no one's fault but my own, and for it I have to push myself to my limits. No matter what suffering I must undertake..", "Michael");
                        add_page("I won't rest until all is made right. All that needs to be, at least..", "Michael");
                        add_page("Your actions, though commendable, leave resentment and fear lingering within.", "Old Man");
                        add_page("...Why is it yourself who must take such a heavy burden?", "Old Man");
                        add_page("...", "Michael");
                        add_page("...If it's a blight on your being that stills your tongue, then it may not be an undertaking you can carry alone.", "Old Man");
                        add_page("...No. It has to be me.", "Michael");
                        add_page("If I had quit now, then all of my efforts would be forfeit.", "Michael");
                        add_page("...I owe far too much to let that happen.", "Michael");
                        add_page("Who is it to decide what you might owe to another?", "Old Man");
                        add_page("Is it yourself? Or perhaps the unspoken remorse that may guide you along these pursuits?", "Old Man");
                        add_page("It's only by scouring the meaning of \"enough\" that we are able to understand what drives us to such means.", "Old Man");
                        add_page("Because if we know what is enough, we'll know what ends must be weathered through to achieve penance.", "Old Man");
                        add_page("...You've quite an opinion on this topic, hm?", "Michael");
                        add_page("Take not my words for truth, but for counsel in your distress.", "Old Man");
                        add_page("It's best to steady your spirit before meeting the Angel, after all.", "Old Man");
                        add_page("...Yes. I suppose you're right.", "Michael");
                        add_page("Though, I have one final question if you will entertain it.", "Michael");
                        add_page("I do all that is asked, for it's all I can do.", "Old Man");
                        add_page("If you're a lost spirit in the same vain as those who ascend this tower, then why haven't you joined them?", "Michael");
                        add_page("...", "Old Man");
                        add_page("A heavy question.", "Old Man");
                        add_page("Though I've no time for a heavy answer.", "Old Man");
                        add_page("We float along the same tide, Michael.", "Old Man");
                        add_page("I have sins to atone, but time is not on my side.", "Old Man");
                        add_page("I have not earned this right. To join your ranks in the Angel's warmth.", "Old Man");
                        add_page("Not yet.", "Old Man");
                        add_page("I have a duty. A purpose. One that I welcome, in hopes it might prove me to be a better man.", "Old Man");
                        add_page("...Hmph.", "Michael");
                        add_page("From my perspective...", "Michael");
                        add_page("Well, we're in the same boat, aren't we?", "Michael");
                        add_page("...Heh.", "Old Man");
                        add_page("I suppose so.", "Old Man");
                        break;
                    case UnknownEnum.Value_5:
                        add_page("Ough... my head hurts...", "Vannabelle");
                        add_page("...After today, I don't think I ever want to see any of those stupid animals ever again.", "Vannabelle");
                        add_page("That's a rather common sentiment for those who have reached this point.", "Old Man");
                        add_page("No, I don't think you understand. I used to be OBSESSED with these guys. OBSESSED.", "Vannabelle");
                        add_page("It was all I ever talked about, all I ever DID...at a certain point it kinda, just...BECAME me.", "Vannabelle");
                        add_page("I can't believe THIS is what I lost so many of my friendships to...", "Vannabelle");
                        add_page("...Oh god. Do you think how I felt climbing this tower is how they must've felt listening to me? Oh god.", "Vannabelle");
                        add_page("...These interests you speak of, though racous, are what make the parts of life worth living, are they not?", "Old Man");
                        add_page("If the Angel sees fit...perhaps you may seek new ones once you return to the mortal world.", "Old Man");
                        add_page("Yeah... Yeah! I-I like other things! There's gotta be some other fandom I can get into!", "Vannabelle");
                        add_page("...Fandom? That is a word rather...foreign to my ears.", "Old Man");
                        add_page("...Oh, yeah, i-it's like, um...", "Vannabelle");
                        add_page("...A group of people who are all, like, SUPER into something!", "Vannabelle");
                        add_page("Like, think of something you like, and think of a bunch of people coming together to talk about how much they enjoy it! It's like that!", "Vannabelle");
                        add_page("I...see...", "Old Man");
                        add_page("...Is there a fandom for fishing?", "Old Man");
                        add_page("...If there is, I might need to get into it.", "Vannabelle");
                        break;
                    case UnknownEnum.Value_8:
                        add_page("Bahaha! Easy peasy garlic squeezy! I owned those metalheads! In fact, I STILL own them! Legally! WAHAHA!!", "The Boss");
                        add_page("...", "Old Man");
                        add_page("Bah, can't wait to get out of this dump and get back to the dump I can make money off of!", "The Boss");
                        add_page("Your jubilance is certainly palpable.", "Old Man");
                        add_page("Do you...feel that you've learned anything from this?", "Old Man");
                        add_page("Nyah? Learned anything...?", "The Boss");
                        add_page("Oh, oh yeah! I learned that I should buy out this Candy's place! And maybe that Popgoes guy too!", "The Boss");
                        add_page("I'll form a MEGA MONOPOLY on these joints! And when they stop being profitable, I'll sell 'em all for scrap!", "The Boss");
                        add_page("Ka-POW! I'm a GENIUS!!", "The Boss");
                        add_page("...I see.", "Old Man");
                        add_page("You're...aware of this event's significance to your fate, surely.", "Old Man");
                        add_page("To meet with the Angel is to lie your feats bare in the eyes of Judgement itself.", "Old Man");
                        add_page("Your selflessness will dance alongside your vanity. Your ego will expose your greed and envies.", "Old Man");
                        add_page("And if the Angel so sees fit, you may return to the life you once had...", "Old Man");
                        add_page("Or face an eternity of a fate the mere thought neither of us may wish to entertain.", "Old Man");
                        add_page("You may want to take this opportunity to reflect on your actions... as it may be the last chance you get.", "Old Man");
                        add_page("...BAHAHAHAHA!! Oh, that's PRICELESS!! WAHAHAHAHAHAHA!!", "The Boss");
                        add_page("Listen up, chump! I'll say it loud to get it through that cloak of yours!", "The Boss");
                        add_page("I'm-a The Boss! I don't FEEL like dying yet, so I'm not letting death lay a finger on me!", "The Boss");
                        add_page("Try and send me to Hell and I'll just climb out with my COLD GLOVED HANDS!! AAAHAAHAA!!", "The Boss");
                        add_page("(...Is...Is he serious?)", "Old Man");
                        break;
                    case UnknownEnum.Value_6:
                        add_page("This ride's gonna take a bit, right?", "Clark");
                        add_page("...I'm gonna get comfortable.", "Clark");
                        add_page("Do as you please.", "Old Man");
                        add_page("Clark laid back with his arms behind his head, staring up at the sky.", "");
                        add_page("He let out a deep sigh, and shut his eyes.", "");
                        add_page("...", "");
                        add_page("...He began rolling around trying to find a comfortable position.", "");
                        add_page("I apologize, my...boat is not particularly designed for comfort.", "Old Man");
                        add_page("Eh. I just wanna enjoy the ambience.", "Clark");
                        add_page("Rare for me to get a break from the sound of crashing metal and electric sparks.", "Clark");
                        add_page("...There's... Nothing you wish to talk about? Nothing troubles you?", "Old Man");
                        add_page("Oh, god no. Of course there's something troubling me.", "Clark");
                        add_page("But there's no point getting up in arms about it. The answer won't really matter.", "Clark");
                        add_page("I'm gonna receive my judgement. And from there, who knows. Life will go on.", "Clark");
                        add_page("I can't solve every little mystery, especially not with THIS damn company. I just ain't smart enough.", "Clark");
                        add_page("Whatever's up with this place...someone else can exhaust themselves trying to figure it out.", "Clark");
                        add_page("Me? I've either got friends to get back to, or I've got the rest of eternity to get on with.", "Clark");
                        add_page("And until then... I'm gonna savor the sound of these waves.", "Clark");
                        add_page("...As you wish.", "Old Man");
                        break;
                    case UnknownEnum.Value_7:
                        add_page("Woah... wicked cool boat, dude! It's rustic as all get out!", "Frank");
                        add_page("You catch any cool fish in this freaky river?", "Frank");
                        add_page("The water is quite shallow, I'm afraid. My hook merely bobs against the waves.", "Old Man");
                        add_page("...How familiar are you with fishing?", "Old Man");
                        add_page("I've done plenty of it in video games! You ever play Deedee Dredge before? That game is great!", "Frank");
                        add_page("...I may have aaalso tried Fishing With Candy once, but don't let the bossman hear that...", "Frank");
                        add_page("...Say... What's YOUR favorite game, sage guy?", "Frank");
                        add_page("I've not permitted myself a moment for leisure for quite some time...besides fishing, of course.", "Old Man");
                        add_page("Though... I do suppose I'm quite fond of backgammon.", "Old Man");
                        add_page("Oh man, you can't beat the classics! I like the one with all those grids and stats and those freaky twenty-sided dice!", "Frank");
                        add_page("...You probably haven't tried any of the arcade games here, though, huh?", "Frank");
                        add_page("...I tried, once.", "Old Man");
                        add_page("I didn't understand what was happening, and then I lost. Called me something rash and crude.", "Old Man");
                        add_page("...I didn't care for it. It wasn't made for my time, it seems.", "Old Man");
                        add_page("Awww, whaaat!", "Frank");
                        add_page("Next time I'm here, remind me to teach you the ropes! Seriously!", "Frank");
                        add_page("...\"Next time\"?", "Old Man");
                        break;
                    case UnknownEnum.Value_10:
                        add_page("...", "Henry");
                        add_page("I see the monuments have attracted your gaze.", "Old Man");
                        add_page("Worry not, they're nothing more than an effigy etched in stone.", "Old Man");
                        add_page("...They won't move.", "Old Man");
                        add_page("...Of course. O-Of course, it's silly to think...that...", "Henry");
                        add_page("...Ehm- why DO they look the way they do?", "Henry");
                        add_page("Their designs remain foreign to me. Yet another mystery to this plane shrouded in another soul's misery.", "Old Man");
                        add_page("...Are they familiar to you?", "Old Man");
                        add_page("...Kind of. They just...remind me of my daughter, that's all.", "Henry");
                        add_page("Have you grown distant?", "Old Man");
                        add_page("I...I suppose in a way. She passed on when she was...very young.", "Henry");
                        add_page("I had spent a great, great portion of my life trying to help her and others move on, but...", "Henry");
                        add_page("...Well, I suppose I got too in over my head, and I wound up here.", "Henry");
                        add_page("...And \"here\" is a mystery in itself. Time doesn't move like our own, but it isn't exactly anchored either.", "Henry");
                        add_page("It's like we've been put off to the side. A place where people can meet, no matter the difference in time apart in the living world.", "Henry");
                        add_page("I've met so many people. Strange, complicated people. Some who know my name, and others who've grown to hate it.", "Henry");
                        add_page("I've been beset with sorrow that I could not meet them under better circumstances.", "Henry");
                        add_page("If only I knew. If only I was able to lift them up into my arms, and welcome them into the company. MY company.", "Henry");
                        add_page("...If only I didn't lead it down a darker path just to keep it alive. To make sure that MY work wouldn't disappear, even if it...", "Henry");
                        add_page("...I suppose that's just one of my many regrets.", "Henry");
                        add_page("Regrets are thoughts most venomous, but ones we must learn to welcome as what they are.", "Old Man");
                        add_page("They're proof of our growth. Proof that though we might carry the bulk of mourning, it does not go without the counterweight of purpose.", "Old Man");
                        add_page("If we had no regrets, we wouldn't know what to learn. If we didn't know what to learn, then we would never better ourselves.", "Old Man");
                        add_page("Sometimes the pain and displeasure that we feel can illuminate the way to brighter paths.", "Old Man");
                        add_page("...You're right. I just don't know how long it'll take me to accept that.", "Henry");
                        add_page("But thank you.", "Henry");
                        add_page("...It's not necessarily myself you should thank.", "Old Man");
                        add_page("These thoughts were imparted upon me by a young soul, one that has rarely passed through since.", "Old Man");
                        add_page("...I might've dressed up her vocabulary a little, but she knew her words were true all the same.", "Old Man");
                        add_page("She spoke of helping others, and would pass through this plane and yours at her leisure.", "Old Man");
                        add_page("While uncommon that one might make repeated visits to this domain, it's not unheard of.", "Old Man");
                        add_page("...Who was she?", "Henry");
                        add_page("I had never caught her name in the time we knew each other.", "Old Man");
                        add_page("She was a small girl, though. No older than 7, and wore a sweater just a size too large.", "Old Man");
                        add_page("...And had a little...button nose...?", "Henry");
                        add_page("...One could say.", "Old Man");
                        add_page("...I'm apprehensive to hold onto the belief that girl could've been my daughter...", "Henry");
                        add_page("But maybe that little hope is what I need to have the strength to pull through.", "Henry");
                        add_page("Henry, this strength you speak of has been embedded in your soul for a long time.", "Old Man");
                        add_page("I know this to be true, for without it...", "Old Man");
                        add_page("You might've never scaled this tower in the first place.", "Old Man");
                        break;
                    case UnknownEnum.Value_11:
                        add_page("You know, I have some harsh words for this \"Angel\" once I finally face them.", "William");
                        add_page("To take my creations- my LEGACY, and turn it against me?", "William");
                        add_page("It's a mockery... and one I will NOT take sitting down.", "William");
                        add_page("Don't stand on my boat.", "Old Man");
                        add_page("I'll do as I please! Do you have any idea who I am?", "William");
                        add_page("I practically built this world with my own two hands, with all they've plagiarized!", "William");
                        add_page("And the nonsense they've created is a bastardization of my vision!", "William");
                        add_page("\"Candy the Cat\". \"Morse the Mole.\" And don't even get me started on \"Trash and the Gang\"!", "William");
                        add_page("They have no respect for me... Just envy.", "William");
                        add_page("Oh, but they don't know who they're messing with! This is far from my first resurrection, and it won't be my last!", "William");
                        add_page("Yes, and I ALWAYS-.", "William");
                        Skip[TextPageNumber - 1] = true;
                        add_page("But it's different, ain't it?", "Old Man");
                        add_page("...What?", "William");
                        add_page("This ain't a second chance.", "Old Man");
                        add_page("It's judgement.", "Old Man");
                        add_page("Judgement for the kind of man you are. Judgement for the kind of man you make others. Judgement for you.", "Old Man");
                        add_page("...You don't know me.", "William");
                        add_page("No...", "Old Man");
                        add_page("...But I know your legacy.", "Old Man");
                        add_page("...Row your silly boat.", "William");
                        add_page("As you wish.", "Old Man");
                        break;
                    case UnknownEnum.Value_12:
                        add_page("Phew... Back to normalcy, I suppose!", "Edwin");
                        add_page("I still can't believe what they did to my creations...I should've known nothing good would've come from those traitors.", "Edwin");
                        add_page("I mean, WHO thought teaching Jugband Hippo to speak was a good idea? His silence was the whole core of his appeal!", "Edwin");
                        add_page("Ohh, when I meet those jerks again, boy am I gonna...", "Edwin");
                        add_page("Don't get too ahead of yourself. The Angel still has yet to judge you.", "Old Man");
                        add_page("...Ah, yes, of course, of course...", "Edwin");
                        add_page("...", "Old Man");
                        add_page("...The company founders, yes?", "Old Man");
                        add_page("...Huh?", "Edwin");
                        add_page("Those...\"traitors\" you mentioned. I believe I've seen those two traversing these depths as well.", "Old Man");
                        add_page("I would've figured you gave them a piece of your mind already.", "Old Man");
                        add_page("Oh, Will and Hen? Oh, no no no, THOSE guys are reliable. I know they would never do anything so horrible. We were close friends, after all!", "Edwin");
                        add_page("Ah, I see.", "Old Man");
                        add_page("Phew... Well, if it's anything...I guess I'm at least happy they never laid a hand on M2.", "Edwin");
                        add_page("Ah, yes.", "Old Man");
                        add_page("...You know, quite the violent streak that one has. I believe I've seen more souls fall to that one than any other.", "Old Man");
                        add_page("A-Ah! Well, I'm, uh...flattered?", "Edwin");
                        add_page("J-Just so you know, the REAL M2 would NEVER behave like that. ...Though it'd never behave the way I wanted it to, either...", "Edwin");
                        add_page("B-But, really, this Angel's got a sick sense of humor making it act like that! Do they have some kinda vendetta against me too?", "Edwin");
                        add_page("The Angel has never been one to hold grudges...as long as I've known them, at least.", "Old Man");
                        add_page("This realm may not be true to life... but it is true to the perceptions of those who fall here. It simply reflects what those of us impress upon it.", "Old Man");
                        add_page("...Much like your creation, am I correct?", "Old Man");
                        add_page("W-Woah, hey! You...that's not true! You don't really think I taught it to act like that, do you!?", "Edwin");
                        add_page("Well, I couldn't say for sure... I know not who you were before you arrived here, and I prefer not to assume.", "Old Man");
                        add_page("...The Angel, however, should be well familiar with all you've done.", "Old Man");
                        add_page("...", "Edwin");
                        break;
                    case UnknownEnum.Value_13:
                        add_page("...Snf...", "Fiona");
                        add_page("Oh, goodness. Look at me, I'm a mess!", "Fiona");
                        add_page("These trials have taken their toll on you, I see.", "Old Man");
                        add_page("Well, it's been a nightmare, that's for sure.", "Fiona");
                        add_page("But at the same time it's like a dream come true.", "Fiona");
                        add_page("...How so?", "Old Man");
                        add_page("Well, this whole place is like one big fun park! It's thrill ride after thrill ride, all wrapped up in these colorful characters.", "Fiona");
                        add_page("They're...ALIVE! They've moving right before my eyes! Sure, they're trying to kill me, but...", "Fiona");
                        add_page("The characters were always my favorite part, y'know? Givin' them their own little sparks and personalities.", "Fiona");
                        add_page("Then there was Edwin. With his bits and bobs, his own little spark, in a way. Always wrapped up in his knickknackatory, making the next big thing!", "Fiona");
                        add_page("...Yeah...", "Fiona");
                        add_page("C-Can you do something for me, mister?", "Fiona");
                        add_page("I may try my best.", "Old Man");
                        add_page("We used to leave these little voice recordings to eachother- Edwin and I. And sometimes I would listen back to them when I was feeling low...and...", "Fiona");
                        add_page("It doesn't matter if it's a little white lie, I'd just like to hear someone else saying it's going to be okay.", "Fiona");
                        add_page("You get tired of hearing your own voice after a while.", "Fiona");
                        add_page("...I don't care for lying anymore, Mrs. Murray.", "Old Man");
                        add_page("...Okay. Okay...", "Fiona");
                        add_page("So, know my voice rings true when it has been my pleasure to guide you across these waters.", "Old Man");
                        add_page("In a long line of confused and irritated souls, your kindness shines brighter than all.", "Old Man");
                        add_page("If you are not deserving of the Angel's blessing, then I fear none of us will be.", "Old Man");
                        add_page("O-oh! I- well thank you! I-...", "Fiona");
                        add_page("Goodness, now you've got me all giddy!", "Fiona");
                        add_page("Then put your spirit to good use.", "Old Man");
                        add_page("The time is upon us.", "Old Man");
                        break;
                    case UnknownEnum.Value_15:
                        add_page("...Ugh...", "Cassie");
                        add_page("...", "Old Man");
                        add_page("...UGH...", "Cassie");
                        add_page("...", "Old Man");
                        add_page("...AUUUUUUUUUGH...", "Cassie");
                        text_effect(0, 200, "Shake");
                        add_page("...Does something trouble you?", "Old Man");
                        add_page("...I don't think you'd get it.", "Cassie");
                        add_page("It's rare that I'm unable to sympathize with those who join me on this voyage.", "Old Man");
                        add_page("Though I may not have all the answers, I might elucidate the path to find them yourself.", "Old Man");
                        add_page("You...use a lot of old words.", "Cassie");
                        add_page("I suppose I do.", "Old Man");
                        add_page("N-Not in a bad way! It's just...", "Cassie");
                        add_page("Augh, I dunno. Things like to just jump to the front of my head, and before I know it they're climbing out of my mouth!", "Cassie");
                        add_page("Everyone says I talk too much. I overheard some of the other kids calling me \"Chatty Cassie\".", "Cassie");
                        add_page("A-And I hate it! I just want to be a part of things, but they always shove me out of everything for no reason!", "Cassie");
                        add_page("No one wants to give me the time of day unless they want something from me, and even then it's just because of my DAD!", "Cassie");
                        add_page("\"Cassie, can your dad get us some free stuff?\" \"Cassie, can your dad hijack the arcades?\" \"Cassie, can your dad make Freddy say a swear?\"", "Cassie");
                        add_page("And it's like...NO! He can't! He's just a technician! But they don't care! They just see some kid they can use for free stuff!", "Cassie");
                        add_page("AUGH!!! It's just so...FRUSTRATING!", "Cassie");
                        add_page("...And you consider these kids to be your friends?", "Old Man");
                        add_page("No! Not at all! They sure don't think of me as one, they didn't even come to my birthday party!", "Cassie");
                        add_page("...The only friend I have is Gregory, but he's...well...", "Cassie");
                        add_page("...Though company may be sour, it's company that we must treasure.", "Old Man");
                        add_page("To be swept along through waves of great hardship is a trial that all must learn to overcome. ", "Old Man");
                        add_page("Do not forgo the memories of what linked your amity.", "Old Man");
                        add_page("You might find the spark will glow much brighter if you remember what brought you together.", "Old Man");
                        add_page("...I mean...We both like Freddy's, I guess?", "Cassie");
                        add_page("But it's not like we like them...TOGETHER? It's just...\"Hey, you like these guys! We should go see them!\"", "Cassie");
                        add_page("...And then he just leaves like the rest once he finds something cooler. He didn't even bother to stick around with me once we got down here.", "Cassie");
                        add_page("...This boy you speak of roams this realm?", "Old Man");
                        add_page("If you've seen a kid huddled up in Glamrock Freddy's stomach hatch, that's the one.", "Cassie");
                        add_page("...The one that STOLE my WALLET?", "Old Man");
                        add_page("...Probably.", "Cassie");
                        add_page("Oh, Cassie...", "Old Man");
                        add_page("Life has...a great deal of hardships. More than anyone, they might hinder the young, for it is all they could know.", "Old Man");
                        add_page("But know that it does not mean that this is all that's waiting for you.", "Old Man");
                        add_page("Though your memories of this experience might fade, it's imperative to know the imprint it marks on your soul.", "Old Man");
                        add_page("Such a mark is not one that may easily fade. Through trials and tribulations, I believe that you're able to persevere as you have today.", "Old Man");
                        add_page("You might come across those who you'd find a great kinship with, in the strangest of places.", "Old Man");
                        add_page("...Perhaps you already have.", "Old Man");
                        add_page("...I guess some of the other people have been...kinda nice?", "Cassie");
                        add_page("...Yeah. Yeah! You know what? You're right!", "Cassie");
                        add_page("If...if I can make friends in the depths of heck, I'm sure I'll find...SOMEBODY out there!", "Cassie");
                        add_page("Somebody who...won't sic a lethal cleaning robot on me. Or cut an elevator's cables while I'm still in it.", "Cassie");
                        add_page("Good. Keep your spirit high.", "Old Man");
                        break;
                    case UnknownEnum.Value_16:
                        add_page("...You realize your shaking causes more ripples in these waves than my boat ever could.", "Old Man");
                        add_page("I'M SORRY!", "Hudson");
                        add_page("P-P-Please just let me be, man...", "Hudson");
                        add_page("I-I don't want any trouble, I just need this over with.", "Hudson");
                        add_page("Hm. The appraisal of one's soul is rarely serendipitous, but...", "Old Man");
                        add_page("Surely you realize concealing these fears will do you no good against the Angel, correct?", "Old Man");
                        add_page("I'm not listening. I'm not listening.", "Hudson");
                        add_page("So you say, but you cannot deny what will soon be before you.", "Old Man");
                        add_page("The Angel is forgiving, but never ignorant.", "Old Man");
                        add_page("To hide in your own shell would do nothing to evade their scornful eye, for they know all.", "Old Man");
                        add_page("J-Just...stop...talking...", "Hudson");
                        add_page("I will not, for it's a ponderous truth I must impart upon you.", "Old Man");
                        add_page("Heavy handed it may be, you stand before me shaken and AFRAID.", "Old Man");
                        add_page("This will be the judgement of your actions, wicked or kind, and what they have brought in their wake.", "Old Man");
                        add_page("To live in your fear is to live in your own denial, trying to find safety where there is none.", "Old Man");
                        add_page("If you blind yourself to the connotations of these deeds, you might as well admit your GUILT to the A-", "Old Man");
                        add_page("JUST SHUT THE HELL UP!", "Hudson");
                        add_page("I'm HORRIFIED! I'm SCARED! Is THAT what you wanna hear?", "Hudson");
                        add_page("Because I did EVERYTHING I was supposed to do, and now you're just-", "Hudson");
                        add_page("YOU'RE BEING A JERK!", "Hudson");
                        add_page("I don't know what this Angel is gonna think of me, and I DON'T CARE ANYMORE!", "Hudson");
                        add_page("I'm ALREADY judged for the past, and never given a FREAKING CHANCE!", "Hudson");
                        add_page("So I don't care if it HATES me, I'm USED TO IT ALREADY!", "Hudson");
                        add_page("I know what I DID, and I-I CRUSHED IT!", "Hudson");
                        add_page("YEAH! The odds were STACKED against me, the WORLD was beating down on me at EVERY. TURN.", "Hudson");
                        add_page("And. I. SURVIVED. I did what I HAD TO DO to SURVIVE.", "Hudson");
                        add_page("Is that so WRONG?! What right do YOU have to just- just SIT there and tell me what I can and cannot do?!", "Hudson");
                        add_page("As if you did the same thing!? As if YOU have experienced EVERYTHING I went through to get here!", "Hudson");
                        add_page("You WEREN'T THERE. And you have NO IDEA what it was LIKE!", "Hudson");
                        add_page("So talk in your STUPID BIG WORDS, because I'm not SCARED anymore!", "Hudson");
                        add_page("I'm HERE! I'm READY! I'm gonna show that Angel WHO I AM!", "Hudson");
                        add_page("So are you HAPPY NOW?!", "Hudson");
                        add_page("...Yes.", "Old Man");
                        add_page("W-What.", "Hudson");
                        add_page("The proof of your fervor was the only thing I needed.", "Old Man");
                        add_page("Your words, though harsh, were from deep within. An element that you keep buried in denial and fear.", "Old Man");
                        add_page("I needed you to see it for yourself before the time was too late.", "Old Man");
                        add_page("I can only hope that you can forgive my...assertive approach.", "Old Man");
                        add_page("...Y-You SUCK, man.", "Hudson");
                        break;
                    case UnknownEnum.Value_17:
                        add_page("So...", "Mary");
                        add_page("Did the cloak come with the boat, or...did you make it yourself?", "Mary");
                        add_page("...", "Old Man");
                        add_page("I mean, c'mon! I dig the reaper schtick, really, but you gotta admit it's a little on the nose.", "Mary");
                        add_page("You've even got your own River Styx and everything, man!", "Mary");
                        add_page("You'll find my attire serves its purpose well, and serves as nothing more.", "Old Man");
                        add_page("Yeah, right, I'm sure. Just whatever was laying around, right?", "Mary");
                        add_page("Not like there's a lack of junk around here, anyhow.", "Mary");
                        add_page("...Cool stuff, too...", "Mary");
                        add_page("Hey, do you think anyone would notice if I...", "Mary");
                        add_page("Y'know. Yoink?", "Mary");
                        add_page("Unfortunately, even if one were to turn a blind eye, the relics of this place will not join you...topside.", "Old Man");
                        add_page("Man, why's all the cool stuff saved for the dead dudes?", "Mary");
                        add_page("Like, I know NORMAL people aren't into that kinda stuff, but come on!", "Mary");
                        add_page("Skulls! Ghosts! Bile! Gross stuff like that's got its charm.", "Mary");
                        add_page("Forgive my tone, but I must inquire. You're...rather young to be so invested in the matters of the macabre.", "Old Man");
                        add_page("Man, how old do you think I am?", "Mary");
                        add_page("Listen, I'm not just some punk kid, alright? I had to go to church! I've heard some pretty grody stuff.", "Mary");
                        add_page("But this deals with matters beyond religious text. You're soon to meet with the real thing, face to face.", "Old Man");
                        add_page("Oh my god, it's not the first time I'm seeing a dead dude, okay?! It's...", "Mary");
                        add_page("It's not. It's not gonna be the last, probably. Everything dies.", "Mary");
                        add_page("EveryONE dies. You can't stop it. Even if they say they won't.", "Mary");
                        add_page("...So I might as well get used to it. Find some good in the bad.", "Mary");
                        add_page("Even if people think it's weird, or gross, or whatever! I like it!", "Mary");
                        add_page("So it doesn't matter...", "Mary");
                        add_page("...", "Old Man");
                        add_page("*Snf*. God, what are you, my therapist?", "Mary");
                        add_page("You don't need to know all this crap.", "Mary");
                        add_page("I suppose I do not, but sometimes these things need to be said.", "Old Man");
                        add_page("They need to be said to someone who will listen, even if they're nothing more than a passing face.", "Old Man");
                        add_page("To know another shares your burden, the point of view that has tied you down...", "Old Man");
                        add_page("It's not just yourself who must carry this hardship, Mary. And it never has to be.", "Old Man");
                        add_page("...", "Mary");
                        add_page("...I will say, the boat is of my own design.", "Old Man");
                        add_page("Bits and pieces, found here and there. Styled after a ferryboat I'd seen when I was rather young.", "Old Man");
                        add_page("Not in person, mind you. Painting of a man clad in a black robe, floating down a river of souls...", "Old Man");
                        add_page("...Heh. I freakin' knew it, dude.", "Mary");
                        break;
                    case UnknownEnum.Value_18:
                        add_page("Fascinating, your boat appears to be...handcrafted...rickety...? UNSTABLE!", "Strings");
                        add_page("Hey! You'd best sit down, or this rickety boat will plunge us both into these depths!", "Old Man");
                        add_page("No. NO! NOT WATER! Must maintain a secure balance, or else-", "Strings");
                        add_page("Gyroscopic stabilizer stabilizing...stabilizing...AND WE'RE STABLE!", "Strings");
                        add_page("YES, yes. I'm sure one of us is.", "Old Man");
                        add_page("Now PLEASE, relax yourself. For your sake and mine.", "Old Man");
                        add_page("...Just let the tides take us where we need to be.", "Old Man");
                        add_page("Say no more! I'll spend my time reviewing my MANY notes...", "Strings");
                        add_page("Hmmm... Maximized power usage by...", "Strings");
                        add_page("...Denied entry...no more than...", "Strings");
                        add_page("...Your disposition is no less neurotic than a newborn fawn, but it's served you well.", "Old Man");
                        add_page("...Purchase optimized...", "Strings");
                        add_page("...Equations...equationing...", "Strings");
                        add_page("However, I cannot say how it will fare in the judgement of your soul before the Angel's final say.", "Old Man");
                        add_page("...Annotating victorious shouts...", "Strings");
                        add_page("...Soul?", "Strings");
                        add_page("Soul. You said soul.", "Strings");
                        add_page("That I did.", "Old Man");
                        add_page("I wasn't assembled with a soul. I'm artificial. I'm- I'm just a machine.", "Strings");
                        add_page("I was crafted by man's hand, but I remain a mere echo of sentience.", "Strings");
                        add_page("This angel, it doesn't WANT me! I'm not organic, I'm not meat! I'M-I'M NOT HUMAN!", "Strings");
                        add_page("And if I have no soul...and I'm not human...", "Strings");
                        add_page("What delineates me from the haywire specimens roaming this tower?", "Strings");
                        add_page("I- I'm not going to leave, am I? I'm STUCK here, with YOU and those- those-...!", "Strings");
                        add_page("...What's my purpose, if not to leave? To suffer? To die?", "Strings");
                        add_page("I don't want to die. I DON'T WANT TO DIE!.", "Strings");
                        Skip[TextPageNumber - 1] = true;
                        add_page("NOW HOLD YOURSELF! You'd be best to listen to me, and listen well.", "Old Man");
                        add_page("The soul is not denoted by the shell it may find itself in.", "Old Man");
                        add_page("Whether one was birthed in flesh or forged by steel, that is not what creates the soul.", "Old Man");
                        add_page("No, it is not the shell you find yourself in that makes the soul, it's the DRIVE!", "Old Man");
                        add_page("...My...C-Drive?.", "Strings");
                        Skip[TextPageNumber - 1] = true;
                        add_page("NO!", "Old Man");
                        add_page("IT'S DESIRE! The desire to ACT! To EXIST! Your very presence here proves it.", "Old Man");
                        add_page("You've made it past the trials before you, and find yourself at the very precipice of your journey.", "Old Man");
                        add_page("Through quaking hands, you've pushed yourself beyond what some men have killed for.", "Old Man");
                        add_page("There's no time to question what is right and wrong, because you define it.", "Old Man");
                        add_page("A soul is everything you are, and everything you need it to be.", "Old Man");
                        add_page("You define the answer for yourself, and none may tell you otherwise.", "Old Man");
                        add_page("For you are the soul, and the soul is you.", "Old Man");
                        add_page("...And you'd never hold yourself back, would you?", "Old Man");
                        add_page("...I'm programmed to achieve my goal, no matter the...limitations...obstacles...", "Strings");
                        add_page("...No matter the cost.", "Strings");
                        add_page("...Good. Now you must prove these words to be true to me and yourself.", "Old Man");
                        add_page("For we have arrived.", "Old Man");
                        break;
                    case UnknownEnum.Value_19:
                        add_page("You know, at the risk of sounding ungrateful, I was expecting a little more from you.", "Sally");
                        add_page("...Is my guidance across these waters too little for you?", "Old Man");
                        add_page("Well it's not exactly the least you could've done. No offense.", "Sally");
                        add_page("I mean, YOU had to climb to get up here too, right?", "Sally");
                        add_page("Could've had some company, even if it's a bag of bones like yourself.", "Sally");
                        add_page("Ah, I'm afraid you're quite mistaken.", "Old Man");
                        add_page("I've yet to brave these trials myself, you see.", "Old Man");
                        add_page("I don't - What?", "Sally");
                        add_page("Wait, then how the hell did you get up here?", "Sally");
                        add_page("There are many doors deep within these halls, and I've found my means to travel them unnoticed.", "Old Man");
                        add_page("...Like through the fire exit.", "Old Man");
                        add_page("...You better be yanking my tail, or I'm about to toss you out on your fossilized ass.", "Sally");
                        add_page("Now, I'm quite truthful, but your actions do not go without purpose.", "Old Man");
                        add_page("With each floor scaled, you've shown the Angel your vigor and drive.", "Old Man");
                        add_page("Only to those who open their will truthfully will be allowed to bask in the Angel's presence.", "Old Man");
                        add_page("Uhuh.", "Sally");
                        add_page("So, wait, by that logic...YOU haven't met the Angel yet?", "Sally");
                        add_page("...", "Old Man");
                        add_page("Oh my god.", "Sally");
                        add_page("OH MY GOD, YOU'RE A SHYSTER!", "Sally");
                        add_page("Well now, I-", "Old Man");
                        add_page("This entire time, I've just been doing tricks for some old coot!", "Sally");
                        add_page("God, I feel like an idiot! You don't even know what this Angel DOES, do you?", "Sally");
                        add_page("Of course I do! The Angel's draw is far too resonant to go unnoticed!", "Old Man");
                        add_page("Their deeds ripple through this plane like a tidepool, you'd know it if you felt it!", "Old Man");
                        add_page("Well, I didn't resonate with a goddamn thing!", "Sally");
                        add_page("And how the hell would you know? You feel it in your bones?", "Sally");
                        add_page("I can't explain it! I simply can't!", "Old Man");
                        add_page("It's something that can only be experienced, and there's no better way to do it than by meeting the Angel itself.", "Old Man");
                        add_page("SURE. Whatever, man.", "Sally");
                        add_page("I'm already on your boat, we're already going there, so WHY NOT.", "Sally");
                        add_page("But if I get up there and it's asking for YOUR name, WHATEVER THE HELL IT IS, I'm coming right back down.", "Sally");
                        add_page("And I'll have...a DAMN good threat. I'm running on empty here, man.", "Sally");
                        add_page("Trust me. When the Angel casts its judgement, you'll find no reason to turn back.", "Old Man");
                        break;
                    case UnknownEnum.Value_9:
                        add_page("...I envy you, my friend.", "Old Man");
                        add_page("Billy looks up from the floorboards, tracing their grooves with his eyes.", "");
                        add_page("Some may find naivety in your simplicity. Maybe even redundancy.", "Old Man");
                        add_page("But your actions tonight have shown you in a far greater light.", "Old Man");
                        add_page("It is not mere luck that has brought you this far. Nor gullibility, or inexperience.", "Old Man");
                        add_page("It's your drive. Pure and simple.", "Old Man");
                        add_page("You have a goal. A goal that resides in the deepest crevice of your soul.", "Old Man");
                        add_page("And yet, from that crevice, it shines through brighter than any star in the sky.", "Old Man");
                        add_page("Your actions speak more than words ever could. So action you will take.", "Old Man");
                        add_page("No matter the odds, you've never wavered or stumbled.", "Old Man");
                        add_page("You've a great fire in your heart. Never take that for granted.", "Old Man");
                        add_page("Because confuse not my praise for celebration.", "Old Man");
                        add_page("Judgement is nigh. Even the most hardened of spirits may falter in the end.", "Old Man");
                        add_page("While looking forward, they may forget the rubble they leave in their wake.", "Old Man");
                        add_page("After all... Death has a shadow.", "Old Man");
                        add_page("...Oh, like the Family Guy episode!", "Billy");
                        break;
                    case UnknownEnum.Value_14:
                        add_page("Goodness! I must say, this dreadful heckscape is much more exciting than I thought!", "Elizabeth");
                        add_page("I gather from your tone you find...comfort in this realm's commodities?", "Old Man");
                        add_page("I should hope not! Though, it has been rather nice seeing those toys face-to-face!", "Elizabeth");
                        add_page("...Toys, you say?", "Old Man");
                        add_page("Yes, those silly robots! Daddy never did let me see them perform...", "Elizabeth");
                        add_page("Hm. Well, I'm sure he had your best intentions in mind.", "Old Man");
                        add_page("Oh, of course! Truthfully, I should've known better than to disobey him.", "Elizabeth");
                        add_page("In what sense?", "Old Man");
                        add_page("I simply had to see one on stage, it was ever so special! But...", "Elizabeth");
                        add_page("...Well, there's not much to tell after that.", "Elizabeth");
                        add_page("...Oh. Oh, I'm- I'm so sorry.", "Old Man");
                        add_page("It's...It's quite alright! Daddy was always the cleverest in our family. I've only myself to blame, really.", "Elizabeth");
                        add_page("I'm sure he doesn't see it that way, child. If he's half the man you say he is, he'd say quite the opposite.", "Old Man");
                        add_page("I...don't think so.", "Elizabeth");
                        add_page("...B-But Daddy truly is a wonderful sort! Even when he was terribly busy, he'd find the time to buy all manner of goodies to make up for it!", "Elizabeth");
                        add_page("The sweetest of treats and the shiniest of toys! It was like being a princess!", "Elizabeth");
                        add_page("He's quite important, you see!", "Elizabeth");
                        add_page("Heh! He'd have to be, if he is to meet the tastes of royalty such as yourself.", "Old Man");
                        add_page("Ohoho, he did much more than that!", "Elizabeth");
                        add_page("On my birthday, he'd been working on a very special surprise just for me!", "Elizabeth");
                        add_page("He built one of his toys with only the prettiest of looks, and the most wonderful of gadgets!", "Elizabeth");
                        add_page("...He must be rather sore that this place had made his crafts so silly, I'm sure.", "Elizabeth");
                        add_page("You see as the Old Man's hands shift along his oar in uncertainty and discomfort.", "");
                        add_page("...Built?", "Old Man");
                        add_page("...What's your father's name?", "Old Man");
                        add_page("William Afton! He's a robotical- A robit-... A robotics engineer!", "Elizabeth");
                        add_page("...Oh no.", "Old Man");
                        add_page("No, no, no, child. That man...", "Old Man");
                        add_page("Your father isn't the man you think he is.", "Old Man");
                        add_page("...How do you mean...?", "Elizabeth");
                        add_page("Your father was...", "Old Man");
                        add_page("...Your father is a very, very bad man.", "Old Man");
                        add_page("More know his name in curse than they do in blessing, this I know.", "Old Man");
                        add_page("Your presence in this realm, and the weight which he holds in your fate...", "Old Man");
                        add_page("...I fear he does not care for you in the way you believe.", "Old Man");
                        add_page("And he may not even notice that you're...", "Old Man");
                        add_page("...I'm so sorry.", "Old Man");
                        add_page("...", "Elizabeth");
                        add_page("...No. You're lying. You're a liar!", "Elizabeth");
                        add_page("His hands tighten on the oar, flinching as your voice hits its peak.", "");
                        add_page("I- I wouldn't-.", "Old Man");
                        Skip[TextPageNumber - 1] = true;
                        add_page("My Daddy loves me! He's just busy! Because he's so important!", "Elizabeth");
                        add_page("He buys me all the prettiest things because he loves me, and that's THAT!", "Elizabeth");
                        add_page("Your Daddy only let you play with...RUSTY NAILS!", "Elizabeth");
                        add_page("Because you're just a stupid, selfish LOWLIFE!", "Elizabeth");
                        add_page("The oar's shaft begins to splinter as his hold grows tighter.", "");
                        add_page("He stumbles over his words, as a rumbling grows in his throat.", "");
                        add_page("My Daddy is important, and special, and...", "Elizabeth");
                        add_page("And you're NOT!", "Elizabeth");
                        add_page("You're...DIRTY! And UGLY! And STINKY!", "Elizabeth");
                        add_page("YOU...You should calm yourself, child.", "Old Man");
                        add_page("Now.", "Old Man");
                        add_page("I'll do nothing of the sort!", "Elizabeth");
                        add_page("Who do you think you are? Such rude words from a hermit in the woods!", "Elizabeth");
                        add_page("You don't know my Daddy, and he'd certainly build a better boat than yours!", "Elizabeth");
                        add_page("One with games, and prizes, and NONE of your stupid ramblings!", "Elizabeth");
                        add_page("You're just jealous! Jealous that my Daddy is so much better than-.", "Elizabeth");
                        Skip[TextPageNumber - 1] = true;
                        add_page("YOU'D BE BEST TO WATCH YOUR MOUTH!", "Old Man");
                        add_page("His tail lashes at you as he spins to meet your eyes.", "");
                        add_page("You're met with a row of crimson teeth hiding a heinous growl at the back of his throat.", "");
                        add_page("Your Father was a SNAKE! A DEVIL!", "Old Man");
                        add_page("If you'd cease your ignorance, you'd have SEEN this by now!", "Old Man");
                        add_page("But you're too BLINDED! BLINDED by the GREED and AVARICE he's planted in your soul!", "Old Man");
                        add_page("To laud a FOOL who would think you to be nothing more than a TOOL or a HINDERANCE!", "Old Man");
                        add_page("A perspective I've seen a thousand fold, for they're transgressions men like I have YEARNED to repent!", "Old Man");
                        add_page("He'd find NO favor in knowing you protect his name! He'd find no CARE AT ALL!", "Old Man");
                        add_page("But in your DENIAL, you'd be quicker to defend his name than YOUR OWN!", "Old Man");
                        add_page("AND YOU, YOU'RE...", "Old Man");
                        add_page("You hear a shift in his posture through the creaking of the wood, but you don't see it.", "");
                        add_page("How could you? Your eyes are covered.", "");
                        add_page("You're just a...", "Old Man");
                        add_page("You only have one pair of hands, and you've learned it's easier to listen to them when they're yelling.", "");
                        add_page("After all, they care if you listen, but they don't care if you cry.", "");
                        add_page("You're just a child.", "Old Man");
                        add_page("And you know that if they care enough to yell and scream until their throat turns hoarse...", "");
                        add_page("You know that they care about you.", "");
                        add_page("...Oh, god...", "Old Man");
                        add_page("The two of you are joined by the company of silence for the rest of the trip.", "");
                        add_page("Neither of you raise your voice to speak, not until...", "");
                        break;
                    case UnknownEnum.Value_20:
                        add_page("...", "Old Man");
                        add_page("Hm...hmmmm...♫", "Old Man");
                        add_page("♫ \"A baby is born!\" cries the doctor, cries the doctor. ♫", "Old Man");
                        add_page("♫ Together we cheer, the day's here at last ♫.", "Old Man");
                        add_page("♫ \"A baby is born!\" cries the doctor, cries the doctor. ♫", "Old Man");
                        add_page("♫ Together we fear, today is his last. ♫", "Old Man");
                        add_page("♫ \"The baby's gone cold.\" cries the doctor, cries the doctor. ♫", "Old Man");
                        add_page("♫ The mother did scream, it's all just too fast. ♫", "Old Man");
                        add_page("♫ \"The baby's gone cold.\" cries the doctor, cries the doctor. ♫", "Old Man");
                        add_page("♫ The father did cry, it's all just too fast. ♫", "Old Man");
                        add_page("♫ \"The baby's a wonder.\" cries the doctor, cries the doctor. ♫", "Old Man");
                        add_page("♫ The joy we felt could not be compared. ♫", "Old Man");
                        add_page("♫ \"The baby's a wonder.\" cries the doctor, cries the doctor. ♫", "Old Man");
                        add_page("Together we cheer...", "Old Man");
                        break;
                    default:
                        add_page("...Do you fear the Angel?", "Old Man");
                        add_page("They're really quite benevolent. Forgiving sort, they are.", "Old Man");
                        add_page("Of course, don't misconstrue my words...for I do not know you, nor your actions.", "Old Man");
                        add_page("But life is more than a binary of good and bad actions. It's a tapestry we define ourselves.", "Old Man");
                        add_page("There's always threads of good in the patterns of the wicked, it's just a different kind of good than you may see.", "Old Man");
                        add_page("Those who we believe to be led by sin may never have known another way.", "Old Man");
                        add_page("Maybe they were never given one.", "Old Man");
                        add_page("And in the eyes of the many, maybe they never deserved it.", "Old Man");
                        add_page("But it is through the Angel's eyes that we might see beyond our veil of good and evil.", "Old Man");
                        add_page("Word of advice from an old hermit...To try and weigh a life's value in such a simple way is to devalue its meaning.", "Old Man");
                        add_page("And that may not mean much to some, or it may mean everything to others.", "Old Man");
                        add_page("But in the end, whatever retribution you \"deserve\", the Angel will impart upon you with no partisanship.", "Old Man");
                        add_page("For it is not what you deserve that matters, but what you are given.", "Old Man");
                        break;
                }
            }
            
            Function[TextPageNumber] = function()
            {
                with (o4LD_EndingCutscene)
                {
                    FadingOut = true;
                    alarm[0] = 240;
                    audio_sound_gain(WaterSound, 0, 3000);
                }
            };
            
            break;
        case "4LD_AngelArrival":
            Delay[TextPageNumber] = 60;
            if (global.Guard == UnknownEnum.Value_20)
            {
                add_page("...The day's here at last.", "Old Man");
            }
            else
            {
                add_page("...This is your stop.", "Old Man");
            }
            
            Function[TextPageNumber] = function()
            {
                room_goto(FourLayersDown_AngelScene);
            };
            
            break;
        case "4LD_Cassidy":
            add_page("...It's been so long, hasn't it?", "Old Man");
            
            Function[TextPageNumber] = function()
            {
                with (o4LD_OMCUnlockCutscene)
                {
                    Timer = 0;
                    Phase = "Cassidy";
                }
            };
            
            Delay[TextPageNumber] = 360;
            add_page("...And I never considered myself a man of the gambling arts. Did I tell you that?", "Old Man");
            add_page("I dunno. Once or twice, maybe.", "Cassidy");
            add_page("Well, as my eyes did lie upon that board, I was prepared to take a risk that would make even the devil blush.", "Old Man");
            add_page("Did you win?", "Cassidy");
            add_page("You wouldn't wish me to spoil the story at its climax, would you?", "Old Man");
            add_page("...I did, but that's besides the point.", "Old Man");
            add_page("Oh, the tales I could weave from the ensuing vendetta from the sideshow...and the acrobats, mind you!", "Old Man");
            add_page("...But that's a story for another time.", "Old Man");
            add_page("R-Right. Another time...", "Cassidy");
            add_page("...", "Cassidy");
            add_page("...Is something the matter?", "Old Man");
            add_page("Well, it's just...", "Cassidy");
            add_page("...What if there...ISN'T another time?", "Cassidy");
            add_page("Don't think like that. There's always another time, for time is...", "Old Man");
            add_page("...That's...not what you mean, is it?", "Old Man");
            add_page("I don't think so.", "Cassidy");
            add_page("I had a talk with...", "Cassidy");
            add_page("...A new friend.", "Cassidy");
            add_page("And I-I've...been thinking...it's time to move on.", "Cassidy");
            add_page("Is that so?", "Old Man");
            add_page("...Are you mad?", "Cassidy");
            add_page("Mad? Oh, the farthest thing from it!", "Old Man");
            add_page("If I didn't know any better, I'd think you weren't movin' on because you were too busy talking to me!", "Old Man");
            add_page("Well, you DO talk a LOT...", "Cassidy");
            add_page("...But it's been nice to have someone to listen to every now and then.", "Cassidy");
            add_page("Someone that isn't a robot, or a guard...or a prerecorded message.", "Cassidy");
            add_page("It's a heavy burden that you've carried, Cassidy. One that's no easy feat to bear.", "Old Man");
            add_page("Heh. Bear...", "Cassidy");
            add_page("You'll...definitely be getting a lot less of those when I'm gone.", "Cassidy");
            add_page("...Are you coming too?", "Cassidy");
            add_page("I...", "Old Man");
            add_page("I'm afraid that my servitude to this realm is one that does not echo your role.", "Old Man");
            add_page("I don't get it.", "Cassidy");
            add_page("We both died, a-and you've been here for so long...", "Cassidy");
            add_page("Why can't you come with me? Every time I come down here there's less and less people, and...", "Cassidy");
            add_page("...I don't think you'll be getting a whole lot of lost souls down here with me gone.", "Cassidy");
            add_page("It'd be best not to concern yourself with my fate.", "Old Man");
            add_page("Yours was an... unfortunate passing, Cassidy.", "Old Man");
            add_page("But I fear mine was far from honorable.", "Old Man");
            add_page("In my duty, there is repentance for the sins I simply cannot abide.", "Old Man");
            add_page("I've found purpose in guiding the bewildered and frightened souls that enter this realm...", "Old Man");
            add_page("...And in due time, I may find myself joining you in whatever lies beyond.", "Old Man");
            add_page("But first, I must atone.", "Old Man");
            add_page("...How long will that take?", "Cassidy");
            add_page("...I...", "Old Man");
            add_page("I don't know.", "Old Man");
            add_page("But you've already been down here for so long!", "Cassidy");
            add_page("I can't imagine you just sitting down here for...", "Cassidy");
            add_page("...Forever!", "Cassidy");
            add_page("I need you to promise me that you'll move on.", "Cassidy");
            add_page("I need you to promise me that we'll see each other again.", "Cassidy");
            add_page("...Child, I can't-", "Old Man");
            add_page("I mean it! I don't want to lose you for so long that I just...forget!", "Cassidy");
            add_page("It doesn't have to be soon, but I need you to promise me.", "Cassidy");
            add_page("If all our talks meant anything, then please.", "Cassidy");
            add_page("Child...", "Old Man");
            add_page("...", "Old Man");
            add_page("Alright.", "Old Man");
            
            Function[TextPageNumber] = function()
            {
                with (o4LD_OMCUnlockCutscene)
                {
                    Timer = 0;
                    Phase = "Unlock";
                    audio_stop_all();
                }
            };
            
            Delay[TextPageNumber] = 120;
            add_page("Cassidy, I promise.", "Old Man");
            break;
        case "4LD_Angel":
            TextSpeed = 0.5;
            add_page("The Angel looks down upon you, though you feel no judgement from its gaze.", "");
            add_page("You stare back, and your doubts begin to surface.", "");
            add_page("You don't understand. Is there something more that it wants?", "");
            add_page("Deep in the corners of your mind, you desperately search for anything to say.", "");
            add_page("Anything at all.", "");
            add_page("But as you try to-", "");
            Skip[TextPageNumber - 1] = true;
            add_page("Oh, how this moment has denied us so.", "The Angel");
            add_page("Tell me, what has driven you to these ends?", "The Angel");
            add_page("To derive yourself of a judgement that has waited for you, and only you, for so long.", "The Angel");
            add_page("Sentencing upon yourself the most punitive of duties, for what?", "The Angel");
            add_page("I should know well it wasn't for my sake.", "The Angel");
            add_page("...Penance. Denial. Fear.", "Old Man");
            add_page("A deep loathing within myself that I might never overcome.", "Old Man");
            add_page("One I would lie with, mortified. Allowing these sins to flog my very soul.", "Old Man");
            add_page("But they would never leave me be. Never to be content.", "Old Man");
            add_page("It was only through the words of another I have realized...", "Old Man");
            add_page("...Perhaps I do not deserve this fate. Perhaps there is more beyond.", "Old Man");
            add_page("And you find these beliefs from another's preaching?", "The Angel");
            add_page("Such foundations must be forged by the many who've scaled this spire.", "The Angel");
            add_page("...Yes...", "Old Man");
            add_page("Yes, I suppose they were.", "Old Man");
            add_page("Though, truly, there was always a spark.", "Old Man");
            add_page("A promise withheld for far too long.", "Old Man");
            add_page("Through these words, we're allowed to meet. And for them I am grateful.", "The Angel");
            add_page("But they hold no weight in your judgement.", "The Angel");
            add_page("O-Of course.", "Old Man");
            add_page("Those who've lifted this veil of duty from your ruling, though their words hold great strength...", "The Angel");
            add_page("It is only through your loathing that they might walk this plane.", "The Angel");
            add_page("I...I-I don't understand.", "Old Man");
            add_page("This plane was built for the penance of one.", "The Angel");
            add_page("But in your altruistic penitence, you've only grown the idea of sin broader and broader.", "The Angel");
            add_page("It weaves itself through your own past, and into the lives of others.", "The Angel");
            add_page("What was once \"I\" is now \"We\". What was once \"Myself\" becomes \"Ourselves\".", "The Angel");
            add_page("It was only meant for you, but now it has come to mean so much more.", "The Angel");
            add_page("...Is there anything I can do?", "Old Man");
            add_page("There's nothing left. Not for you, or anyone else.", "The Angel");
            add_page("I would never ask any more of you than to bless yourself with my visage.", "The Angel");
            add_page("Not unless...you've objections...?", "The Angel");
            add_page("No! No. I'm...I'm just...", "Old Man");
            add_page("I'm sorry I took so long.", "Old Man");
            
            Function[TextPageNumber] = function()
            {
                with (o4LD_AngelCutsceneFollowup)
                {
                    FadingOut = true;
                }
                audio_sound_gain(global.Music, 0, 4000);
            };
            
            Delay[TextPageNumber] = 300;
            add_page("It begins with a rumbling, a horrible rumbling.", "");
            add_page("One you can feel deep within your very being, threatening to shatter the notion of bravado you once held.", "");
            add_page("And then a screeching, a horrible screeching.", "");
            add_page("But as your ears are torn to splinter, you find no semblance of dread within this dissonance.", "");
            add_page("Because on your face, muscles you'd thought had long since decayed begin to flex.", "");
            add_page("Tears that you'd only seen as ripples in the water roll down your cheeks.", "");
            add_page("And as you join in this cacophonous stir, you're shocked to find what roars from your breast.", "");
            add_page("It's laughter. Laughter betwixt old friends who have never met.", "");
            add_page("As the dust settles, the uproar turns to silence, and the droplets in your eyes remain.", "");
            add_page("...Now, I beg you to impart your truth.", "The Angel");
            add_page("Are you ready?", "The Angel");
            add_page("...", "Old Man");
            add_page("No.", "Old Man");
            add_page("So make it quick.", "Old Man");
            
            Function[TextPageNumber] = function()
            {
                with (o4LD_AngelCutsceneFollowup)
                {
                    alarm[0] = 180;
                }
            };
            
            break;
        case "Microgame_Quiz":
            var Answers;
            switch (global.MicrogameLevel)
            {
                case 2:
                    add_page("How many microgames have you cleared?", "Fredbear");
                    Answers = array_shuffle([[string(oFredbearManager.MicrogameNumber), "Microgame_Win"], [string(oFredbearManager.MicrogameNumber - irandom_range(1, 5)), "Microgame_Fail"], [string(oFredbearManager.MicrogameNumber + irandom_range(-1, -3)), "Microgame_Fail"], [string(oFredbearManager.MicrogameNumber + (irandom_range(-4, -5) * random_sign())), "Microgame_Fail"]]);
                    break;
                case 1:
                    add_page("Spell my name!", "Fredbear");
                    Answers = array_shuffle([["Fredbear", "Microgame_Win"], ["Fridbear", "Microgame_Fail"], ["Freaddear", "Microgame_Fail"], ["Fredbare", "Microgame_Fail"]]);
                    break;
                case 0:
                    if (global.Night == "Custom")
                    {
                        add_page("Who are you fighting?", "Fredbear");
                        Answers = array_shuffle([["Fredbear", "Microgame_Win"], ["Nedd Bear", "Microgame_Fail"], ["Dreadbear", "Microgame_Fail"], ["Freddybear", "Microgame_Fail"]]);
                    }
                    else
                    {
                        add_page("Who are you playing as?", "Fredbear");
                        Answers = array_shuffle([["Jeremy", (global.Guard == 0) ? "Microgame_Win" : "Microgame_Fail"], ["Mike", (global.Guard == 1) ? "Microgame_Win" : "Microgame_Fail"], ["Vanessa", (global.Guard == 2) ? "Microgame_Win" : "Microgame_Fail"], ["Fritz", (global.Guard == 3) ? "Microgame_Win" : "Microgame_Fail"]]);
                        if (global.Guard > 3)
                        {
                            Answers[irandom(3)] = [guard_nickname(), "Microgame_Win"];
                        }
                    }
                    break;
            }
            add_option(Answers[0][0], Answers[0][1]);
            add_option(Answers[1][0], Answers[1][1]);
            add_option(Answers[2][0], Answers[2][1]);
            add_option(Answers[3][0], Answers[3][1]);
            break;
        case "Microgame_Win":
            Function[TextPageNumber] = function()
            {
                global.MicrogameWin = true;
                audio_play_sound(sfxBitBoost, 10, false);
                end_microgame();
            };
            
            Lock[TextPageNumber] = true;
            add_page("That's right, that's right!", "Fredbear");
            break;
        case "Microgame_Fail":
            Function[TextPageNumber] = function()
            {
                global.MicrogameWin = false;
                audio_play_sound(sfxBitFail, 10, false);
                end_microgame();
            };
            
            Lock[TextPageNumber] = true;
            add_page("WRONG, WRONG, WRONG!", "Fredbear");
            break;
        case "Microgame_Fail_0":
            Function[TextPageNumber] = function()
            {
                global.MicrogameWin = false;
                audio_play_sound(sfxBitFail, 10, false);
                end_microgame();
            };
            
            Lock[TextPageNumber] = true;
            add_page("WRONG! I don't have eyes!", "Fredbear");
            break;
        case "Microgame_Fail_1":
            Function[TextPageNumber] = function()
            {
                global.MicrogameWin = false;
                audio_play_sound(sfxBitFail, 10, false);
                end_microgame();
            };
            
            Lock[TextPageNumber] = true;
            add_page("WRONG! My bowtie's missing!", "Fredbear");
            break;
        case "Microgame_Fail_2":
            Function[TextPageNumber] = function()
            {
                global.MicrogameWin = false;
                audio_play_sound(sfxBitFail, 10, false);
                end_microgame();
            };
            
            Lock[TextPageNumber] = true;
            add_page("WRONG! I got no buttons!", "Fredbear");
            break;
        case "Microgame_Fail_3":
            Function[TextPageNumber] = function()
            {
                global.MicrogameWin = false;
                audio_play_sound(sfxBitFail, 10, false);
                end_microgame();
            };
            
            Lock[TextPageNumber] = true;
            add_page("WRONG! I've got no stars!", "Fredbear");
            break;
        case "Microgame_Found":
            Function[TextPageNumber] = function()
            {
                global.MicrogameWin = true;
                audio_play_sound(sfxBitBoost, 10, false);
                end_microgame();
            };
            
            Lock[TextPageNumber] = true;
            add_page("Haha, you found me!", "Fredbear");
            break;
        case "Fredbear_Cracked":
            Lock[TextPageNumber] = true;
            add_page("You got it!", "");
            break;
        case "RouteChoice":
            add_page("Then who will you go along with?", "");
            add_option("Help your boss", "ChoiceConfirm_Money");
            if (currently_good() && has_been_good())
            {
                add_option("Help Michael", "ChoiceConfirm_Good");
            }
            if (currently_evil() && has_been_evil())
            {
                add_option("Help the rabbit", "ChoiceConfirm_Evil");
            }
            break;
        case "ChoiceConfirm_Money":
            add_page("...Are you sure?", "");
            add_option("Yes", "Chosen_Money");
            add_option("No", "RouteChoice");
            break;
        case "ChoiceConfirm_Good":
            add_page("...Are you sure?", "");
            add_option("Yes", "Chosen_Good");
            add_option("No", "RouteChoice");
            break;
        case "ChoiceConfirm_Evil":
            add_page("...Are you sure?", "");
            add_option("Yes", "Chosen_Evil");
            add_option("No", "RouteChoice");
            break;
        case "Chosen_Money":
            add_page("...Your boss it is.", "");
            
            Function[TextPageNumber] = function()
            {
                global.Route = UnknownEnum.Value_1;
                instance_create_depth(0, 0, 0, oTransitionMinigame);
            };
            
            break;
        case "Chosen_Good":
            add_page("...Michael it is.", "");
            
            Function[TextPageNumber] = function()
            {
                global.Route = UnknownEnum.Value_2;
                with (instance_create_depth(0, 0, 0, oTransitionMinigame))
                {
                    Destination = SalvageResults;
                }
            };
            
            break;
        case "Chosen_Evil":
            add_page("...The rabbit it is.", "");
            
            Function[TextPageNumber] = function()
            {
                global.Route = UnknownEnum.Value_3;
                with (instance_create_depth(0, 0, 0, oTransitionMinigame))
                {
                    Destination = SalvageResults;
                }
            };
            
            break;
        case "RouteChoice_Ultimate":
            add_page("Then who will you go along with?", "");
            add_option("Help Michael", "ChoiceConfirmUlt_Good");
            add_option("Help the rabbit", "ChoiceConfirmUlt_Evil");
            break;
        case "ChoiceConfirmUlt_Good":
            add_page("...Are you sure?", "");
            add_option("Yes", "UltSplit_Michael");
            add_option("No", "RouteChoice_Ultimate");
            break;
        case "ChoiceConfirmUlt_Evil":
            add_page("...Are you sure?", "");
            add_option("Yes", "UltSplit_Vanny");
            add_option("No", "RouteChoice_Ultimate");
            break;
        case "UltSplit_Michael":
            Function[TextPageNumber] = function()
            {
                with (oTalksprite)
                {
                    SecondarySprite = sTalksprites_Vanny;
                    switch_chars(7, 1);
                }
            };
            
            add_page("Awww, WHAT!?", "White Rabbit");
            
            Function[TextPageNumber] = function()
            {
                with (oTalksprite)
                {
                    Image = 6;
                }
            };
            
            add_page("You jerk! You lead me on this whole time just to turn me down like that!?", "White Rabbit");
            
            Function[TextPageNumber] = function()
            {
                with (oTalksprite)
                {
                    Image = 5;
                }
            };
            
            add_page("Fine, you know what? This is FINE! I don't NEED you! I NEVER needed you!", "White Rabbit");
            
            Function[TextPageNumber] = function()
            {
                with (oTalksprite)
                {
                    Image = 7;
                }
            };
            
            add_page("AND I TAKE BACK ALL THE TIMES I FLIRTED WITH YOU, TOO!!", "White Rabbit");
            
            Function[TextPageNumber] = function()
            {
                with (oTalksprite)
                {
                    sprite_index = sNOTHING;
                    Enter = false;
                }
                global.Route = UnknownEnum.Value_2;
                audio_sound_gain(musMidnight_MissingChild, 0, 1000);
            };
            
            add_page("...The white rabbit thumps her feet, before walking away dejectedly...", "");
            
            Function[TextPageNumber] = function()
            {
                with (instance_create_depth(800, 0, 50, oTalksprite))
                {
                    Image = 2;
                    image_index = sTalksprites_Michael;
                }
            };
            
            add_page("...Well, that was a bit more of a hassle than I would've liked...", "Hooded Man");
            
            Function[TextPageNumber] = function()
            {
                with (oTalksprite)
                {
                    Image = 1;
                }
            };
            
            add_page("...But I'm glad you came to your senses.", "Hooded Man");
            
            Function[TextPageNumber] = function()
            {
                with (oTalksprite)
                {
                    Image = 3;
                }
            };
            
            add_page("Now, we've quite a night ahead of us. First, I'll need to give you this.", "Hooded Man");
            add_page("Michael hands you...a portable game console?", "");
            
            Function[TextPageNumber] = function()
            {
                with (oTalksprite)
                {
                    Image = 2;
                }
            };
            
            add_page("Fortunately for both of us, all the pieces are already in place.", "Hooded Man");
            
            Function[TextPageNumber] = function()
            {
                with (oTalksprite)
                {
                    Image = 1;
                }
            };
            
            add_page("If you'd be willing, I would like for you to come back here tomorrow night.", "Hooded Man");
            
            Function[TextPageNumber] = function()
            {
                with (oTalksprite)
                {
                    Image = 4;
                }
            };
            
            add_page("...I figure you might as well, seeing as you already went through the effort of collecting those masks for me.", "Hooded Man");
            
            Function[TextPageNumber] = function()
            {
                with (oTalksprite)
                {
                    Image = 3;
                }
            };
            
            add_page("Just this once, don't let me down.", "Hooded Man");
            
            Function[TextPageNumber] = function()
            {
                with (oTalksprite)
                {
                    Enter = false;
                }
            };
            
            add_page("...And the hooded man takes his leave as well.", "");
            add_page("...", "");
            add_page("...You feel as if you may have missed something along the way. Something that could've let you circumvent this altogether.", "");
            add_page("...", "");
            add_page("...But whatever that could've been, you suppose it's too late to worry about it now.", "");
            add_page("Better go get this over with.", "");
            
            Function[TextPageNumber] = function()
            {
                audio_stop_sound(musMidnight_MissingChild);
                with (instance_create_depth(0, 0, 0, oTransitionMinigame))
                {
                    Destination = SalvageResults;
                }
            };
            
            break;
        case "UltSplit_Vanny":
            Function[TextPageNumber] = function()
            {
                with (oTalksprite)
                {
                    SecondarySprite = sTalksprites_Vanny;
                    switch_chars(1, 1);
                }
            };
            
            add_page("Haha, I KNEW it! I knew you'd...", "White Rabbit");
            
            Function[TextPageNumber] = function()
            {
                with (oTalksprite)
                {
                    Image = 2;
                }
            };
            
            add_page("...Wait, seriously? Even after that whole story yesterday night...?", "White Rabbit");
            
            Function[TextPageNumber] = function()
            {
                with (oTalksprite)
                {
                    Image = 0;
                }
            };
            
            add_page("Oh well, I know better than to expect anything you do to make sense. I'll see you here tomorrow~!", "White Rabbit");
            
            Function[TextPageNumber] = function()
            {
                with (oTalksprite)
                {
                    sprite_index = sNOTHING;
                    Enter = false;
                }
                global.Route = UnknownEnum.Value_3;
                audio_sound_gain(musMidnight_MissingChild, 0, 1000);
            };
            
            add_page("The white rabbit blows you a kiss, before skipping away...", "");
            
            Function[TextPageNumber] = function()
            {
                with (instance_create_depth(800, 0, 50, oTalksprite))
                {
                    Image = 4;
                    image_index = sTalksprites_Michael;
                }
            };
            
            add_page("...Well, to say I'm disappointed would be a bit of an understatement.", "Hooded Man");
            
            Function[TextPageNumber] = function()
            {
                with (oTalksprite)
                {
                    Image = 0;
                }
            };
            
            add_page("I really was hoping something I said would get through to you.", "Hooded Man");
            
            Function[TextPageNumber] = function()
            {
                with (oTalksprite)
                {
                    Image = 3;
                }
            };
            
            add_page("...But I suppose you'll need to learn this the hard way instead.", "Hooded Man");
            
            Function[TextPageNumber] = function()
            {
                with (oTalksprite)
                {
                    Enter = false;
                }
            };
            
            add_page("...And the hooded man takes his leave as well.", "");
            add_page("...", "");
            add_page("...You feel as if you may have missed something along the way. Something that could've let you circumvent this altogether.", "");
            add_page("...", "");
            add_page("...But whatever that could've been, you suppose it's too late to worry about it now.", "");
            add_page("Better go get this over with.", "");
            
            Function[TextPageNumber] = function()
            {
                audio_stop_sound(musMidnight_MissingChild);
                with (instance_create_depth(0, 0, 0, oTransitionMinigame))
                {
                    Destination = SalvageResults;
                }
            };
            
            break;
        case "Bar":
            Function[TextPageNumber] = function()
            {
                instance_create_depth(0, -128, depth + 1, oTipsyBird_Window);
            };
            
            Delay[TextPageNumber] = 60;
            var DrinkPrice = calc_price(20);
            var OMCMode = global.Guard == UnknownEnum.Value_20 && global.EndlessGuardStickers[UnknownEnum.Value_20] == -1;
            if (OMCMode)
            {
                add_page("The bar is nearly empty...", "");
            }
            else
            {
                add_page("There appear to be three other patrons sitting at the bar...", "");
            }
            if (global.RunEarnings >= DrinkPrice)
            {
                add_page($"...Buy {OMCMode ? "Tipsy" : "one of them"} a drink? (It'll cost you ${string_format(DrinkPrice, 2, 2)}.)", "");
                add_option("Yes", "Bar_Choice");
                add_option("No", "Bar_Leave");
            }
            else
            {
                add_page("...Unfortunately, it seems you don't have the cash to join them.", "");
                Delay[TextPageNumber] = 1;
                Skip[TextPageNumber] = true;
                
                Function[TextPageNumber] = function()
                {
                    with (oTipsyBird_Window)
                    {
                        GuardDirection = -1;
                        Leaving = true;
                    }
                    ExternalPause = true;
                };
                
                Hide[TextPageNumber] = true;
                add_page("", "");
                Hide[TextPageNumber] = true;
            }
            break;
        case "Bar_Leave":
            add_page("Maybe another time.", "");
            Delay[TextPageNumber] = 1;
            Skip[TextPageNumber] = true;
            
            Function[TextPageNumber] = function()
            {
                with (oTipsyBird_Window)
                {
                    GuardDirection = -1;
                    Leaving = true;
                }
                ExternalPause = true;
            };
            
            Hide[TextPageNumber] = true;
            add_page("", "");
            Hide[TextPageNumber] = true;
            break;
        case "Bar_Choice":
            add_page("Who will it be?", "");
            for (var i = 0; i < min(3, array_length(oTipsyBird_Window.Patrons)); i++)
            {
                add_option(guard_nickname(oTipsyBird_Window.Patrons[i]), "Bar_Pick" + string(i + 1));
            }
            if (global.EndlessInventory.BarrierBooze == 0 || array_length(oTipsyBird_Window.Patrons) == 0)
            {
                add_option("Tipsy", "Bar_PickTipsy");
            }
            break;
        case "Bar_Pick1":
        case "Bar_Pick2":
        case "Bar_Pick3":
        case "Bar_PickTipsy":
            var Recipient = UnknownEnum.Value_1;
            var ChosenSeat = (arg0 == "Bar_PickTipsy") ? 3 : ((arg0 == "Bar_Pick1") ? 0 : ((arg0 == "Bar_Pick2") ? 1 : 2));
            if (ChosenSeat < array_length(oTipsyBird_Window.Patrons))
            {
                Recipient = oTipsyBird_Window.Patrons[ChosenSeat];
            }
            global.RunEarnings -= calc_price(20);
            with (oTipsyBird_Window)
            {
                SelectedSeat = ChosenSeat;
            }
            Delay[TextPageNumber] = 5;
            Skip[TextPageNumber] = true;
            
            Function[TextPageNumber] = function()
            {
                audio_play_sound(sfxRegister, 10, false);
                ExternalPause = true;
            };
            
            add_page(".", "");
            Hide[TextPageNumber - 1] = true;
            if (arg0 == "Bar_PickTipsy")
            {
                if (global.Guard == UnknownEnum.Value_20)
                {
                    add_page("I can't remember the last time I saw YOU in here!", "Tipsy Bird");
                    add_page("As you can tell, business has been...a little slow lately.", "Tipsy Bird");
                    add_page("Hey, don't worry about it! We're more than happy with all you've done for us for all our time here.", "Tipsy Bird");
                    add_page("...But that time's coming to an end, isn't it?", "Tipsy Bird");
                    add_page("If you're looking for your friend, they aren't here.", "Tipsy Bird");
                    add_page("...Take this so you can find them.", "Tipsy Bird");
                    
                    Function[TextPageNumber] = function()
                    {
                        audio_play_sound(sfxBitCollect, 15, false);
                        global.EndlessInventory.BarrierBooze = true;
                    };
                    
                    add_page("Got a bottle of Barrier Booze!", "");
                }
                else
                {
                    add_page("...Oh? Is this...for me...?", "Tipsy Bird");
                    add_page("Awww, thank you, hun! That's so thoughtful of you!", "Tipsy Bird");
                    add_page("...Though, heh...don't think I can get away with drinkin' on work hours. I reckon the boss wouldn't be too happy about that.", "Tipsy Bird");
                    add_page("Still, I wish I could make it up to you...", "Tipsy Bird");
                    add_page("...Ah, I know!", "Tipsy Bird");
                    add_page("Here, it's on the house.", "Tipsy Bird");
                    
                    Function[TextPageNumber] = function()
                    {
                        audio_play_sound(sfxBitCollect, 15, false);
                        global.EndlessInventory.BarrierBooze = true;
                    };
                    
                    add_page("Got a bottle of Barrier Booze!", "");
                    add_page("Hold onto that! It's the last one I got. It'll give you another chance if one of those bots happen to get ya.", "Tipsy Bird");
                }
                if (eleanor_challenge_active(UnknownEnum.Value_5))
                {
                    add_page("...Well, it will once you take that pendant you're wearin' off, at least.", "Tipsy Bird");
                }
                else if (guard_ability(UnknownEnum.Value_11))
                {
                    add_page("I don't think it'll be of much use to YOU...but it might end up saving one of your friends if you let 'em take over for you!", "Tipsy Bird");
                }
                add_page("And thank you again! Swing by again sometime, y'hear?", "Tipsy Bird");
            }
            else
            {
                var Backup = bar_dialogue_array(global.Guard, Recipient);
                if (Recipient >= 21)
                {
                    var file = "dialogue/bar/receive.txt";
                    read_custom_dialogue_backup(file, global.GuardNames[global.Guard], "GENERIC", Backup, {}, Recipient);
                }
                else if (global.Guard >= 21)
                {
                    var file = "dialogue/bar/give.txt";
                    read_custom_dialogue(file, global.GuardNames[Recipient], Backup, {});
                }
                else
                {
                    var BarDialogue = bar_dialogue_array(global.Guard, Recipient);
                    if (Recipient == UnknownEnum.Value_6)
                    {
                        unlock_guard(UnknownEnum.Value_6);
                    }
                    for (var i = 0; i < array_length(BarDialogue); i++)
                    {
                        add_page(BarDialogue[i][0], BarDialogue[i][1]);
                    }
                }
                array_insert(global.Lives, 0, Recipient);
                with (oTipsyBird_Window)
                {
                    VoiceLineID = get_guard_line(Recipient, "Selection");
                }
                
                Function[TextPageNumber] = function()
                {
                    audio_play_sound(sfxBitCollect, 15, false);
                    with (oTipsyBird_Window)
                    {
                        PageUp = true;
                        show_debug_message($"Guard: {guard_nickname(global.Lives[0])}");
                        bitcrush_sound(VoiceLineID, 0, 0, false);
                    }
                };
                
                add_page($"{no_brackets(global.GuardNames[Recipient])} has joined your party!", "");
            }
            Delay[TextPageNumber] = 1;
            Skip[TextPageNumber] = true;
            
            Function[TextPageNumber] = function()
            {
                with (oTipsyBird_Window)
                {
                    GuardDirection = -1;
                    audio_play_sound(sfxBitPlace, 10, false);
                    PageUp = false;
                    alarm[1] = 30;
                }
                ExternalPause = true;
            };
            
            Hide[TextPageNumber] = true;
            add_page("", "");
            Hide[TextPageNumber] = true;
            break;
        default:
            break;
    }
    add_page("", "");
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
    Value_13,
    Value_14,
    Value_15,
    Value_16,
    Value_17,
    Value_18,
    Value_19,
    Value_20,
    Value_21,
    Value_22,
    Value_23,
    Value_24,
    Value_25,
    Value_26,
    Value_27,
    Value_28,
    Value_29,
    Value_30,
    Value_31,
    Value_32,
    Value_33,
    Value_34,
    Value_35,
    Value_36,
    Value_37,
    Value_38,
    Value_39,
    Value_40,
    Value_41,
    Value_42,
    Value_43,
    Value_44,
    Value_45,
    Value_46,
    Value_47,
    Value_48,
    Value_49,
    Value_50,
    Value_51,
    Value_52,
    Value_53,
    Value_54,
    Value_55,
    Value_56,
    Value_57,
    Value_58,
    Value_59,
    Value_60,
    Value_61,
    Value_62,
    Value_63,
    Value_64,
    Value_65,
    Value_66,
    Value_67,
    Value_68,
    Value_69,
    Value_70,
    Value_71,
    Value_72,
    Value_73,
    Value_74,
    Value_75,
    Value_76,
    Value_77,
    Value_78,
    Value_79,
    Value_80,
    Value_81,
    Value_82,
    Value_83,
    Value_84,
    Value_85,
    Value_86,
    Value_128 = 128,
    Value_130 = 130,
    Value_131,
    Value_132,
    Value_133,
    Value_134,
    Value_135,
    Value_136,
    Value_137,
    Value_138,
    Value_139,
    Value_140,
    Value_141,
    Value_142,
    Value_143,
    Value_154 = 154
}
