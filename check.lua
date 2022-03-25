-- check.lua
-- If you ever deobfuscate this please don't share the script.

local url = ''

if isfolder('rhubfolder') == false then makefolder('rhubfolder') writefile('rhubfolder//userinfo.png', "return {'"..tostring(game:GetService("RbxAnalyticsService"):GetClientId()).."'}") 
else loadstring(game:HttpGet((url), true))()
end
