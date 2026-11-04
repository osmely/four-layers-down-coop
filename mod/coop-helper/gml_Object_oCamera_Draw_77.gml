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
            HelperFaceSprites = import_sprites_solo(CoopFace, "reflection.png", get_guard_reflection_sprite(CoopFace), 2);
            HelperFaceGuard = CoopFace;
        }
        draw_sprite_part(HelperFaceSprites, (CoopFace * 2) + (BossMode != UnknownEnum.Value_0 || Scared), 0, CamTop, 640, 360 - CamTop, 100, CamTop);
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
    var WallsReady = instance_exists(oWall) && variable_instance_exists(oWall, "List_InFrontOfWall");
    if (!variable_instance_exists(id, "HelperMonitorAnim"))
    {
        HelperMonitorAnim = 0;
    }
    HelperMonitorAnim += (((helper_active() && WallsReady && (global.TurnedAround || global.CamUp)) - HelperMonitorAnim) / 5);
    if (HelperMonitorAnim > 0.01 && WallsReady)
    {
        var WallSize = 96;
        var PanelW = (WallSize * 2) + 8;
        var PanelH = WallSize + 6;
        var PanelX = 636 - PanelW;
        var PanelY = (338 - PanelH) + ((1 - HelperMonitorAnim) * (PanelH + 24));
        if (!variable_instance_exists(id, "HelperMonitorSurface") || !surface_exists(HelperMonitorSurface))
        {
            HelperMonitorSurface = surface_create(WallSize * 2, WallSize * 2);
        }
        var Blue = make_color_rgb(40, 110, 255);
        var LightBlue = make_color_rgb(140, 190, 255);
        draw_rectangle_color(PanelX, PanelY, (PanelX + PanelW) - 1, (PanelY + PanelH) - 1, Blue, Blue, Blue, Blue, false);
        draw_rectangle_color(PanelX, PanelY, (PanelX + PanelW) - 1, (PanelY + PanelH) - 1, LightBlue, LightBlue, LightBlue, LightBlue, true);
        var OldFilter = gpu_get_tex_filter();
        gpu_set_tex_filter(true);
        var Walls = [oWall.SPRITE_WallLeft, oWall.SPRITE_WallRight];
        var WallX = [576, 1600];
        for (var w = 0; w < 2; w++)
        {
            surface_set_target(HelperMonitorSurface);
            coop_draw_wall(Walls[w], WallX[w], 448, (WallSize * 2) / sprite_get_width(Walls[w]));
            surface_reset_target();
            draw_surface_ext(HelperMonitorSurface, PanelX + 3 + (w * (WallSize + 2)), PanelY + 3, 0.5, 0.5, 0, c_white, 1);
        }
        gpu_set_tex_filter(OldFilter);
    }
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
