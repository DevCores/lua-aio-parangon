--[[


________  __                            __                           __   ______
/        |/  |                          /  |                         /  | /      \
$$$$$$$$/ $$ |____    ______   _______  $$ |   __   _______         /$$/ /$$$$$$  |
  $$ |   $$      \  /      \ /       \ $$ |  /  | /       |       /$$/  $$ ___$$ |
  $$ |   $$$$$$$  | $$$$$$  |$$$$$$$  |$$ |_/$$/ /$$$$$$$/       /$$<     /   $$<
  $$ |   $$ |  $$ | /    $$ |$$ |  $$ |$$   $$<  $$      \       $$  \   _$$$$$  |
  $$ |   $$ |  $$ |/$$$$$$$ |$$ |  $$ |$$$$$$  \  $$$$$$  |       $$  \ /  \__$$ |
  $$ |   $$ |  $$ |$$    $$ |$$ |  $$ |$$ | $$  |/     $$/         $$  |$$    $$/
  $$/    $$/   $$/  $$$$$$$/ $$/   $$/ $$/   $$/ $$$$$$$/           $$/  $$$$$$/
  For using this script.

  If you would like to participate in the development of AzerothCore, the project has a Discord as well as a Github.
  Everyone's help is welcome, Developers, Testers, Videographers.

    Discord: https://discord.com/invite/nF2yhT
    Website: http://www.azerothcore.org/
    Discord: https://github.com/azerothcore/azerothcore-wotlk

  Thanks for using my scripts, they take up a lot of my time.

  You can thank me and give a simple star on Github.
  You can also make a donation on Paypal if you feel like it.

  Thank you for your support.

    Discord: iThorgrimHub#1775
    Paypal: https://www.paypal.me/LevelLouis


]]--

local AIO = AIO or require("AIO");
if AIO.AddAddon() then
    return
end

local Parangon = AIO.AddHandlers("AIO_Parangon", {}) -- Parangon Window
--

--[[

 PARANGON Window

]] local Parangon_Window = CreateFrame("Frame", "Parangon_Window", UIParent)
Parangon_Window:SetSize(300, 450);
Parangon_Window:SetMovable(false);
Parangon_Window:EnableMouse(true);
Parangon_Window:RegisterForDrag("Right_Button")
Parangon_Window:SetPoint("CENTER", 0, 50)
Parangon_Window:SetBackdrop(
    {
        bgFile = "Interface/Parangon/WindowBackground",
        insets = {left = 0, right = 0, top = 0, bottom = 0}
    }
);
Parangon_Window:Hide();

-- Main Window | Options
Parangon_Window:SetScript("OnDragStart", Parangon_Window.StartMoving)
Parangon_Window:SetScript("OnHide", Parangon_Window.StopMovingOrSizing)
Parangon_Window:SetScript("OnDragStop", Parangon_Window.StopMovingOrSizing)
Parangon_Window:SetFrameLevel(1);

-- Main Window | Orc Decoration
local Parangon_Orc_Decoration = CreateFrame("Button", "Parangon_Orc_Decoration", Parangon_Window, nil)
Parangon_Orc_Decoration:SetSize(200, 110)
Parangon_Orc_Decoration:SetNormalTexture("Interface/archeology/archrare-genbeauregardslaststand")
Parangon_Orc_Decoration:SetPoint("TOP", -70, -65)
Parangon_Orc_Decoration:SetFrameLevel(1)
Parangon_Orc_Decoration:SetAlpha(0.4)
Parangon_Orc_Decoration:SetFrameLevel(2)

-- Parangon Window | Text
local Parangon_Window_Text = Parangon_Window:CreateFontString("Parangon_Window_Text")
Parangon_Window_Text:SetFont("Fonts/FRIZQT__.TTF", 12)
Parangon_Window_Text:SetSize(999, 3)
Parangon_Window_Text:SetPoint("BOTTOM", 0, 70)
Parangon_Window_Text:SetShadowColor(0, 0, 0)
Parangon_Window_Text:SetShadowOffset(0.5, 0) -- Parangon Close Button
--

--[[

 PARANGON Window Close & Info Button

]] local Parangon_Close_Button =
    CreateFrame("Button", "Parangon_Close_Button", Parangon_Window, "UIPanelCloseButton")
Parangon_Close_Button:SetPoint("TOPRIGHT", 1.5, 3)
Parangon_Close_Button:EnableMouse(true)
Parangon_Close_Button:SetSize(26, 26)
Parangon_Close_Button:SetFrameLevel(2)

-- Parangon Info Button
local Parangon_Info_Button = CreateFrame("Button", "Parangon_Info_Button", Parangon_Window, nil)
Parangon_Info_Button:SetSize(26, 26)
Parangon_Info_Button:SetNormalTexture("Interface/common/help-i")
Parangon_Info_Button:SetHighlightTexture("Interface/common/help-i-hover")
Parangon_Info_Button:SetPoint("TOPRIGHT", -16, 3)
Parangon_Info_Button:SetFrameLevel(2)

Parangon_Info_Button:SetScript(
    "OnEnter",
    function(self, button, down)
        GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR_RIGHT")
        GameTooltip:AddLine(
            "Right click : |cFFFFC125Adds 1 point|r\nLeft click : |cFFFFC125Removes 1 point|r\nThumbwheel click : |cFFFFC125Adds 10 points|r\nWheel up / down: |cFFFFC125Adding / Removing points|r",
            1,
            1,
            1
        )
        GameTooltip:Show()
    end
)

Parangon_Info_Button:SetScript(
    "OnLeave",
    function(self, button, down)
        GameTooltip:Hide()
    end
) -- Window Title | Background
--

--[[

 PARANGON Window Title

]] local Parangon_Window_Title =
    CreateFrame("Frame", "Parangon_Window_Title", Parangon_Window, nil)
Parangon_Window_Title:SetSize(150, 64)
Parangon_Window_Title:SetBackdrop(
    {
        bgFile = "Interface/Parangon/TitleFrame",
        insets = {left = 5, right = 5, top = 5, bottom = 5}
    }
)
Parangon_Window_Title:SetPoint("TOP", 0, 27)
Parangon_Window_Title:SetFrameLevel(2)

-- Window Title | Text
local Parangon_Window_Title_Text = Parangon_Window_Title:CreateFontString("Parangon_Window_Title_Text")
Parangon_Window_Title_Text:SetFont("Fonts\\FRIZQT__.TTF", 13)
Parangon_Window_Title_Text:SetSize(190, 5)
Parangon_Window_Title_Text:SetPoint("CENTER", 0, 3)
Parangon_Window_Title_Text:SetText("|CFF000000Parangon|r") -- Level Background
--

--[[

 PARANGON Level Background

]] local Level_Background =
    CreateFrame("Frame", "Level_Background", Parangon_Window, nil)
Level_Background:SetSize(90, 90)
Level_Background:SetBackdrop(
    {
        bgFile = "Interface/Parangon/Level_Background",
        insets = {left = 5, right = 5, top = 5, bottom = 5}
    }
)
Level_Background:SetPoint("TOP", 0, -30)
Level_Background:SetFrameLevel(2)

-- Level Background | Text
local Parangon_Level_Text = Level_Background:CreateFontString("Parangon_Level_Text")
Parangon_Level_Text:SetFont("Fonts\\FRIZQT__.TTF", 14)
Parangon_Level_Text:SetSize(190, 3)
Parangon_Level_Text:SetPoint("CENTER", -1, 1)
Parangon_Level_Text:SetShadowColor(0.156, 0.2, 0.2)
Parangon_Level_Text:SetShadowOffset(0.5, 0) -- Strenght Button | Left | Border
--

--[[

 PARANGON Strenght Button's

]] local Parangon_Strenght_Left_Button =
    CreateFrame("Frame", "Parangon_Strenght_Left_Button", Parangon_Window, nil)
Parangon_Strenght_Left_Button:SetSize(50, 50)
Parangon_Strenght_Left_Button:SetBackdrop(
    {
        bgFile = "Interface/Parangon/ButtonBorder",
        insets = {left = 0, right = 0, top = 0, bottom = 0}
    }
)
Parangon_Strenght_Left_Button:SetPoint("LEFT", 15, 50)
Parangon_Strenght_Left_Button:SetFrameLevel(1000)
Parangon_Strenght_Left_Button:SetFrameLevel(3)

-- Strenght Button | Left | Background
local Parangon_Strenght_Left_Button_Background =
    CreateFrame("Frame", "Parangon_Strenght_Left_Button_Background", Parangon_Strenght_Left_Button, nil)
Parangon_Strenght_Left_Button_Background:SetSize(39, 39)
Parangon_Strenght_Left_Button_Background:SetBackdrop(
    {
        bgFile = "Interface/Icons/_D3mantraofconviction",
        insets = {left = 0, right = 0, top = 0, bottom = 0}
    }
)
Parangon_Strenght_Left_Button_Background:SetPoint("CENTER", 0, 0)
Parangon_Strenght_Left_Button_Background:SetFrameLevel(2)

-- Strenght Button | Center | Border
local Parangon_Strenght_Center_Button = CreateFrame("Button", "Parangon_Strenght_Center_Button", Parangon_Window, nil)
Parangon_Strenght_Center_Button:SetSize(170, 55)
Parangon_Strenght_Center_Button:SetNormalTexture("Interface/Parangon/LargeButtonBorder")
Parangon_Strenght_Center_Button:SetHighlightTexture("Interface/Parangon/LargeButtonBorder_Hover")
Parangon_Strenght_Center_Button:SetPushedTexture("Interface/Parangon/LargeButtonBorder_Push")
Parangon_Strenght_Center_Button:SetPoint("LEFT", 65, 50)
Parangon_Strenght_Center_Button:EnableMouseWheel(1)
Parangon_Strenght_Center_Button:SetFrameLevel(3)

Parangon_Strenght_Center_Button:SetScript(
    "OnMouseUp",
    function(self, button, down)
        if (button == "LeftButton") then
            AIO.Handle("AIO_Parangon", "setStatsIncrease", 7464, 1)
        elseif (button == "RightButton") then
            AIO.Handle("AIO_Parangon", "setStatsDecrease", 7464, 1)
        elseif (button == "MiddleButton") then
            AIO.Handle("AIO_Parangon", "setStatsIncrease", 7464, 10)
        end
    end
)

Parangon_Strenght_Center_Button:SetScript(
    "OnMouseWheel",
    function(self, value)
        if (value > 0) then
            AIO.Handle("AIO_Parangon", "setStatsIncrease", 7464, 1)
        else
            AIO.Handle("AIO_Parangon", "setStatsDecrease", 7464, 1)
        end
    end
)

-- Strenght Button | Center | Text
local Parangon_Strenght_Center_Text = Parangon_Strenght_Center_Button:CreateFontString("Parangon_Strenght_Center_Text")
Parangon_Strenght_Center_Text:SetFont("Interface/Fonts/MARCELLUS.TTF", 14)
Parangon_Strenght_Center_Text:SetSize(190, 3)
Parangon_Strenght_Center_Text:SetPoint("CENTER", -1, 1)
Parangon_Strenght_Center_Text:SetText("|CFFFFFFFFStrength|r")
Parangon_Strenght_Center_Text:SetShadowColor(0, 0, 0)
Parangon_Strenght_Center_Text:SetShadowOffset(0.5, 0.5)

-- Strenght Button | Right | Border
local Parangon_Strenght_Right_Button = CreateFrame("Frame", "Parangon_Strenght_Right_Button", Parangon_Window, nil)
Parangon_Strenght_Right_Button:SetSize(50, 50)
Parangon_Strenght_Right_Button:SetBackdrop(
    {
        bgFile = "Interface/Parangon/ButtonBorder_1",
        insets = {left = 0, right = 0, top = 0, bottom = 0}
    }
)
Parangon_Strenght_Right_Button:SetPoint("RIGHT", -16, 50)
Parangon_Strenght_Right_Button:SetFrameLevel(1000)
Parangon_Strenght_Right_Button:SetFrameLevel(2)

-- Strenght Button | Right | Text
local Parangon_Strenght_Right_Text = Parangon_Strenght_Right_Button:CreateFontString("Parangon_Strenght_Right_Text")
Parangon_Strenght_Right_Text:SetFont("Fonts/FRIZQT__.TTF", 14)
Parangon_Strenght_Right_Text:SetSize(190, 3)
Parangon_Strenght_Right_Text:SetPoint("CENTER", 0.5, 0)
Parangon_Strenght_Right_Text:SetShadowColor(0, 0, 0)
Parangon_Strenght_Right_Text:SetShadowOffset(0.5, 0) -- Agility Button | Left | Border
--

--[[

 PARANGON Agility Button's

]] local Parangon_Agility_Left_Button =
    CreateFrame("Frame", "Parangon_Agility_Left_Button", Parangon_Window, nil)
Parangon_Agility_Left_Button:SetSize(50, 50)
Parangon_Agility_Left_Button:SetBackdrop(
    {
        bgFile = "Interface/Parangon/ButtonBorder",
        insets = {left = 0, right = 0, top = 0, bottom = 0}
    }
)
Parangon_Agility_Left_Button:SetPoint("LEFT", 15, 0)
Parangon_Agility_Left_Button:SetFrameLevel(3)

-- Agility Button | Left | Background
local Parangon_Agility_Left_Button_Background =
    CreateFrame("Frame", "Parangon_Agility_Left_Button_Background", Parangon_Agility_Left_Button, nil)
Parangon_Agility_Left_Button_Background:SetSize(39, 39)
Parangon_Agility_Left_Button_Background:SetBackdrop(
    {
        bgFile = "Interface/Icons/_D3mantraofevasion",
        insets = {left = 0, right = 0, top = 0, bottom = 0}
    }
)
Parangon_Agility_Left_Button_Background:SetPoint("CENTER", 0, 0)
Parangon_Agility_Left_Button_Background:SetFrameLevel(2)

-- Agility Button | Center | Border
local Parangon_Agility_Center_Button = CreateFrame("Button", "Parangon_Agility_Center_Button", Parangon_Window, nil)
Parangon_Agility_Center_Button:SetSize(170, 55)
Parangon_Agility_Center_Button:SetNormalTexture("Interface/Parangon/LargeButtonBorder")
Parangon_Agility_Center_Button:SetHighlightTexture("Interface/Parangon/LargeButtonBorder_Hover")
Parangon_Agility_Center_Button:SetPushedTexture("Interface/Parangon/LargeButtonBorder_Push")
Parangon_Agility_Center_Button:SetPoint("LEFT", 65, 0)
Parangon_Agility_Center_Button:EnableMouseWheel(1)
Parangon_Agility_Center_Button:SetFrameLevel(3)

Parangon_Agility_Center_Button:SetScript(
    "OnMouseUp",
    function(self, button, down)
        if (button == "LeftButton") then
            AIO.Handle("AIO_Parangon", "setStatsIncrease", 7471, 1)
        elseif (button == "RightButton") then
            AIO.Handle("AIO_Parangon", "setStatsDecrease", 7471, 1)
        elseif (button == "MiddleButton") then
            AIO.Handle("AIO_Parangon", "setStatsIncrease", 7471, 10)
        end
    end
)

Parangon_Agility_Center_Button:SetScript(
    "OnMouseWheel",
    function(self, value)
        if (value > 0) then
            AIO.Handle("AIO_Parangon", "setStatsIncrease", 7471, 1)
        else
            AIO.Handle("AIO_Parangon", "setStatsDecrease", 7471, 1)
        end
    end
)

-- Agility Button | Center | Text
local Parangon_Agility_Center_Text = Parangon_Agility_Center_Button:CreateFontString("Parangon_Agility_Center_Text")
Parangon_Agility_Center_Text:SetFont("Interface/Fonts/MARCELLUS.TTF", 14)
Parangon_Agility_Center_Text:SetSize(190, 3)
Parangon_Agility_Center_Text:SetPoint("CENTER", -1, 1)
Parangon_Agility_Center_Text:SetText("|CFFFFFFFFAgility|r")
Parangon_Agility_Center_Text:SetShadowColor(0, 0, 0)
Parangon_Agility_Center_Text:SetShadowOffset(0.5, 0.5)

-- Agility Button | Right | Border
local Parangon_Agility_Right_Button = CreateFrame("Frame", "Parangon_Agility_Right_Button", Parangon_Window, nil)
Parangon_Agility_Right_Button:SetSize(50, 50)
Parangon_Agility_Right_Button:SetBackdrop(
    {
        bgFile = "Interface/Parangon/ButtonBorder_1",
        insets = {left = 0, right = 0, top = 0, bottom = 0}
    }
)
Parangon_Agility_Right_Button:SetPoint("RIGHT", -16, 0)
Parangon_Agility_Right_Button:SetFrameLevel(2)

-- Agility Button | Right | Text
local Parangon_Agility_Right_Text = Parangon_Agility_Right_Button:CreateFontString("Parangon_Agility_Right_Text")
Parangon_Agility_Right_Text:SetFont("Fonts/FRIZQT__.TTF", 14)
Parangon_Agility_Right_Text:SetSize(190, 3)
Parangon_Agility_Right_Text:SetPoint("CENTER", 0.5, 0)
Parangon_Agility_Right_Text:SetShadowColor(0, 0, 0)
Parangon_Agility_Right_Text:SetShadowOffset(0.5, 0) -- Stamina Button | Left | Border
--

--[[

 PARANGON Stamina Button's

]] local Parangon_Stamina_Left_Button =
    CreateFrame("Frame", "Parangon_Stamina_Left_Button", Parangon_Window, nil)
Parangon_Stamina_Left_Button:SetSize(50, 50)
Parangon_Stamina_Left_Button:SetBackdrop(
    {
        bgFile = "Interface/Parangon/ButtonBorder",
        insets = {left = 0, right = 0, top = 0, bottom = 0}
    }
)
Parangon_Stamina_Left_Button:SetPoint("LEFT", 15, -50)
Parangon_Stamina_Left_Button:SetFrameLevel(3)

-- Stamina Button | Left | Background
local Parangon_Stamina_Left_Button_Background =
    CreateFrame("Frame", "Parangon_Stamina_Left_Button_Background", Parangon_Stamina_Left_Button, nil)
Parangon_Stamina_Left_Button_Background:SetSize(39, 39)
Parangon_Stamina_Left_Button_Background:SetBackdrop(
    {
        bgFile = "Interface/Icons/_D3mantraofretribution",
        insets = {left = 0, right = 0, top = 0, bottom = 0}
    }
)
Parangon_Stamina_Left_Button_Background:SetPoint("CENTER", 0, 0)
Parangon_Stamina_Left_Button_Background:SetFrameLevel(2)

-- Stamina Button | Center | Border
local Parangon_Stamina_Center_Button = CreateFrame("Button", "Parangon_Stamina_Center_Button", Parangon_Window, nil)
Parangon_Stamina_Center_Button:SetSize(170, 55)
Parangon_Stamina_Center_Button:SetNormalTexture("Interface/Parangon/LargeButtonBorder")
Parangon_Stamina_Center_Button:SetHighlightTexture("Interface/Parangon/LargeButtonBorder_Hover")
Parangon_Stamina_Center_Button:SetPushedTexture("Interface/Parangon/LargeButtonBorder_Push")
Parangon_Stamina_Center_Button:SetPoint("LEFT", 65, -50)
Parangon_Stamina_Center_Button:EnableMouseWheel(1)
Parangon_Stamina_Center_Button:SetFrameLevel(3)

Parangon_Stamina_Center_Button:SetScript(
    "OnMouseUp",
    function(self, button, down)
        if (button == "LeftButton") then
            AIO.Handle("AIO_Parangon", "setStatsIncrease", 7477, 1)
        elseif (button == "RightButton") then
            AIO.Handle("AIO_Parangon", "setStatsDecrease", 7477, 1)
        elseif (button == "MiddleButton") then
            AIO.Handle("AIO_Parangon", "setStatsIncrease", 7477, 10)
        end
    end
)

Parangon_Stamina_Center_Button:SetScript(
    "OnMouseWheel",
    function(self, value)
        if (value > 0) then
            AIO.Handle("AIO_Parangon", "setStatsIncrease", 7477, 1)
        else
            AIO.Handle("AIO_Parangon", "setStatsDecrease", 7477, 1)
        end
    end
)

-- Stamina Button | Center | Text
local Parangon_Stamina_Center_Text = Parangon_Stamina_Center_Button:CreateFontString("Parangon_Stamina_Center_Text")
Parangon_Stamina_Center_Text:SetFont("Interface/Fonts/MARCELLUS.TTF", 14)
Parangon_Stamina_Center_Text:SetSize(190, 3)
Parangon_Stamina_Center_Text:SetPoint("CENTER", -1, 1)
Parangon_Stamina_Center_Text:SetText("|CFFFFFFFFStamina|r")
Parangon_Stamina_Center_Text:SetShadowColor(0, 0, 0)
Parangon_Stamina_Center_Text:SetShadowOffset(0.5, 0.5)

-- Stamina Button | Right | Border
local Parangon_Stamina_Right_Button = CreateFrame("Frame", "Parangon_Stamina_Right_Button", Parangon_Window, nil)
Parangon_Stamina_Right_Button:SetSize(50, 50)
Parangon_Stamina_Right_Button:SetBackdrop(
    {
        bgFile = "Interface/Parangon/ButtonBorder_1",
        insets = {left = 0, right = 0, top = 0, bottom = 0}
    }
)
Parangon_Stamina_Right_Button:SetPoint("RIGHT", -16, -50)
Parangon_Stamina_Right_Button:SetFrameLevel(2)

-- Stamina Button | Right | Text
local Parangon_Stamina_Right_Text = Parangon_Stamina_Right_Button:CreateFontString("Parangon_Stamina_Right_Text")
Parangon_Stamina_Right_Text:SetFont("Fonts/FRIZQT__.TTF", 14)
Parangon_Stamina_Right_Text:SetSize(190, 3)
Parangon_Stamina_Right_Text:SetPoint("CENTER", 0.5, 0)
Parangon_Stamina_Right_Text:SetShadowColor(0, 0, 0)
Parangon_Stamina_Right_Text:SetShadowOffset(0.5, 0) -- Intellect Button | Left | Border
--

--[[

 PARANGON Intellect Button's

]] local Parangon_Intellect_Left_Button =
    CreateFrame("Frame", "Parangon_Intellect_Left_Button", Parangon_Window, nil)
Parangon_Intellect_Left_Button:SetSize(50, 50)
Parangon_Intellect_Left_Button:SetBackdrop(
    {
        bgFile = "Interface/Parangon/ButtonBorder",
        insets = {left = 0, right = 0, top = 0, bottom = 0}
    }
)
Parangon_Intellect_Left_Button:SetPoint("LEFT", 15, -100)
Parangon_Intellect_Left_Button:SetFrameLevel(3)

-- Intellect Button | Left | Background
local Parangon_Intellect_Left_Button_Background =
    CreateFrame("Frame", "Parangon_Intellect_Left_Button_Background", Parangon_Intellect_Left_Button, nil)
Parangon_Intellect_Left_Button_Background:SetSize(39, 39)
Parangon_Intellect_Left_Button_Background:SetBackdrop(
    {
        bgFile = "Interface/Icons/_D3mantraofhealing",
        insets = {left = 0, right = 0, top = 0, bottom = 0}
    }
)
Parangon_Intellect_Left_Button_Background:SetPoint("CENTER", 0, 0)
Parangon_Intellect_Left_Button_Background:SetFrameLevel(2)

-- Intellect Button | Center | Border
local Parangon_Intellect_Center_Button = CreateFrame("Button", "Parangon_Intellect_Center_Button", Parangon_Window, nil)
Parangon_Intellect_Center_Button:SetSize(170, 55)
Parangon_Intellect_Center_Button:SetNormalTexture("Interface/Parangon/LargeButtonBorder")
Parangon_Intellect_Center_Button:SetHighlightTexture("Interface/Parangon/LargeButtonBorder_Hover")
Parangon_Intellect_Center_Button:SetPushedTexture("Interface/Parangon/LargeButtonBorder_Push")
Parangon_Intellect_Center_Button:SetPoint("LEFT", 65, -100)
Parangon_Intellect_Center_Button:EnableMouseWheel(1)
Parangon_Intellect_Center_Button:SetFrameLevel(3)

Parangon_Intellect_Center_Button:SetScript(
    "OnMouseUp",
    function(self, button, down)
        if (button == "LeftButton") then
            AIO.Handle("AIO_Parangon", "setStatsIncrease", 7468, 1)
        elseif (button == "RightButton") then
            AIO.Handle("AIO_Parangon", "setStatsDecrease", 7468, 1)
        elseif (button == "MiddleButton") then
            AIO.Handle("AIO_Parangon", "setStatsIncrease", 7468, 10)
        end
    end
)

Parangon_Intellect_Center_Button:SetScript(
    "OnMouseWheel",
    function(self, value)
        if (value > 0) then
            AIO.Handle("AIO_Parangon", "setStatsIncrease", 7468, 1)
        else
            AIO.Handle("AIO_Parangon", "setStatsDecrease", 7468, 1)
        end
    end
)

-- Intellect Button | Center | Text
local Parangon_Intellect_Center_Text =
    Parangon_Intellect_Center_Button:CreateFontString("Parangon_Intellect_Center_Text")
Parangon_Intellect_Center_Text:SetFont("Interface/Fonts/MARCELLUS.TTF", 14)
Parangon_Intellect_Center_Text:SetSize(190, 3)
Parangon_Intellect_Center_Text:SetPoint("CENTER", -1, 1)
Parangon_Intellect_Center_Text:SetText("|CFFFFFFFFIntellect|r")
Parangon_Intellect_Center_Text:SetShadowColor(0, 0, 0)
Parangon_Intellect_Center_Text:SetShadowOffset(0.5, 0.5)

-- Intellect Button | Right | Border
local Parangon_Intellect_Right_Button = CreateFrame("Frame", "Parangon_Intellect_Right_Button", Parangon_Window, nil)
Parangon_Intellect_Right_Button:SetSize(50, 50)
Parangon_Intellect_Right_Button:SetBackdrop(
    {
        bgFile = "Interface/Parangon/ButtonBorder_1",
        insets = {left = 0, right = 0, top = 0, bottom = 0}
    }
)
Parangon_Intellect_Right_Button:SetPoint("RIGHT", -16, -100)
Parangon_Intellect_Right_Button:SetFrameLevel(2)

-- Intellect Button | Right | Text
local Parangon_Intellect_Right_Text = Parangon_Intellect_Right_Button:CreateFontString("Parangon_Intellect_Right_Text")
Parangon_Intellect_Right_Text:SetFont("Fonts/FRIZQT__.TTF", 14)
Parangon_Intellect_Right_Text:SetSize(190, 3)
Parangon_Intellect_Right_Text:SetPoint("CENTER", 0.5, 0)
Parangon_Intellect_Right_Text:SetShadowColor(0, 0, 0)
Parangon_Intellect_Right_Text:SetShadowOffset(0.5, 0) -- Save Button
--

--[[

 PARANGON Save Button

]] local Parangon_Save_Button =
    CreateFrame("Button", "Parangon_Save_Button", Parangon_Window, nil)
Parangon_Save_Button:SetSize(180, 32)
Parangon_Save_Button:SetNormalTexture("Interface/buttons/ui-dialogbox-button-gold-up")
Parangon_Save_Button:SetHighlightTexture("Interface/buttons/ui-dialogbox-button-highlight")
Parangon_Save_Button:SetPushedTexture("Interface/buttons/ui-dialogbox-button-gold-down")
Parangon_Save_Button:SetPoint("BOTTOM", 0, 10)
Parangon_Save_Button:EnableMouseWheel(1)
Parangon_Save_Button:SetFrameLevel(2)

Parangon_Save_Button:SetScript(
    "OnMouseUp",
    function(self, button, down)
        if (button == "LeftButton") then
            Parangon_Window:Hide()
            AIO.Handle("AIO_Parangon", "setStats")
        end
    end
)

-- Save Button | Text
local Parangon_Save_Button_Text = Parangon_Save_Button:CreateFontString("Parangon_Save_Button_Text")
Parangon_Save_Button_Text:SetFont("Fonts/FRIZQT__.TTF", 12)
Parangon_Save_Button_Text:SetSize(180, 3)
Parangon_Save_Button_Text:SetPoint("CENTER", 0, 5)
Parangon_Save_Button_Text:SetText("|CFFFFFFFFAccept changes|r")
Parangon_Save_Button_Text:SetShadowColor(0, 0, 0)
Parangon_Save_Button_Text:SetShadowOffset(0.5, 0.5)

function Parangon.setInfo(player, stat1, stat2, stat3, stat4, level, points)
    Parangon_Level_Text:SetText("|CFFFFFFFF" .. level .. "|r")
    Parangon_Window_Text:SetText("You still have |CFF00CE00" .. points .. "|r left to spend.")
    Parangon_Strenght_Right_Text:SetText("|CFF00CE00" .. stat1 .. "|r")
    Parangon_Agility_Right_Text:SetText("|CFF00CE00" .. stat2 .. "|r")
    Parangon_Stamina_Right_Text:SetText("|CFF00CE00" .. stat3 .. "|r")
    Parangon_Intellect_Right_Text:SetText("|CFF00CE00" .. stat4 .. "|r")
end
