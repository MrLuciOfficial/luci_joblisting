ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('luci_opstina:setajPosao')
AddEventHandler('luci_opstina:setajPosao', function(posao, pozicija)
  	  local igrac = ESX.GetPlayerFromId(source)
  	  igrac.setJob(posao, pozicija)
	  TriggerClientEvent("dopeNotify:SendNotification", source, {text = 'CESTITAM DOBILI STE NOVI POSAO! '.. posao ..'', type = "info", timeout = 5000, layout = "bottomRight"})
	  LogoviZaposljavanje("``📝`` ZAPOSLJAVANJE BIRO", "**IGRAC:** ``" .. GetPlayerName(source) .. "``\n**POSAO:** ``" .. posao .."``", 5793266)
end)

function LogoviZaposljavanje(name, message, color)
    local connect = {
          {
              ["color"] = color,
              ["title"] = "**".. name .."**",
              ["description"] = message,
              ["footer"] = {
                  ["text"] = "LOGOVI",
              },
          }
      }
    PerformHttpRequest("".. Config.LogoviZaposljavanje .."", function(err, text, headers) end, 'POST', json.encode({username = "LOGOVI", embeds = connect, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
end 