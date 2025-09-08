-- Gerador de Keys Manual para Roblox Cheat
-- Use este script para gerar keys manualmente

local HttpService = game:GetService("HttpService")

-- Configurações
local WEBHOOK_URL = "https://discord.com/api/webhooks/1414742310620762233/VPo57SBDHF1NhGZwzsKf53RuJxPT7RCG9zdHVC9ShPIVVzfAMtjMGiHQPYU_sxQ5BLXL"

-- Função para gerar key única
local function generateKey(userType, days, customCode)
    local chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    local code = customCode or ""
    
    -- Se não foi fornecido código personalizado, gerar um aleatório
    if code == "" then
        for i = 1, 8 do
            local randomIndex = math.random(1, #chars)
            code = code .. chars:sub(randomIndex, randomIndex)
        end
    end
    
    -- Formato: TIPO_CODIGO_DIASD
    local key = string.format("%s_%s_%dD", userType:upper(), code:upper(), days)
    return key
end

-- Função para enviar key gerada para Discord
local function sendGeneratedKey(keyData)
    local colorMap = {
        CLIENT = 3447003,  -- Azul
        ADMIN = 15158332,  -- Laranja  
        OWNER = 10038562   -- Roxo
    }
    
    local webhookData = {
        embeds = {{
            title = "🎉 Key Gerada com Sucesso!",
            description = "**Nova key foi criada:**\n\n```" .. keyData.key .. "```\n\n**Copie e envie para o usuário**",
            color = colorMap[keyData.userType] or 3447003,
            fields = {
                {name = "🔑 Key", value = "`" .. keyData.key .. "`", inline = false},
                {name = "👑 Tipo", value = keyData.userType, inline = true},
                {name = "⏰ Duração", value = keyData.days .. " dias", inline = true},
                {name = "📅 Expira em", value = os.date("%d/%m/%Y às %H:%M:%S", keyData.expiration), inline = true},
                {name = "🎯 Permissões", value = table.concat(keyData.permissions, ", "), inline = false}
            },
            timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
        }}
    }
    
    local success, result = pcall(function()
        return HttpService:PostAsync(WEBHOOK_URL, HttpService:JSONEncode(webhookData), Enum.HttpContentType.ApplicationJson)
    end)
    
    return success
end

-- Função principal para gerar e registrar key
local function createKey(userType, days, customCode, sendToDiscord)
    userType = userType or "CLIENT"
    days = days or 7
    sendToDiscord = sendToDiscord ~= false -- Default true
    
    local key = generateKey(userType, days, customCode)
    local expiration = os.time() + (days * 24 * 60 * 60)
    
    local permissions = {}
    if userType == "OWNER" then
        permissions = {"all_features", "admin_panel", "user_management"}
    elseif userType == "ADMIN" then
        permissions = {"basic_features", "admin_features", "bypass_limits"}
    else
        permissions = {"basic_features"}
    end
    
    local keyData = {
        key = key,
        userType = userType,
        days = days,
        expiration = expiration,
        permissions = permissions
    }
    
    -- Enviar para Discord se solicitado
    if sendToDiscord then
        sendGeneratedKey(keyData)
    end
    
    -- Imprimir informações da key
    print("=== KEY GERADA ===")
    print("Key: " .. key)
    print("Tipo: " .. userType)
    print("Duração: " .. days .. " dias")
    print("Expira em: " .. os.date("%d/%m/%Y às %H:%M:%S", expiration))
    print("Permissões: " .. table.concat(permissions, ", "))
    print("==================")
    
    return keyData
end

-- Exemplos de uso:
print("=== GERADOR DE KEYS ROBLOX CHEAT ===")
print("Use as funções abaixo para gerar keys:")
print("")
print("-- Gerar key CLIENT de 7 dias:")
print("createKey('CLIENT', 7)")
print("")
print("-- Gerar key ADMIN de 30 dias com código personalizado:")
print("createKey('ADMIN', 30, 'PREMIUM123')")
print("")
print("-- Gerar key OWNER de 365 dias:")
print("createKey('OWNER', 365)")
print("")

-- Gerar algumas keys de exemplo
createKey("CLIENT", 7, "DEMO123")
createKey("ADMIN", 30, "PREMIUM456") 
createKey("OWNER", 365, "ULTIMATE789")

-- Retornar função para uso externo
return {
    generateKey = generateKey,
    createKey = createKey,
    sendGeneratedKey = sendGeneratedKey
}
