-- main.lua v1.0 Rewrite
-- Made by Misk#4044
-- Love <3

-- Starting variables
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local SettingsRHub = {
  FolderName = 'RHubFolderv1';
  Git = 'https://raw.githubusercontent.com/MiskWasTaken/rhub/main/';
  IconsDir = 'Icons/';
  Icons = {
    Home = 'list.png';
    Credits = 'info.png';
    LocalPlayer = 'user.png';
    Alert = 'alert-triangle.png';
    Download = 'download.png';
    Notification = 'bell.png'
  }
}
if (not isfolder) then
  OrionLib:MakeNotification({
    Name = "RHub | Error",
    Content = 'Missing functions. (MOST IMPORTANT FUNCTION)',
    Image = '',
    Time = 4
  })
  return
end

if not isfolder(SettingsRHub.FolderName..'\\Icons') then makefolder(SettingsRHub.FolderName..'\\Icons') end
for key, value in pairs(SettingsRHub.Icons) do

  Key = function()
    if isfile(SettingsRHub.FolderName..'\\Icons\\'..value) then

      local code = game:HttpGet(SettingsRHub.Git..SettingsRHub.IconsDir..value)
      delfile(SettingsRHub.FolderName..'\\Icons\\'..value, code)
      writefile(SettingsRHub.FolderName..'\\Icons\\'..value, code)

      return getsynasset(SettingsRHub.FolderName..'\\Icons\\'..value)
  
    else
      
      local code = game:HttpGet(SettingsRHub.Git..SettingsRHub.IconsDir..value)
      writefile(SettingsRHub.FolderName..'\\Icons\\'..value, code)

      return getsynasset(SettingsRHub.FolderName..'\\Icons\\'..value)
  
    end
  end
  SettingsRHub.Icons[key] = Key()

end

function alert(text)
  OrionLib:MakeNotification({
    Name = "RHub | Alert",
    Content = text,
    Image = SettingsRHub.Icons.Alert,
    Time = 4
  })
end
function notify(text)
  OrionLib:MakeNotification({
    Name = "RHub | Notification",
    Content = text,
    Image = SettingsRHub.Icons.Notification,
    Time = 3
  })
end
function notcustom(text, additional, image, time)
  local title = ("RHub | ".. additional) or ('RHub')
  local image = image or ''
  local time = time or 3
  OrionLib:MakeNotification({
    Name = title,
    Content = text,
    Image = image,
    Time = time
  })
end

notcustom('Done downloading.', 'UI Elements', SettingsRHub.Icons.Notification)

if (not getsynasset) then
  OrionLib:MakeNotification({
    Name = "RHub | Alert",
    Content = 'Missing functions.',
    Image = SettingsRHub.Icons.Alert,
    Time = 4
  })
  return
end

local Window = OrionLib:MakeWindow({Name = "RHub", HidePremium = false, SaveConfig = true, ConfigFolder = SettingsRHub.FolderName})
-- Main
local Main = Window:MakeTab({
	Name = "Main",
	Icon = SettingsRHub.Icons.Home,
	PremiumOnly = false
})

-- LocalPlayer
local LocalPlayer = Window:MakeTab({
	Name = "LocalPlayer",
	Icon = SettingsRHub.Icons.LocalPlayer,
	PremiumOnly = false
})
LocalPlayer:AddButton({
	Name = "Rejoin",
	Callback = function()
    alert('Rejoining...')
    local ts = game:GetService("TeleportService")
    local p = game:GetService("Players").LocalPlayer
    ts:Teleport(game.PlaceId, p)
  end  
})

-- Testing
local Testing = Window:MakeTab({
	Name = "Testing",
	Icon = SettingsRHub.Icons.Alert,
	PremiumOnly = true
})
Testing:AddTextbox({
	Name = "Alert Notification",
	Default = "YOUR GAY!!!!",
	TextDisappear = true,
	Callback = function(Value)
		alert(Value)
	end	  
})
Testing:AddTextbox({
	Name = "Custom Notification (Only Text)",
	Default = "Hello.",
	TextDisappear = true,
	Callback = function(Value)
		notcustom(Value, 'Made By User', SettingsRHub.Icons.LocalPlayer, 3)
	end	 
})
Testing:AddTextbox({
	Name = "Notification",
	Default = "Free Bobux",
	TextDisappear = true,
	Callback = function(Value)
		notify(Value)
	end	 
})


-- Credits
local Credits = Window:MakeTab({
	Name = "Credits",
	Icon = SettingsRHub.Icons.Credits,
	PremiumOnly = false
})
Credits:AddParagraph("Misk#4044", "Scripter And Owner")
Credits:AddParagraph("feathericons.com", "For the icons")

-- Init
OrionLib:Init()

--⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
--⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣶⣿⣿⣿⣿⣿⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
--⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣿⣿⣿⠿⠟⠛⠻⣿⠆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
--⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣆⣀⣀⠀⣿⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
--⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠻⣿⣿⣿⠅⠛⠋⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
--⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⢼⣿⣿⣿⣃⠠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
--⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣟⡿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
--⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣛⣛⣫⡄⠀⢸⣦⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
--⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣴⣾⡆⠸⣿⣿⣿⡷⠂⠨⣿⣿⣿⣿⣶⣦⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
--⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣤⣾⣿⣿⣿⣿⡇⢀⣿⡿⠋⠁⢀⡶⠪⣉⢸⣿⣿⣿⣿⣿⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
--⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣿⣿⣿⣿⣿⣿⣿⣿⡏⢸⣿⣷⣿⣿⣷⣦⡙⣿⣿⣿⣿⣿⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
--⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿⣿⣿⣿⣿⣿⣿⣿⣇⢸⣿⣿⣿⣿⣿⣷⣦⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
--⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
--⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀
--⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀
--⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠀⠀⠀⠀⠀⠀⠀⠀⠀
--⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀
--⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⣿⣵⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣯⡁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
