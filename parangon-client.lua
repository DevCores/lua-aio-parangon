--[[
    Created by iThorgrim

        Parangon with Interface

 You are going to use a script shared by myself (iThorgrim) so i would ask you to respect my work and not to assign this work to you.
 If you want to learn more about World of Warcraft development.

 (Only for French speaking people.)
 Open-Wow -> https://open-wow.eu
 Discord -> https://discord.gg/JUYgbNMwQu

 If you wish to thank me for my work you can make a small donation.
 Paypal ->

 Thank you for using my script, if you have a suggestion or a problem with it please make a topic about it:
 Issues -> https://github.com/iThorgrim-Hub/lua-aio-parangon/issues

 See you soon for a next script.
]]--

local aio = AIO or require("AIO");
if aio.AddAddon() then
  return
end

local parangon = {
  parangon_aio = aio.AddHandlers("AIO_Parangon", {})
}

parangon.mainWindow = CreateFrame("Frame", parangon.mainWindow, UIParent)
  parangon.mainWindow:SetSize(350, 500);
  parangon.mainWindow:SetMovable(false);
  parangon.mainWindow:EnableMouse(true);
  parangon.mainWindow:RegisterForDrag("Right_Button")
  parangon.mainWindow:SetPoint("CENTER", 0, 50)
  parangon.mainWindow:Show()

parangon.mainWindowTexture = parangon.mainWindow:CreateTexture()
  parangon.mainWindowTexture:SetAllPoints(parangon.mainWindow)
  parangon.mainWindowTexture:SetTexture("interface/parangon/parangon_frame")
  parangon.mainWindowTexture:SetTexCoord(0.58154296875, 0.96435546875, 0.04052734375, 0.81201171875)

parangon.mainWindowArt = CreateFrame("Button", parangon.mainWindowArt, parangon.mainWindow)
  parangon.mainWindowArt:SetSize(180, 110)
  parangon.mainWindowArt:SetPoint("TOP", -80, -65)
  parangon.mainWindowArt:SetFrameLevel(1)
  parangon.mainWindowArt:SetAlpha(0.4)
  parangon.mainWindowArt:SetFrameLevel(2)

parangon.mainWindowArtTexture = parangon.mainWindowArt:CreateTexture()
  parangon.mainWindowArtTexture:SetAllPoints(parangon.mainWindowArt)
  parangon.mainWindowArtTexture:SetTexture("interface/parangon/parangon_frame")
  parangon.mainWindowArtTexture:SetTexCoord(0.00048828125, 0.35009765625, 0.00048828125, 0.21435546875)


parangon.buttonsCoords = {
  global = {
    pos_y = 50
  }
}

parangon.leftButtons = {}
parangon.leftButtonsTexture = {}

parangon.leftButtonsArt = {}

parangon.centerButtons = {}
parangon.centerText = {}

parangon.rightButtons = {}
parangon.rightButtonsTexture = {}

parangon.spellsList = {
  [7464] = {name = 'Strength', icon = '_D3mantraofconviction'},
  [7471] = {name = 'Agility', icon = '_D3mantraofevasion'},
  [7477] = {name = 'Stamina', icon = '_D3mantraofretribution'},
  [7468] = {name = 'Intellect', icon = '_D3mantraofhealing'},
}

for id, subtable in pairs(parangon.spellsList) do
  parangon.leftButtons[id] = CreateFrame("Frame", parangon.leftButtons[id], parangon.mainWindow)
    parangon.leftButtons[id]:SetSize(50, 50)
    parangon.leftButtons[id]:SetPoint("LEFT", 20, parangon.buttonsCoords.global.pos_y)
    parangon.leftButtons[id]:SetFrameLevel(1000)
    parangon.leftButtons[id]:SetFrameLevel(3)

  parangon.leftButtonsTexture[id] = parangon.leftButtons[id]:CreateTexture()
    parangon.leftButtonsTexture[id]:SetAllPoints(parangon.leftButtons[id])
    parangon.leftButtonsTexture[id]:SetTexture("interface/parangon/parangon_frame")
    parangon.leftButtonsTexture[id]:SetTexCoord(0.05029296875, 0.14794921875, 0.86669921875, 0.96337890625)

  parangon.leftButtonsArt[id] = CreateFrame("Frame", parangon.leftButtonsArt[id], parangon.leftButtons[id], nil)
  parangon.leftButtonsArt[id]:SetSize(45, 45)
  parangon.leftButtonsArt[id]:SetBackdrop(
    {
      bgFile = "Interface/Icons/"..subtable.icon,
      insets = {left = 0, right = 0, top = 0, bottom = 0}
    }
  )
  parangon.leftButtonsArt[id]:SetPoint("CENTER", 0, 0)
  parangon.leftButtonsArt[id]:SetFrameLevel(2)

  parangon.centerButtons[id] = CreateFrame("Button", parangon.centerButtons[id], parangon.mainWindow, nil)
    parangon.centerButtons[id]:SetSize(200, 65)
    parangon.centerButtons[id]:SetPoint("CENTER", 0, parangon.buttonsCoords.global.pos_y)
    parangon.centerButtons[id]:SetNormalTexture("Interface/Parangon/LargeButtonBorder")
    parangon.centerButtons[id]:SetHighlightTexture("Interface/Parangon/LargeButtonBorder_Hover")
    parangon.centerButtons[id]:SetPushedTexture("Interface/Parangon/LargeButtonBorder_Push")
    parangon.centerButtons[id]:EnableMouseWheel(1)
    parangon.centerButtons[id]:SetFrameLevel(3)

    parangon.centerText[id] = parangon.centerButtons[id]:CreateFontString(parangon.centerText[id])
      parangon.centerText[id]:SetFont("Interface/Fonts/MARCELLUS.TTF", 14)
      parangon.centerText[id]:SetSize(190, 3)
      parangon.centerText[id]:SetPoint("CENTER", -1, 1)
      parangon.centerText[id]:SetText("|CFFFFFFFF"..subtable.name.."|r")
      parangon.centerText[id]:SetShadowColor(0, 0, 0)
      parangon.centerText[id]:SetShadowOffset(0.5, 0.5)

  parangon.rightButtons[id] = CreateFrame("Frame", parangon.rightButtons[id], parangon.mainWindow)
    parangon.rightButtons[id]:SetSize(50, 50)
    parangon.rightButtons[id]:SetPoint("Right", -20, parangon.buttonsCoords.global.pos_y)
    parangon.rightButtons[id]:SetFrameLevel(1000)
    parangon.rightButtons[id]:SetFrameLevel(3)

  parangon.rightButtonsTexture[id] = parangon.rightButtons[id]:CreateTexture()
    parangon.rightButtonsTexture[id]:SetAllPoints(parangon.rightButtons[id])
    parangon.rightButtonsTexture[id]:SetTexture("interface/parangon/parangon_frame")
    parangon.rightButtonsTexture[id]:SetTexCoord(0.19287109375, 0.28955078125, 0.86669921875, 0.96240234375)

  parangon.buttonsCoords.global.pos_y = parangon.buttonsCoords.global.pos_y - 60
end

parangon.saveButton = CreateFrame("Button", parangon.saveButton, parangon.mainWindow)
  parangon.saveButton:SetSize(200, 40)
  parangon.saveButton:SetNormalTexture("Interface/buttons/ui-dialogbox-button-gold-up")
  parangon.saveButton:SetHighlightTexture("Interface/buttons/ui-dialogbox-button-highlight")
  parangon.saveButton:SetPushedTexture("Interface/buttons/ui-dialogbox-button-gold-down")
  parangon.saveButton:SetPoint("BOTTOM", 0, 20)
  parangon.saveButton:SetFrameLevel(2)

parangon.saveButtonText = parangon.saveButton:CreateFontString(parangon.saveButtonText)
  parangon.saveButtonText:SetFont("Fonts/FRIZQT__.TTF", 12)
  parangon.saveButtonText:SetSize(180, 3)
  parangon.saveButtonText:SetPoint("CENTER", 0, 6)
  parangon.saveButtonText:SetText("|CFFFFFFFFAccept changes|r")
  parangon.saveButtonText:SetShadowColor(0, 0, 0)
  parangon.saveButtonText:SetShadowOffset(0.5, 0.5)
