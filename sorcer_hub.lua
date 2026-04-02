-- sorcer_hub.lua

-- Better Error Handling

function safeExecute(func)
    local success, err = pcall(func)
    if not success then
        logError("Error: " .. err)
    end
end

-- Character Validation

function isValidCharacter(character)
    return character ~= nil and character.name ~= nil
end

-- Auto-Respawn System

function autoRespawn()
    if player.isDead then
        player:respawn()
        logInfo("Player respawned.")
    end
end

-- Configuration Saving/Loading

function saveConfiguration(config)
    -- Assuming we have a way to write to a file
    writeFile("config.json", json.encode(config))
end

function loadConfiguration()
    local configContent = readFile("config.json")
    return json.decode(configContent)
end

-- Improved Purchase Detection with Synchronization

function onPurchaseDetected(purchase)
    synchronizePurchase(purchase)
    logInfo("Purchase detected: " .. purchase.id)
end

-- Enhanced Logging

function logError(message)
    print("[ERROR] " .. message)
end

function logInfo(message)
    print("[INFO] " .. message)
end