local alert, notify, notcustom, OrionLib, error
local succ, err = pcall(function()
  -- main.lua v1.0 Rewrite
  -- Made by Misk#4044
  -- Love <3

  -- Starting variables
  local scriptexecuted
  local HttpService = game:GetService('HttpService')
  OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
  local SettingsRHub = {
    FolderName = 'RHubFolderv1';
    SettingsFolderName = '\\GeneralSettings.lua';
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
      Settings = 'settings.png';
      Music = 'music.png'
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

  local DefaultPlayerSettings = {
    AutoDetectGame = false;
    MusicVolume = .5;
    ToggleButton = Enum.KeyCode.KeypadMinus.Name
  }

  if not isfile(SettingsRHub.FolderName..SettingsRHub.SettingsFolderName) then
    writefile(SettingsRHub.FolderName..SettingsRHub.SettingsFolderName, HttpService:JSONEncode(DefaultPlayerSettings))
  else
    DefaultPlayerSettings = HttpService:JSONDecode(readfile(SettingsRHub.FolderName..SettingsRHub.SettingsFolderName))
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
    if false then
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

  -- Main
  local Music = Window:MakeTab({
    Name = "Music",
    Icon = SettingsRHub.Icons.Music,
    PremiumOnly = false
  })
  if not isfolder(SettingsRHub.FolderName..'\\MusicFile') then
    makefolder(SettingsRHub.FolderName..'\\MusicFile')
  end
  if not getgenv().MusicRHUBInstance then
    getgenv().MusicRHUBInstance = Instance.new('Sound', game:GetService("SoundService"))
    getgenv().MusicRHUBInstance.Volume = DefaultPlayerSettings.MusicVolume
  end
  Music:AddParagraph('How to add custom music', "A folder in the script's settings has been created ("..SettingsRHub.FolderName..'/MusicFile/)')
  Music:AddButton({
    Name = "Load file",
    Callback = function()
      if #(listfiles(SettingsRHub.FolderName..'\\MusicFile')) == 1 then
        getgenv().MusicRHUBInstance.SoundId = getsynasset(listfiles(SettingsRHub.FolderName..'\\MusicFile')[1])
        local filename = listfiles(SettingsRHub.FolderName..'\\MusicFile')[1]
        filename = string.split(filename, [[\]])
        filename = filename[#filename]
        notcustom("Loaded file:\n"..filename..'.', 'Music Manager', SettingsRHub.Icons.Music, 3)
      else
        notcustom("Insert a file in the folder!", 'Music Manager', SettingsRHub.Icons.Music, 3)
      end
    end 
  })
  Music:AddSlider({
    Name = "Volume",
    Min = 0,
    Max = 500,
    Default = DefaultPlayerSettings.MusicVolume*100,
    Color = Color3.fromRGB(160, 0, 0),
    Increment = 1,
    ValueName = "",
    Callback = function(Value)
      getgenv().MusicRHUBInstance.Volume = Value/100
      DefaultPlayerSettings.MusicVolume = Value/100
      writefile(SettingsRHub.FolderName..SettingsRHub.SettingsFolderName, HttpService:JSONEncode(DefaultPlayerSettings))
    end    
  })
  local Time = Music:AddParagraph('Time', '0:00/0:00')
  coroutine.resume(coroutine.create(function()
    pcall(function()
      while game:GetService('RunService').Stepped:Wait() do
        local Cm = math.floor(getgenv().MusicRHUBInstance.TimePosition/100) or 0
        local Cs = math.floor(getgenv().MusicRHUBInstance.TimePosition-Cm*100) or 0
        if Cs < 10 then
            Cs = '0'..Cs
        end
        local Mm = math.floor(getgenv().MusicRHUBInstance.TimeLength/100) or 0
        local Ms = math.floor(getgenv().MusicRHUBInstance.TimeLength-Mm*100) or 0
        if Ms < 10 then
            Ms = '0'..Ms
        end
        Time:Set(Cm..':'..Cs..'/'..Mm..':'..Ms)
      end
    end)
  end))
  Music:AddTextbox({
    Name = "Set Time",
    Default = "0:00",
    TextDisappear = false,
    Callback = function(Value)
      getgenv().MusicRHUBInstance.TimePosition = tonumber((string.gsub(Value, ':', '')))
      notcustom("Music's is now set to: "..string.gsub(Value, ' ', '')..'.', 'Music Manager', SettingsRHub.Icons.Music, 3)
    end	  
  })
  Music:AddToggle({
    Name = "Looped",
    Default = getgenv().MusicRHUBInstance.Looped,
    Color = Color3.fromRGB(160, 0, 0),
    Callback = function(Value)
      getgenv().MusicRHUBInstance.Looped = Value
      if Value == true and scriptexecuted == true then
        notcustom("Music's is now looped.", 'Music Manager', SettingsRHub.Icons.Music, 3)
      elseif scriptexecuted == true then
        notcustom("Music's is not looped.", 'Music Manager', SettingsRHub.Icons.Music, 3)
      end
    end    
  })
  Music:AddButton({
    Name = "Play",
    Callback = function()
      getgenv().MusicRHUBInstance:Play()
      notcustom("Music's playing.", 'Music Manager', SettingsRHub.Icons.Music, 3)
    end 
  })
  Music:AddButton({
    Name = "Stop",
    Callback = function()
      getgenv().MusicRHUBInstance:Stop()
      notcustom("Music's stopped.", 'Music Manager', SettingsRHub.Icons.Music, 3)
    end 
  })
  Music:AddButton({
    Name = "Pause",
    Callback = function()
      getgenv().MusicRHUBInstance:Pause()
      notcustom("Music's paused.", 'Music Manager', SettingsRHub.Icons.Music, 3)
    end 
  })
  Music:AddButton({
    Name = "Resume",
    Callback = function()
      getgenv().MusicRHUBInstance:Resume()
      notcustom("Music's resumed.", 'Music Manager', SettingsRHub.Icons.Music, 3)
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
    Default = DefaultPlayerSettings.AutoDetectGame,
    Color = Color3.fromRGB(160, 0, 0);
    Callback = function(Value)
      if Value == true then
        detectGame()
      end
      DefaultPlayerSettings.AutoDetectGame = Value
      writefile(SettingsRHub.FolderName..SettingsRHub.SettingsFolderName, HttpService:JSONEncode(DefaultPlayerSettings))
    end
  })
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
    game:GetService("StarterGui"):SetCore('SendNotification', {
      Button1 = 'Ok';
      Duration = 4;
      Title = 'RHub | Alert';
      Text = 'Done.'
    })
    game:GetService("CoreGui"):FindFirstChild('Orion'):Destroy()
  end))
  local UI = game:GetService("CoreGui"):FindFirstChild("Orion")
  Settings:AddBind({
    Name = "Toggle Ui",
    Default = Enum.KeyCode[DefaultPlayerSettings.ToggleButton],
    Hold = false,
    Save = true,
    Flag = 'ToggleUI',
    Callback = function()
      if UI then
        UI.Enabled = not UI.Enabled
      end
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
  Credits:AddParagraph("shlex#0001", "UI Lib")

  -- Init
  OrionLib:Init()
  scriptexecuted = true

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