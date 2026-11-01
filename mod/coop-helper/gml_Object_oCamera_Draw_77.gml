initialize_ui_surface();
CamAnimation += ((global.CamUp - CamAnimation) / 5);
MaskAnimation += ((global.MaskDown - MaskAnimation) / 5);
if (!Freeze || instance_exists(oJumpscarePhantoms))
{
    if (CamAlpha == 1)
    {
        draw_sprite_ext(sFlashlight, global.Flashlight, clamp(global.MouseX, 0, 640), clamp(global.MouseY, 0, 360), FlashlightPower, FlashlightPower, 0, c_white, global.Brightness);
    }
    if (global.GoGreen)
    {
        shader_set(shGreenToWhite);
        if (surface_exists(application_surface))
        {
            draw_surface(application_surface, 0, 0);
        }
        shader_reset();
    }
    var CamSize = 1;
    var CamTop = (1 - CamAnimation) * 400;
    var MonitorY = (1 - CamAnimation) * 480;
    draw_sprite_ext(sMonitorScreen, 0, 320, 180 + MonitorY, CamSize, CamSize, 0, -1, CamAlpha);
    draw_set_alpha(0.5 * CamAlpha);
    draw_sprite_part(sMonitorReflection, 0, 0, CamTop, 640, 360 - CamTop, 0, CamTop);
    draw_set_alpha(0.25 * CamAlpha);
    var CoopFace = coop_partner();
    draw_sprite_part(FaceSprites, (global.Guard * 2) + (BossMode != UnknownEnum.Value_0 || Scared), 0, CamTop, 640, 360 - CamTop, (CoopFace == -1) ? 0 : -100, CamTop);
    if (CoopFace != -1)
    {
        if (!variable_instance_exists(id, "HelperFaceGuard") || HelperFaceGuard != CoopFace)
        {
            if (variable_instance_exists(id, "HelperFaceSprites"))
            {
                sprite_delete(HelperFaceSprites);
            }
            HelperFaceSprites = import_sprites_solo(CoopFace, "selection.png", sNightGuardFacesSelection, 2);
            HelperFaceGuard = CoopFace;
        }
        var HelperScale = 0.85;
        var HelperY = 360 - (360 * HelperScale);
        var HelperTop = max(0, (CamTop - HelperY) / HelperScale);
        draw_sprite_part_ext(HelperFaceSprites, CoopFace * 2, 0, HelperTop, 480, 360 - HelperTop, 630, HelperY + (HelperTop * HelperScale), -HelperScale, HelperScale, c_white, 0.25 * CamAlpha);
    }
    draw_set_alpha(1);
    if (global.CamUp && !ShowMalhare)
    {
        if (instance_exists(oMalhare) && global.AILevels[UnknownEnum.Value_37] > 0)
        {
            oMalhare.FlipsLeft--;
            if (oMalhare.FlipsLeft <= 10)
            {
                if (oMalhare.FlipsLeft == 10)
                {
                    audio_play_sound(oMalhare.SOUND_FirstFlip, 5, false, 0.5);
                }
                if (oMalhare.FlipsLeft == 0)
                {
                    audio_play_sound(oMalhare.SOUND_LastFlip, 5, false, 0.5);
                }
                audio_play_sound(oMalhare.SOUND_Flip, 5, false);
            }
            ShowMalhare = true;
        }
    }
    else if (!global.CamUp)
    {
        ShowMalhare = false;
    }
    if (ShowMalhare && instance_exists(oMalhare))
    {
        if (oMalhare.FlipsLeft <= 10)
        {
            draw_set_alpha(CamAlpha);
            var CurrentY = 0;
            while (CurrentY < 360)
            {
                var XOffset = irandom_range(-4, 4);
                var PreviousY = CurrentY;
                var CurrentX = irandom_range(-160, 160);
                if (irandom(2) != 1)
                {
                    CurrentX = XOffset;
                }
                CurrentY += irandom_range(32, 128);
                var sprite = oMalhare.SPRITE_Malhare;
                draw_sprite_part(sprite, 0, 0, PreviousY, 640, CurrentY, CurrentX - 640, PreviousY + MonitorY);
                draw_sprite_part(sprite, 0, 0, PreviousY, 640, CurrentY, CurrentX, PreviousY + MonitorY);
                draw_sprite_part(sprite, 0, 0, PreviousY, 640, CurrentY, CurrentX + 640, PreviousY + MonitorY);
                var LivesOffset = 240;
                draw_sprite_part(oMalhare.SPRITE_Countdown, oMalhare.FlipsLeft, 0, PreviousY - LivesOffset, 288, CurrentY - LivesOffset, 176, PreviousY + MonitorY);
            }
            draw_set_alpha(1);
        }
    }
    if (global.Tokens != TokenBoxValue)
    {
        TokenBoxSpeed = min(abs(TokenBoxValue - global.Tokens), 4);
        TokenBoxValue = global.Tokens;
    }
    if (!global.CamUp && mouse_in_zone(554, 2, 84, 88))
    {
        TokenBoxOffset += ((-24 - TokenBoxOffset) / 5);
        TokenBoxSpeed = 0;
    }
    else
    {
        TokenBoxSpeed = lerp(TokenBoxSpeed, (0 - TokenBoxOffset) * 0.8, 0.2);
        TokenBoxOffset += TokenBoxSpeed;
    }
    EntranceAlpha = max(EntranceAlpha - 0.016666666666666666, 0);
}
if (Freezeframe != undefined)
{
    draw_sprite(Freezeframe, 0, 0, 0);
    draw_sprite_ext(sFlashlight, 0, 0, 0, 1, 1, 0, -1, global.Brightness);
}
if (instance_exists(oJumpscare))
{
    draw_sprite_ext(sFlashlight, 0, 320, 180, 1, 1, 0, -1, global.Brightness);
    if (global.Jumpscare == UnknownEnum.Value_126)
    {
        draw_sprite(sJumpscare_Fredbear3D, floor(oJumpscare.Frame / 2), 0, 0);
    }
    else if (global.Jumpscare == UnknownEnum.Value_127)
    {
        draw_sprite(sJumpscare_PhonyBoss, floor(oJumpscare.Frame / 2), 0, 0);
    }
    else
    {
        var Vibration = (oJumpscare.Frame / 5) + 1;
        var FrameVal = 1 - (floor(oJumpscare.Frame) % 3);
        var Offset = (round(((FrameVal * 2) / Vibration) * 80) / 10) + (sqrt(oJumpscare.Frame) * oJumpscare.OriginX * 2);
        if (sprite_exists(oJumpscare.Sprite))
        {
            draw_sprite_ext(oJumpscare.Sprite, oJumpscare.BodyImage, oJumpscare.JumpX + Offset, oJumpscare.JumpY, oJumpscare.SizeBody, oJumpscare.SizeBody, oJumpscare.JumpAngle, -1, 1);
            draw_sprite_ext(oJumpscare.Sprite, oJumpscare.HeadImage, oJumpscare.JumpX, oJumpscare.JumpY, oJumpscare.SizeHead, oJumpscare.SizeHead, Offset + oJumpscare.JumpAngle, -1, 1);
        }
    }
}
surface_reset_target();

enum UnknownEnum
{
    Value_0,
    Value_37 = 37,
    Value_126 = 126,
    Value_127
}
