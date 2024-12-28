local module = {}
module.__index = module
local config = require(script.Config)
local HttpService = game:GetService("HttpService")

local function printIfDebug(thing)
	if config.Debug then
		print(thing)
	end
end

function module.new(webhookUrl)
	local response = HttpService:RequestAsync({Url = webhookUrl, Method = "GET"})
	printIfDebug("Webhook Get Response: "..response.Body)
	local decodedResponse = HttpService:JSONDecode(response.Body)
	if response.Success then
		printIfDebug("Webhook valid")
		local self = setmetatable({}, module)
		self.initialized = true
		self.webhookName = decodedResponse["name"]
		self.url = webhookUrl
		return self
	else
		printIfDebug("Request was not successful. Webhook likely invalid.")
		return nil
	end
end

function module.rgbToColor(red, green, blue)
	return bit32.lshift(red, 16) + bit32.lshift(green, 8) + blue
end

print(module.rgbToColor(255, 20, 20))

function module:SendMessage(message: string, username: string)
	if not self.initialized then return end
	assert(#message <= 2000, "Message too long!")
	self.webhookName = username or self.webhookName
	local requestTable = {
		["content"] = message,
		["username"] = self.webhookName
	}
	local response = HttpService:PostAsync(self.url, HttpService:JSONEncode(requestTable), Enum.HttpContentType.ApplicationJson)
end

function module:SendEmbed(title: string, description: string, url: string, color: number, fields: {})
	if not self.initialized then return end
	local embedTable = {["embeds"] = {{
		["title"] = title or "Roblox",
		["description"] = description,
		["url"] = url or "https://www.roblox.com/games/79387422884028",
		["color"] = color or 16716820,
		["fields"] = fields
		}}
	}
	local encodedBody = HttpService:JSONEncode(embedTable)
	printIfDebug(encodedBody)
	local response = HttpService:RequestAsync({Url = self.url, Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = encodedBody})
	if response.Success then
		printIfDebug("Successfully sent embed!")
	else
		printIfDebug("Unsuccessful embed response: ")
		printIfDebug(response)
		error("Embed failed to send to Discord!")
	end
end



return module
