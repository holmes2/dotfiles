-- Reload files when change happens --
-- Start
function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end
myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded\n Press ALT + H for help.")
-- END

local function focusLastFocused()
    local wf = hs.window.filter
    local lastFocused = wf.defaultCurrentSpace:getWindows(wf.sortByFocusedLast)
    if #lastFocused > 0 then lastFocused[1]:focus() end
end

local chooser = hs.chooser.new(function(choice)
    if not choice then focusLastFocused(); return end
    hs.pasteboard.setContents(choice["value"])
        focusLastFocused()
    hs.eventtap.keyStrokes(hs.pasteboard.getContents())
end)


chooser:choices({
  {
    ["text"] = "Example\n",
    ["subText"] = "Copy Example Password",
    ["value"] = "ExampleValue",
  },
})

chooser:searchSubText(true)
chooser:rows(5)
chooser:bgDark(true)
hs.hotkey.bind({"cmd", "alt","ctrl"}, "space", function() chooser:show() end)

-- FOCUS ITERM
-- START
hs.hotkey.bind({"alt"}, "A",function()
  if hs.application.launchOrFocus('Alacritty') then
  else
    hs.alert.show("No such application")
  end
end)
-- END


-- FOCUS FIREFOX
-- START
hs.hotkey.bind({"alt"}, "F",function()
  if hs.application.launchOrFocus('Firefox') then
  else
    hs.alert.show("No such application")
  end
end)
-- END

-- FOCUS TEAMS
-- START
hs.hotkey.bind({"alt"}, "T",function()
  if hs.application.launchOrFocus('Microsoft Teams') then
  else
    hs.alert.show("No such application")
  end
end)
-- END

-- FOCUS OUTLOOK
-- START
hs.hotkey.bind({"alt"}, "O",function()
  if hs.application.launchOrFocus('Microsoft Outlook') then
  else
    hs.alert.show("No such application")
  end
end)
-- END

-- FOCUS IntelliJ
-- START
hs.hotkey.bind({"alt"}, "J",function()
  if hs.application.launchOrFocus('IntelliJ Idea CE') then
  else
    hs.alert.show("No such application")
  end
end)
-- END

-- FOCUS Google Music
-- START
hs.hotkey.bind({"alt"}, "M",function()
  if hs.application.launchOrFocus('Google Play Music Desktop Player') then
  else
    hs.alert.show("No such application")
  end
end)
-- END

-- FOCUS Google Chrome
-- START
hs.hotkey.bind({"alt"}, "C",function()
  if hs.application.launchOrFocus('Google Chrome') then
  else
    hs.alert.show("No such application")
  end
end)
-- END


-- HELP Keyboard Shortcuts
-- START
hs.hotkey.bind({"alt"}, "H",function()
    hs.alert.show(" Keyboard Shortcuts \n\z
    ALT + F - Firefox\n\z
    ALT + T - Microsoft Teams \n\z
    ALT + A - Alacritty \n\z
    ALT + O - Microsoft Outlook\n\z
    ALT + J - IntelliJ Idea CE\n\z
    ALT + C - Google Chrome\n\z
    ALT + M - Google Music Desktop Player\n\z
    CMD + CTRL + OPTION + SPACE - CHOOSER")

end)
-- END


-- set up your instance(s)
expose = hs.expose.new(nil,{showThumbnails=false}) -- default windowfilter, no thumbnails
expose_app = hs.expose.new(nil,{onlyActiveApplication=true}) -- show windows for the current application
expose_space = hs.expose.new(nil,{includeOtherSpaces=false}) -- only windows in the current Mission Control Space
expose_browsers = hs.expose.new{'Firefox','Google Chrome'} -- specialized expose using a custom windowfilter
-- for your dozens of browser windows :)

-- then bind to a hotkey
