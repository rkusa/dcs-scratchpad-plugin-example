local logScope = "[Scratchpad-Plugin-Example]"

local function loadScratchpadPluginExample()
    if not _G.scratchpad then
        log.write(logScope, log.ERROR, "can not be loaded - is the Scratchpad installed?")
    end

    local window = nil

    local function createWindow()
        if window ~= nil then
            return
        end

        window = DialogLoader.spawnDialogFromFile(
            lfs.writedir() .. "Scripts\\Scratchpad\\PluginExampleWindow.dlg",
            cdata
        )

        window.FButton:addMouseDownCallback(function(self)
            local textarea = _G.scratchpad.getTextarea()
            -- TODO: implement your logic to add to the textarea
        end)
    end

    -- Fired when opened, but also with updated boudns when moved or resized.
    _G.scratchpad.onOpen(function(x, y, w, h)
        if not window then
            local status, err = pcall(createWindow)
            if not status then
                log.write(logScope, log.ERROR, " Error creating window: " .. tostring(err))
            end
        end

        -- position button right of the Scratchpad window
        window:setBounds(x + w + 4, y, 30, 30)
        window:setVisible(true)
    end)


    _G.scratchpad.onClose(function()
        if not window then
            return
        end

        window:setVisible(false)
    end)

    log.write(logScope, log.INFO, "Loaded.")
end

local status, err = pcall(loadScratchpadPluginExample)
if not status then
    log.write(logScope, log.ERROR, "Load Error: " .. tostring(err))
end
