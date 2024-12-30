# Roblox Discord Webhooks

## Usage:
- Copy the contents of `DiscordWebhooks` and paste it into a new ModuleScript in Roblox Studio. I recommend putting it in ServerStorage or ServerScriptService.
- Create a new ModuleScript under the first one you made, and name it "Config". Paste the contents of `DiscordWebhooks.Config` into it. *If you want to see logs from Webhook instances in the console, set `Debug` to true
- Done!

## Example Script:
```lua
local webhookService = require(script.Parent.DiscordWebhook)
local webhook = webhookService.Webhook.new("YOUR WEBHOOK URL HERE")
webhook:SendEmbed("Roblox Embed", "This embed message is from a Roblox game", "https://roblox.com", webhookService.Utils.rgbToColor(200, 0, 200), {
	{
		["name"] = "Field 1",
		["value"] = "This is a field.",
		["inline"] = false
	},
	{
		["name"] = "Field 2",
		["value"] = "This is another field.",
		["inline"] = false
	},
	{
		["name"] = "Field 3",
		["value"] = "This is the third field.",
		["inline"] = false
	}
})

webhook:SendMessage("Hello", "Life is Roblox")
```

# Documentation

## module.Webhook
### Functions: 
- .new(url: string) *The constructor, makes a new Webhook instance with the provided URL if it is valid*
- :SendMessage(message: string, username: string) *When called on an initialized Webhook instance, sends `message` to Discord with the name `username` (Username defaults to the webhook's original name if not set)*
- :Delete() *PERMANENTLY deletes the webhook*
- :SendEmbed(title: string, description: string, url: string, color: number, fields: {}) *Sends an embed message to Discord. Note: To get the color you want, you can use module.Utils.rgbToColor(r, g, b)*
- :Valid() *Returns whether the webhook can be accessed as a boolean*
### Properties:
- .initialized *Whether the check succeeded when initializing. If this is false, SendMessage, Delete, and SendEmbed will not work.* (Boolean)
- .url *The webhook's URL* (String)
- .webhookName *The name that will be used when sending a message. Defaults to the webhook's regular name from Discord when initializing.*

## module.Utils
### Functions:
- rgbToColor(red: number, green: number, blue: number) *Turns a color from RGB into the format which can be used in Webhook:SendEmbed()*
- CheckWebhook(url) *Returns the same thing as initializing a Webhook with the url and calling Valid() on it*
