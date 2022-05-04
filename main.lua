-- main.lua v1.0 Rewrite
-- Made by Misk#4044
-- Love <3

-- Starting variables
local scriptexecuted
local HttpService = game:GetService('HttpService')
local PathFindingService = game:GetService("PathfindingService")
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
    Music = 'music.png';
    Video = 'video.png';
    Smile = 'smile.png'
  };
  SoundsDir = 'Sounds/';
  Sounds = {
    Notification = 'hollow-582.mp3'
  }
}
if (not isfolder) or (not getsynasset) then
  OrionLib:MakeNotification({
    Name = "RHub | Error",
    Content = 'Missing functions',
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

local Window, Main, GAMEDETECTEDRHUB, Action

local function detectGame()
  if not GAMEDETECTEDRHUB then
    GAMEDETECTEDRHUB = true
  else
    return
  end
  if game:GetService("HttpService"):JSONDecode(game:HttpGet('https://api.roblox.com/universes/get-universe-containing-place?placeid='..game.PlaceId))['UniverseId'] == 1720936166 then
    notify('Game found: ASTD!')
    local newscriptexecuted
    local PathText = Main:AddParagraph('PathFindingService', '...')
    Main:AddButton({
      Name = "TP to story mode",
      Callback = function()
        local Controller = require(game.Players.LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule")):GetControls()
        local ToTouch = Vector3.new(-952.15, 60.958, -619.949)
        local Humanoid = game:GetService("Players").LocalPlayer.Character:WaitForChild('Humanoid')
        local HumanoidRootPart = game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart")
        local path = PathFindingService:CreatePath()
        path:ComputeAsync(HumanoidRootPart.Position, ToTouch)
        local waypoints = path:GetWaypoints()
        if #waypoints == 0 then
          error("PathFindingService returned an error!")
          return
        end
        Controller:Disable()
        local Speed = coroutine.create(function()
          Humanoid.WalkSpeed = 35
          while game:GetService("RunService").Stepped:Wait() do
            Humanoid.WalkSpeed = 35
          end
        end)
        coroutine.resume(Speed)
        Action = coroutine.create(function()
          for key, waypoint in ipairs(waypoints) do
            Humanoid:MoveTo(waypoint.Position)
            Humanoid.MoveToFinished:Wait()
            PathText:Set(math.floor(100/#waypoints*key)..'%.')
          end
        end)
        coroutine.close(Speed)
        notify('Done!')
        wait(1)
        Speed = nil
        Controller:Enable()
      end    
    })
    Main:AddButton({
      Name = 'Give Character Controller';
      Callback = function()
        local Controller = require(game.Players.LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule")):GetControls()
        notify('Done!')
        Controller:Enable()
      end
    })
    Main:AddToggle({
      Name = 'Auto Upgrade Every Unit (WIP)';
      Color = Color3.fromRGB(166,0,0);
      Default = false;
      Callback = function(Value)
        if newscriptexecuted == true then
          error('WIP')
        end
      end
    })
    Main:AddToggle({
      Name = 'Auto Next Wave';
      Color = Color3.fromRGB(166,0,0);
      Default = false;
      Callback = function(Value)
        if scriptexecuted == true then
          if Value == true then
            getgenv().AUTONEXTWAVECOROUTINE = coroutine.create(function()
              while wait(.5) do
                local args = {
                  [1] = "VoteWaveConfirm"
                }
                game:GetService("ReplicatedStorage").Remotes.Input:FireServer(unpack(args))
              end
            end)
            coroutine.resume(getgenv().AUTONEXTWAVECOROUTINE)
          else
            coroutine.close(getgenv().AUTONEXTWAVECOROUTINE)
          end
        end
      end
    })
    newscriptexecuted = true
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
local Window = OrionLib:MakeWindow({Name = "RHub | General", HidePremium = false, SaveConfig = true, ConfigFolder = SettingsRHub.FolderName})
-- Main
Main = Window:MakeTab({
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
LocalPlayer:AddLabel('General')
LocalPlayer:AddButton({
  Name = "Detect game",
  Callback = function()
    detectGame()
  end  
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
LocalPlayer:AddButton({
  Name = "Simple Remote Spy",
  Callback = function()
    notify('Executed!')
    loadstring(game:HttpGet("https://raw.githubusercontent.com/exxtremestuffs/SimpleSpySource/master/SimpleSpy.lua"))()
  end  
})
LocalPlayer:AddButton({
  Name = "Copy Simple Remote Spy Loadstring",
  Callback = function()
    notify('Copied!')
    setclipboard([[loadstring(game:HttpGet("https://raw.githubusercontent.com/exxtremestuffs/SimpleSpySource/master/SimpleSpy.lua"))()]])
  end  
})
LocalPlayer:AddParagraph('Camera Manager', [[The Camera object defines a view of the 3D game world.]])
local FovSlider = LocalPlayer:AddSlider({
  Name = "Fov",
  Min = 1,
  Max = 120,
  Default = game:GetService("Workspace").CurrentCamera.FieldOfView,
  Color = Color3.fromRGB(160,0,0),
  Increment = 1,
  ValueName = "",
  Callback = function(Value)
    game:GetService("Workspace").CurrentCamera.FieldOfView = Value
  end    
})
if not getgenv().oldfov then
  getgenv().oldfov = game:GetService("Workspace").CurrentCamera.FieldOfView
end
LocalPlayer:AddButton({
  Name = "Reset Fov",
  Callback = function()
    game:GetService("Workspace").CurrentCamera.FieldOfView = getgenv().oldfov
    FovSlider:Set(getgenv().oldfov)
    notcustom('Fov set to '..(math.floor(getgenv().oldfov*10)/10)..'.', 'Camera Manager', SettingsRHub.Icons.Video, 3)
  end  
})
LocalPlayer:AddToggle({
  Name = "Shiftlock",
  Default = game:GetService("Players").LocalPlayer.DevEnableMouseLock,
  Color = Color3.fromRGB(166,0,0),
  Callback = function(Value)
    game:GetService("Players").LocalPlayer.DevEnableMouseLock = Value
    if scriptexecuted == true and Value == true then
      notcustom('Shiftlock enabled.', 'Camera Manager', SettingsRHub.Icons.Video, 3)
    elseif scriptexecuted == true then
      notcustom('Shiftlock disabled.', 'Camera Manager', SettingsRHub.Icons.Video, 3)
    end
  end
})
LocalPlayer:AddParagraph('WalkSpeed Manager', [[WalkSpeed is a property that describes how quickly this Humanoid is able to walk, in studs per second.]])
LocalPlayer:AddTextbox({
  Name = "WalkSpeed",
  Default = tostring(game:GetService("Players").LocalPlayer.Character:WaitForChild('Humanoid').WalkSpeed),
  TextDisappear = false,
  Callback = function(Value)
    if tonumber(Value) then
      game:GetService("Players").LocalPlayer.Character:WaitForChild('Humanoid').WalkSpeed = Value
      notcustom('Walkspeed set to '..string.gsub(Value, ' ', '')..'.', 'WalkSpeed Manager', SettingsRHub.Icons.Settings)
    else
      error(Value..' is bad value.')
    end
  end	  
})
if not getgenv().oldwalkspeed then
  getgenv().oldwalkspeed = game:GetService("Players").LocalPlayer.Character:WaitForChild('Humanoid').WalkSpeed
end
LocalPlayer:AddButton({
  Name = "Reset WalkSpeed",
  Callback = function()
    notcustom('Walkspeed set to '..string.gsub(getgenv().oldwalkspeed, ' ', '')..'.', 'WalkSpeed Manager', SettingsRHub.Icons.Settings)
    game:GetService("Players").LocalPlayer.Character:WaitForChild('Humanoid').WalkSpeed = getgenv().oldwalkspeed
  end    
})
LocalPlayer:AddParagraph('Character Manager', [[The Character property contains a reference to a Model containing a Humanoid, body parts, scripts and other objects required for simulating the player’s avatar in-game.]])
LocalPlayer:AddButton({
  Name = "Refresh",
  Callback = function()
    local oldcframe = game:GetService("Players").LocalPlayer.Character:WaitForChild('HumanoidRootPart').CFrame
    notcustom('Your character is being refreshed.', 'Character Manager', SettingsRHub.Icons.LocalPlayer, 3)
    game:GetService("Players").LocalPlayer.Character:WaitForChild('Humanoid').Health = 0
    game:GetService("Players").LocalPlayer.CharacterAppearanceLoaded:Wait()
    for i = 1,3 do
      game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = oldcframe
      wait(.3)
      if game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame == oldcframe then
        break
      end
    end
  end
})
-- Music
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
    if tonumber((string.gsub(Value, ':', ''))) ~= nil then
      getgenv().MusicRHUBInstance.TimePosition = tonumber((string.gsub(Value, ':', '')))
      notcustom("Music's is now set to: "..string.gsub(Value, ' ', '')..'.', 'Music Manager', SettingsRHub.Icons.Music, 3)
    else
      error(Value..' is bad value.')
    end
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
local Funni = Window:MakeTab({
  Name = "Funni",
  Icon = SettingsRHub.Icons.Smile,
  PremiumOnly = false
})
Funni:AddButton({
  Name = "Friend A fucking nigger",
  Callback = function()
    game:GetService("StarterGui"):SetCore('SendNotification', {
      Title = 'New Friend';
      Text = 'A fucking Nigger';
      Icon = 'rbxassetid://677844346'
    })
  end  
})
Funni:AddButton({
  Name = "fucking die",
  Callback = function()
    game:Shutdown()
  end  
})
-- Settings
local Settings = Window:MakeTab({
  Name = "Settings",
  Icon = SettingsRHub.Icons.Settings,
  PremiumOnly = false
})
Settings:AddLabel('Settings')
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