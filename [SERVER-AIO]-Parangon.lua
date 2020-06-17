local AIO = AIO or require("AIO")

Parangon = AIO.AddHandlers("AIOExample", {});

--[[ ///// GET PLAYER \\\\\ ]]--

  function Parangon.getPlayer(event, player)

  end
  RegisterPlayerEvent(3, Parangon.getPlayer);

  function Parangon.getPlayers(event)

  end
  RegisterServerEvent();

--[[ ///// SET PLAYER \\\\\ ]]--
  function Parangon.setPlayer(event, player)

  end
  RegisterPlayerEvent(4, Parangon.setPlayer);

  function Parangon.setPlayers(event)
    for _, player in pairs(GetPlayersInWorld()) do
      Parangon.setPlayer(event, player);
    end
  end
  RegisterServerEvent();

--[[ ]]--
