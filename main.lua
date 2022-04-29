local alert, notify, notcustom, OrionLib, error
local succ, err = pcall(function()
  -- main.lua v1.0 Rewrite
  -- Made by Misk#4044
  -- Love <3

  -- Starting variables
  OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
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
      Notification = 'bell.png';
      Error = 'alert-octagon.png';
      Settings = 'settings.png'
    };
    SoundsDir = 'Sounds/';
    Sounds = {
      Notification = 'hollow-582.mp3'
    }
  }

  if (not isfolder) then
    OrionLib:MakeNotification({
      Name = "RHub | Error",
      Content = 'Missing functions, find a better executor you retard.\nMissing Functions:\nFilesystem Functions',
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
    local sound = Instance.new('Sound', game:GetService('SoundService'))
    sound.SoundId = SettingsRHub.Sounds.Notification
    sound.Volume = .5
    sound.PlayOnRemove = true
    sound:Destroy()
    OrionLib:MakeNotification({
      Name = "RHub | Alert",
      Content = text,
      Image = SettingsRHub.Icons.Alert,
      Time = 4
    })
  end
  function error(text)
    local sound = Instance.new('Sound', game:GetService('SoundService'))
    sound.SoundId = SettingsRHub.Sounds.Notification
    sound.Volume = .5
    sound.PlayOnRemove = true
    sound:Destroy()
    OrionLib:MakeNotification({
      Name = "RHub | Error",
      Content = text,
      Image = SettingsRHub.Icons.Error,
      Time = 5
    })
  end
  function notify(text)
    local sound = Instance.new('Sound', game:GetService('SoundService'))
    sound.SoundId = SettingsRHub.Sounds.Notification
    sound.Volume = .5
    sound.PlayOnRemove = true
    sound:Destroy()
    OrionLib:MakeNotification({
      Name = "RHub | Notification",
      Content = text,
      Image = SettingsRHub.Icons.Notification,
      Time = 3
    })
  end
  function notcustom(text, additional, image, time)
    local sound = Instance.new('Sound', game:GetService('SoundService'))
    sound.SoundId = SettingsRHub.Sounds.Notification
    sound.Volume = .5
    sound.PlayOnRemove = true
    sound:Destroy()
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
  local function detectGame()
    if game.PlaceId == 8425637426 then
      alert('Script being developed for '.. game.PlaceId..'.')
    else
      notify('Game not found.')
    end
  end

  if not isfolder(SettingsRHub.FolderName..'\\Sounds') then makefolder(SettingsRHub.FolderName..'\\Sounds') end
  for key, value in pairs(SettingsRHub.Sounds) do

    Key = function()
      if isfile(SettingsRHub.FolderName..'\\Sounds\\'..value) then
        
        local code = game:HttpGet(SettingsRHub.Git..SettingsRHub.SoundsDir..value)
        delfile(SettingsRHub.FolderName..'\\Sounds\\'..value, code)
        writefile(SettingsRHub.FolderName..'\\Sounds\\'..value, code)

        return getsynasset(SettingsRHub.FolderName..'\\Sounds\\'..value)
    
      else
        
        local code = game:HttpGet(SettingsRHub.Git..SettingsRHub.SoundsDir..value)
        writefile(SettingsRHub.FolderName..'\\Sounds\\'..value, code)

        return getsynasset(SettingsRHub.FolderName..'\\Sounds\\'..value)
    
      end
    end
    SettingsRHub.Sounds[key] = Key()

  end

  notcustom('Done downloading.', 'UI Elements', SettingsRHub.Icons.Notification)

  if (not getsynasset) then
    local textfile = 'Missing functions:'
    if not getsynasset then
      textfile = textfile..'\ngetsynasset'
    end
    OrionLib:MakeNotification({
      Name = "RHub | Alert",
      Content = textfile,
      Image = SettingsRHub.Icons.Alert,
      Time = 4
    })
    return
  end

  local Window = OrionLib:MakeWindow({Name = "RHub | General", HidePremium = false, SaveConfig = true, ConfigFolder = SettingsRHub.FolderName})
  -- Main
  local Main = Window:MakeTab({
    Name = "Main",
    Icon = SettingsRHub.Icons.Home,
    PremiumOnly = false
  })
  Main:AddButton({
    Name = "Detect game",
    Callback = function()
      detectGame()
    end  
  })
  Main:AddButton({
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
    Name = "Testing | PO",
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
    Name = "Error",
    Default = "Gay people",
    TextDisappear = true,
    Callback = function(Value)
      error(Value)
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

  -- Settings
  local Settings = Window:MakeTab({
    Name = "Settings",
    Icon = SettingsRHub.Icons.Settings,
    PremiumOnly = false
  })
  Settings:AddToggle({
    Name = "Auto Detect Game",
    Default = false,
    Save = true,
    Flag = 'AutoDetectGame';
    Callback = function(Value)
      if Value == true then
        detectGame()
      end
    end
  })
  if OrionLib.Flags['AutoDetectGame'].Value == true then
    detectGame()
  end
  local delete
  Settings:AddButton({
    Name = "Erase Data",
    Default = false,
    Callback = function()
      alert('Your data is being erased... you have 5 seconds in order to leave and cancel this action.')
      delete = true
    end
  })
  coroutine.resume(coroutine.create(function()
    repeat
      game:GetService("RunService").Stepped:Wait()
    until delete == true
    wait(5)
    for key, value in pairs(listfiles(SettingsRHub.FolderName)) do
      if isfolder(value) then
        delfolder(value)
      elseif isfile(value) then
        delfile(value)
      end
    end
    alert('Done.')
    wait(1)
    loadstring(game:HttpGet("https://raw.githubusercontent.com/MiskWasTaken/rhub/main/main.lua"))()
  end))

  -- Credits
  local Credits = Window:MakeTab({
    Name = "Credits",
    Icon = SettingsRHub.Icons.Credits,
    PremiumOnly = false
  })
  Credits:AddParagraph("Misk#4044", "Scripter And Owner")
  Credits:AddParagraph("feathericons.com", "For the icons")
  Credits:AddParagraph("shlex#0001", "UI Lib")

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

end)
if not succ then
  OrionLib:MakeNotification({
      Name = "RHub | Error",
      Content = err,
      Image = '',
      Time = 4
  })
  warn(err)
end