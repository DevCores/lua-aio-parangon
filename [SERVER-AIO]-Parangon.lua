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



--[[ ///// CONFIG \\\\\ ]]--
local Config = {};

  -- Name of Eluna dB
  Config.dbName = 'ac_eluna';
  -- Number of points per Parangon Level
  Config.pointsPerLevel = 1;
  -- Minimum Level for Parangon
  Config.minLevel = 70;
  -- Exp Multiplicator
  Config.expMulti = 1;
  -- Exp for Level 1 to Level 2.
  -- This will be multiplied by the multiplicator for the newt level
  -- ( (Config.expMax * ParangonPlayerLevel) * Config.expMulti) )
  Config.expMax = 500;

  Config.pveKill = 100;
  Config.pvpKill = 10;


--
--
--[[ ///// SYSTEM \\\\\ ]]--
local AIO = AIO or require("AIO")
local Parangon = AIO.AddHandlers("AIO_Parangon", {})
local PlayerAccount = {};
local PlayerCharacter = {};

CharDBQuery('CREATE DATABASE IF NOT EXISTS `'..Config.dbName..'`;');
CharDBQuery('CREATE TABLE IF NOT EXISTS `'..Config.dbName..'`.`account_parangon` (`account_id` INT(11) NOT NULL, `level` INT(11) DEFAULT 1, `exp` INT(11) DEFAULT 0, PRIMARY KEY (`account_id`) );');
CharDBQuery('CREATE TABLE IF NOT EXISTS `'..Config.dbName..'`.`characters_parangon` (`account_id` INT(11) NOT NULL, `guid` INT(11) NOT NULL, `strength` INT(11) DEFAULT 0, `agility` INT(11) DEFAULT 0, `stamina` INT(11) DEFAULT 0, `intellect` INT(11) DEFAULT 0, PRIMARY KEY (`account_id`, `guid`));');

--
--
--[[ ///// PARANGON SERVER FUNCTION \\\\\ ]]--
  function Parangon.sendInformations(msg, player)
    local pGuid = player:GetGUIDLow()
    local pAcc = player:GetAccountId()

    return msg:Add(
        "AIO_Parangon",
        "setInfo",
        PlayerCharacter[pGuid][7464],
        PlayerCharacter[pGuid][7471],
        PlayerCharacter[pGuid][7477],
        PlayerCharacter[pGuid][7468],
        PlayerAccount[pAcc].level,
        PlayerCharacter[pGuid].points
    );
  end
  AIO.AddOnInit(Parangon.sendInformations);

  function Parangon.setAddonInfo(player)
    Parangon.sendInformations(AIO.Msg(), player):Send(player)
  end


--
--
--[[ ///// PARANGON SERVER FUNCTION \\\\\ ]]--
  function Parangon.setStats(player)
    local pLevel = player:GetLevel();

    if (pLevel >= Config.minLevel) then
      local pGuid = player:GetGUIDLow();
      for spell, value in pairs(PlayerCharacter[pGuid]) do
        if (spell ~= 'points') then
          player:RemoveAura(spell);
          player:AddAura(spell, player);
          player:GetAura(spell):SetStackAmount(value);
        end
      end
    end
  end

  function Parangon.setStatsIncrease(player, stat, value)
    if (player:IsInCombat()) then
      player:SendNotification('You can\'t do this in combat.');
    elseif (player:GetLevel() < Config.minLevel) then
      player:SendNotification('You don\'t have the level required to do that.');
    else
      local pGuid = player:GetGUIDLow();
      local pAcc = player:GetAccountId();
      if ((PlayerCharacter[pGuid].points - value) < 0) then
        player:SendNotification('You have no more points to award.');
      else
        PlayerCharacter[pGuid][stat] = PlayerCharacter[pGuid][stat] + value;
        PlayerCharacter[pGuid].points = (PlayerAccount[pAcc].level * Config.pointsPerLevel) - PlayerCharacter[pGuid][7464] - PlayerCharacter[pGuid][7471] - PlayerCharacter[pGuid][7477] - PlayerCharacter[pGuid][7468];
        Parangon.setAddonInfo(player);
      end
    end
  end

  function Parangon.setStatsDecrease(player, stat, value)
    if (player:IsInCombat()) then
      player:SendNotification('You can\'t do this in combat.');
    elseif (player:GetLevel() < Config.minLevel) then
      player:SendNotification('You don\'t have the level required to do that.');
    else
      local pGuid = player:GetGUIDLow();
      local pAcc = player:GetAccountId();

      if (PlayerCharacter[pGuid][stat] <= 0) then
        player:SendNotification('You have no points to take out.');
      else
        PlayerCharacter[pGuid][stat] = PlayerCharacter[pGuid][stat] - value;
        PlayerCharacter[pGuid].points = (PlayerAccount[pAcc].level * Config.pointsPerLevel) - PlayerCharacter[pGuid][7464] - PlayerCharacter[pGuid][7471] - PlayerCharacter[pGuid][7477] - PlayerCharacter[pGuid][7468];
        Parangon.setAddonInfo(player);
      end
    end
  end


--
--
--[[ ///// GET PLAYER \\\\\ ]]--
  function Parangon.getAccountInfo(player)
    local pAcc = player:GetAccountId();
    PlayerAccount[pAcc] = {};

    local getAccount = CharDBQuery('SELECT * FROM `'..Config.dbName..'`.`account_parangon` WHERE account_id = '..pAcc..';');
    if (getAccount) then
      PlayerAccount[pAcc] = {
        level = getAccount:GetUInt32(1),
        exp = getAccount:GetUInt32(2);
      };
    else
      local setAccount = CharDBQuery('INSERT INTO `'..Config.dbName..'`.`account_parangon` VALUES ('..pAcc..', 1, 0);');
      PlayerAccount[pAcc] = {
        level = 1,
        exp = 0;
      };
    end

    return PlayerAccount[pAcc];
  end

  function Parangon.getPlayerInfo(player)
    local pAcc = player:GetAccountId();
    local pGuid = player:GetGUIDLow();
    PlayerCharacter[pGuid] = {};

    local getCharacter = CharDBQuery('SELECT * FROM `'..Config.dbName..'`.`characters_parangon` WHERE guid = '..pGuid..' AND account_id = '..pAcc..';');
    if (getCharacter) then
      PlayerCharacter[pGuid] = {
        [7464] = getCharacter:GetUInt32(2), -- Strenght
        [7471] = getCharacter:GetUInt32(3), -- Agility
        [7477] = getCharacter:GetUInt32(4), -- Stamina
        [7468] = getCharacter:GetUInt32(5), -- Intellect
        points = (PlayerAccount[pAcc].level * Config.pointsPerLevel) - getCharacter:GetUInt32(2) - getCharacter:GetUInt32(3) - getCharacter:GetUInt32(4) - getCharacter:GetUInt32(5);
      };
    else
      local setCharacter = CharDBQuery('INSERT INTO `'..Config.dbName..'`.`characters_parangon` VALUES ('..pAcc..', '..pGuid..', 0, 0, 0, 0);');
      PlayerCharacter[pGuid] = {
        [7464] = 0, -- Strenght
        [7471] = 0, -- Agility
        [7477] = 0, -- Stamina
        [7468] = 0, -- Intellect
        points = (PlayerAccount[pAcc].level * Config.pointsPerLevel);
      };
    end

    return PlayerCharacter[pGuid];
  end

  function Parangon.getPlayer(event, player)
    local pAcc = player:GetAccountId();
    if (not PlayerAccount[pAcc]) then
      Parangon.getAccountInfo(player);
    end

    local pGuid = player:GetGUIDLow();
    if (not PlayerCharacter[pGuid]) then
      Parangon.getPlayerInfo(player);
    end

    Parangon.setStats(player);
  end
  RegisterPlayerEvent(3, Parangon.getPlayer);

  function Parangon.getPlayers(event)
    for _, player in pairs(GetPlayersInWorld()) do
      Parangon.getPlayer(event, player);
    end
  end
  RegisterServerEvent(33, Parangon.getPlayers);


--
--
--[[ ///// SET PLAYER \\\\\ ]]--
  function Parangon.setPlayer(event, player)
    local pAcc = player:GetAccountId();
    local pGuid = player:GetGUIDLow();

    local setAccount = CharDBExecute('UPDATE `'..Config.dbName..'`.`account_parangon` SET level = '..PlayerAccount[pAcc].level..', exp = '..PlayerAccount[pAcc].exp..' WHERE account_id = '..pAcc..';');
    local setCharacter = CharDBExecute('UPDATE `'..Config.dbName..'`.`characters_parangon` SET `strength` = '..PlayerCharacter[pGuid][7464]..', `agility` = '..PlayerCharacter[pGuid][7471]..', `stamina` = '..PlayerCharacter[pGuid][7477]..', `intellect` = '..PlayerCharacter[pGuid][7468]..' WHERE account_id = '..pAcc..' AND guid = '..pGuid..';');
  end
  RegisterPlayerEvent(4, Parangon.setPlayer);

  function Parangon.setPlayers(event)
    for _, player in pairs(GetPlayersInWorld()) do
      Parangon.setPlayer(event, player);
    end
  end
  RegisterServerEvent(16, Parangon.setPlayers);

--
--
--[[ ///// SOME PLAYER FUNCTIONS \\\\\ ]]--
function ParangonAddon.setLevelUp(event, player)
  local pAcc = player:GetAccountId()

  if (PlayerAccount[pAcc].exp >= (PlayerAccount[pAcc].level * Parangon.Config.maxExp)) then
    if (PlayerAccount[pAcc].level < Parangon.Config.maxLevel) then
      PlayerAccount[pAcc].level = PlayerAccount[pAcc].level + 1
      PlayerAccount[pAcc].exp = 0
      player:SendBroadcastMessage("Congratulations, you've just climbed up a level of Paragon.");
    end
  end
end

function Parangon.onKillCreature(event, player, creature)
  local pLevel = player:GetLevel();
  local cLevel = creature:GetLevel();
  local pAcc = player:GetAccountId();

  if ((pLevel >= Config.minLevel) and (player:IsInGroup() == true)) then
    local group = player:GetGroup()

    for _, player in pairs(group:GetMembers()) do
      local pLevel = player:GetLevel()

      if ((pLevel - cLevel) == 10 or ((cLevel - pLevel) == 10)) then
        local pAccid = player:GetAccountId()
        PlayerAccount[pAcc].exp = PlayerAccount[pAcc].exp + Config.pveKill;
      end
    end
  elseif ((pLevel >= Config.minLevel) and (player:IsInGroup() == false)) then
    if ((pLevel - cLevel) == 10 or ((cLevel - pLevel) == 10)) then
      PlayerAccount[pAcc].exp = PlayerAccount[pAcc].exp + Config.pveKill;
      Parangon.setLevelUp(event, player);
    end
  end
end
RegisterPlayerEvent(7, Parangon.onKillCreature);

function Parangon.onKillPlayer(event, player, victim)
  local pLevel = player:GetLevel();
  local vLevel = victim:GetLevel();
  local pAcc = player:GetAccountId();

  if ((pLevel >= Config.minLevel) and (player:IsInGroup() == true)) then
    local group = player:GetGroup();

    for _, player in pairs(group:GetMembers()) do
      local pLevel = player:GetLevel();
      if ((pLevel - vLevel) == 10 or ((vLevel - pLevel) == 10)) then
        local pAccid = player:GetAccountId();
        PlayerAccount[pAcc].exp = PlayerAccount[pAcc].exp + Config.pvpKill;
      end
    end
  elseif ((pLevel >= Config.minLevel) and (player:IsInGroup() == false)) then
    if ((pLevel - vLevel) == 10 or ((vLevel - pLevel) == 10)) then
      PlayerAccount[pAcc].exp = PlayerAccount[pAcc].exp + Config.pvpKill;
      Parangon.setLevelUp(event, player);
    end
  end
end
RegisterPlayerEvent(6, Parangon.onKillPlayer);
