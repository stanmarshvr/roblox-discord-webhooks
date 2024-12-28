# Roblox Discord Webhooks

## Usage:
- Copy the contents of `DiscordWebhooks` and paste it into a new ModuleScript in Roblox Studio. I recommend putting it in ServerStorage or ServerScriptService.
- Create a new ModuleScript under the first one you made, and name it "Config". Paste the contents of `DiscordWebhooks.Config` into it.
- Done!

## Example Script:
```
local DiscordWebhooks = require(game.ServerScriptService.DiscordWebhooks)
local Webhook = DiscordWebhooks.new("https://discord.com/api/webhooks/yourwebhook")
Webhook:SendMessage("Hello from Roblox!", "Roblox Webhook")
```
