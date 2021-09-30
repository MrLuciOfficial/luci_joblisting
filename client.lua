local PlayerData = {}
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function OtvoriMeniPoslova()
	local elements = {
		{ label = 'POST OP - POSTAR', value = 'postar'},
		{ label = 'ELEKTRO PRIVREDA - ELEKTRICAR', value = 'elektricar'},
		{ label = 'GRADSKA BAUSTELA - GRADJEVINAR', value = 'baustela'},
		{ label = 'SOCIJALNA POMOC - NEZAPOSLEN', value = 'nezaposlen'},
	}

	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'alati', {
		title    = 'BIRO ZA ZAPOSLJAVANJE',
		align    = 'top-left',
		elements = elements
	}, 
	function(data, menu)
		if data.current.value == 'nezaposlen' then
			TriggerServerEvent('luci_opstina:setajPosao', 'unemployed', 0)
		elseif data.current.value == 'elektricar' then
			TriggerServerEvent('luci_opstina:setajPosao', 'elektricar', 0)
		elseif data.current.value == 'postar' then
			TriggerServerEvent('luci_opstina:setajPosao', 'postar', 0)
		elseif data.current.value == 'baustela' then
			TriggerServerEvent('luci_opstina:setajPosao', 'gradjevinar', 0)
		end
	end,
	function(data, menu)
		menu.close()
	end)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), vector3(-550.3, -192.75, 37.23), true)
		local letSleep = true
		if distance < 3.0 then
			DrawMarker(6, -550.3, -192.75, 37.23, 0.0, 0.0, 0.0, 270.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 200, false, true, 2, true, false, false, false)
		    letSleep = false
		end
		
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),  -550.3, -192.75, 37.23, true) < 1 then
			if (IsControlJustReleased(1, 51)) then
				OtvoriMeniPoslova()
			end
		end
		if letSleep then
			Citizen.Wait(1000)
		end
	end
end)

Citizen.CreateThread(function()
	for i=1, #Config.Zones, 1 do
		local blip = AddBlipForCoord(Config.Zones[i])

		SetBlipSprite (blip, 475)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 0.7)
		SetBlipColour (blip, 37)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Gradska Kuca - LS")
		EndTextCommandSetBlipName(blip)
	end
end)
