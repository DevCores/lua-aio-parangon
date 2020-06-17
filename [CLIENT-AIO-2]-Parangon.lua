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

local AIO_Storage = AIO.AddHandlers("AIO_Storage", {});

--[[

 STORAGE Window

]]--

  -- Storage Window
  local Storage_Window = CreateFrame("Frame", "Storage_Window", CharacterFrame);
    Storage_Window:SetSize(55, 55)
    Storage_Window:RegisterForDrag("LeftButton")
    Storage_Window:SetPoint("TOP", 181, -32)
    Storage_Window:SetBackdrop(
    {
        bgFile = "Interface/bankframe/bank-background",
        edgeFile = "Interface/DialogFrame/UI-DialogBox-Border",
        edgeSize = 20,
        insets = { left = 5, right = 5, top = 5, bottom = 5 }
    })
    Storage_Window:SetFrameLevel(5);
    -- Enable dragging of frame


    -- Storage Window | Options
      Storage_Window:SetMovable(false)
      Storage_Window:EnableMouse(true)
      Storage_Window:SetClampedToScreen(true)
      Storage_Window:SetScript("OnDragStart", Storage_Window.StartMoving)
      Storage_Window:SetScript("OnHide", Storage_Window.StopMovingOrSizing)
      Storage_Window:SetScript("OnDragStop", Storage_Window.StopMovingOrSizing)


-- Parangon
  local Storage_Parangon_Border = CreateFrame("Button", "Storage_Parangon_Border", Storage_Window, nil);
    Storage_Parangon_Border:SetSize(50, 50);
    Storage_Parangon_Border:SetNormalTexture("Interface/Parangon/ButtonBorder");
    Storage_Parangon_Border:SetHighlightTexture("Interface/Parangon/ButtonBorder_Hover");
    Storage_Parangon_Border:SetPushedTexture("Interface/Parangon/ButtonBorder_1_Push");
    Storage_Parangon_Border:SetPoint("CENTER", 0, 0);
    Storage_Parangon_Border:EnableMouseWheel(1);
    Storage_Parangon_Border:SetFrameLevel(1000);
    Storage_Parangon_Border:SetFrameLevel(7);

    Storage_Parangon_Border:SetScript("OnMouseUp", function (self, button, down)
      if(Parangon_Window:IsShown())then
        Parangon_Window:Hide();
      else
        Parangon_Window:Show();
        D3Wings_ScrollFrame:Hide();
        D3Wings_ModelWindow:Hide();
      end
    end
    );

  local Storage_Parangon_Background = CreateFrame("Frame", "Storage_Parangon_Background", Storage_Parangon_Border, nil);
    Storage_Parangon_Background:SetSize(39, 39);
    Storage_Parangon_Background:SetBackdrop(
    {
        bgFile = "Interface/Icons/_LDAKnowledge",
        insets = { left = 0, right = 0, top = 0, bottom = 0 }
    });
    Storage_Parangon_Background:SetPoint("CENTER", 0, 0);
    Storage_Parangon_Background:SetFrameLevel(6);

    Storage_Parangon_Border:SetScript("OnEnter", function (self, button, down)
      GameTooltip:SetOwner(UIParent, "ANCHOR_BOTTOMRIGHT", 150, 150);
      GameTooltip:AddLine("Paragon Infos", 1, 1, 1);
      GameTooltip:AddLine("Displays/hides the Paragon points allocation window.\n"..Parangon_Window_Text:GetText());
      GameTooltip:AddLine("\r|CFFFFFFFF+ "..Parangon_Strenght_Right_Text:GetText().."|CFFFFFFFF Strength|r");
      GameTooltip:AddLine("|CFFFFFFFF+ "..Parangon_Agility_Right_Text:GetText().."|CFFFFFFFF Agility");
      GameTooltip:AddLine("|CFFFFFFFF+ "..Parangon_Stamina_Right_Text:GetText().."|CFFFFFFFF Stamina");
      GameTooltip:AddLine("|CFFFFFFFF+ "..Parangon_Intellect_Right_Text:GetText().."|CFFFFFFFF Intellect|r");

      GameTooltip:Show();
    end);

    Storage_Parangon_Border:SetScript("OnLeave", function (self, button, down)
      GameTooltip:Hide();
    end);
