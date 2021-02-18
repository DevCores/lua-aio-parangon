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

local aio = aio or require("aio")

local parangon = {

    config = {
        db_name = 'ac_eluna',

        pointsPerLevel = 1,
        minLevel = 70,

        expMulti = 1,
        expMax = 500,

        pveKill = 100,
        pvpKill = 10,
    },

    spells = {
        [7464] = 'Strength',
        [7471] = 'Agility',
        [7477] = 'Stamina',
        [7468] = 'Intellect',
    },

    parangon_aio = aio.AddHandlers("AIO_Parangon", {})
}

parangon.account = {}

function parangon.onServerStart(event)
    CharDBExecute('CREATE DATABASE IF NOT EXISTS `'..parangon.config.db_name..';')
    CharDBExecute('CREATE TABLE IF NOT EXISTS `'..parangon.config.db_name..'`.`account_parangon` (`account_id` INT(11) NOT NULL, `level` INT(11) DEFAULT 1, `exp` INT(11) DEFAULT 0, PRIMARY KEY (`account_id`) );');
    CharDBExecute('CREATE TABLE IF NOT EXISTS `'..parangon.config.db_name..'`.`characters_parangon` (`account_id` INT(11) NOT NULL, `guid` INT(11) NOT NULL, `strength` INT(11) DEFAULT 0, `agility` INT(11) DEFAULT 0, `stamina` INT(11) DEFAULT 0, `intellect` INT(11) DEFAULT 0, PRIMARY KEY (`account_id`, `guid`));');
    io.write('Eluna :: Parangon System start')
end
RegisterServerEvent(14, parangon.onServerStart)

function parangon.setStats(player)
    local pLevel = player:GetLevel()

    if pLevel >= parangon.config.minLevel then
        for spell, _ in pairs(parangon.spells) do
            player:RemoveAura(spell)
            player:AddAura(spell, player)
            player:GetAura(spell):SetStackAmount(player:GetData('parangon_stats_'..spell))
        end
    end
end

function parangon.setStatsIncrease(player, stat, value)
    local pCombat = player:IsInCombat()
    if (not pCombat) then
        local pLevel = player:GetLevel()

        if (pLevel >= parangon.config.minLevel) then
            if ((player:GetData('parangon_points') - value) > 0) then

                player:SetData('parangon_stats_'..stat, (player:GetData('parangon_stats_'..stat) + value))
                player:SetData('parangon_points', (player:GetData('parangon_points') - value))

                parangon.setAddonInfo(player)
            else
                player:SendNotification('You have no more points to award.');
            end
        else
            player:SendNotification('You don\'t have the level required to do that.');
        end
    else
        player:SendNotification('You can\'t do this in combat.');
    end
end

function parangon.onLogin(event, player)

end