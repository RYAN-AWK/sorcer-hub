-- Improved Lua Script for Sorcer Hub

-- Better error handling with pcall wrappers
local function safe_execute(func, ...)
    local success, result = pcall(func, ...)
    if not success then
        print("Error: ", result)
    end
    return result
end

-- Character validation
local function is_valid_character(character)
    return type(character) == "string" and #character > 0
end

-- Auto-respawn on death
local function auto_respawn()
    -- Logic to respawn the character
    safe_execute(function()
        game.Players.LocalPlayer.Character:MoveTo(game.Workspace.SpawnLocation.Position)
    end)
end

game.Players.LocalPlayer.CharacterAdded:Connect(auto_respawn)

-- Configuration save/load functions
local function save_config(config)
    local success, message = pcall(function()
        -- Code to save configuration
    end)
    if not success then
        print("Failed to save config: ", message)
    end
end

local function load_config()
    local success, config = pcall(function()
        -- Code to load configuration
    end)
    if not success then
        print("Failed to load config: ", config)
    end
    return config
end

-- Improved purchase detection with synchronization
local function on_purchase(item)
    local success, message = pcall(function()
        -- Code to detect purchase and synchronize
    end)
    if not success then
        print("Purchase detection failed: ", message)
    end
end

-- Enhanced logging with emojis
local function log_with_emoji(message)
    print("🛠️ ", message)
end

-- Item validation
local function is_valid_item(item)
    return item and item:IsA("Item")
end

-- Tycoon detection with retries
local function detect_tycoon()
    for i = 1, 3 do
        local success, tycoon = pcall(function()
            -- Logic to detect tycoon
        end)
        if success and tycoon then
            return tycoon
        else
            log_with_emoji("Attempt " .. i .. " failed to detect tycoon.")
        end
    end
    return nil
end

-- Preserving original GUI and functionality
-- (Your original code and GUI setup goes here)

