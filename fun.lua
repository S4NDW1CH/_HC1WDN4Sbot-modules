--GLOBALS: onLoad, bot, string, math, table, io, os, choice, ball, roll

function onLoad()
	bot.registerCommand{name = "choice", func = choice, pattern = "(.+)"}
	bot.registerCommand{name = "8ball", func = ball, pattern = "(.+)"}
	bot.registerCommand{name = "8", func = ball, pattern = "(.+)"}
	bot.registerCommand{name = "roll", func = roll}
	bot.registerCommand{name = "r", func = roll}
end

local function getBallResponse()
	local file = io.open(".\\modules\\ballResponses.txt", "r")

	local responseList = {}
	for line in file:lines() do
		table.insert(responseList, line)
	end
	file:close()

	return responseList[math.random(#responseList)]
end

local function dice(amount, sides)

	local result = {}
	for d = 1, amount do
		table.insert(result, math.random(sides))
	end

	return table.concat(result, " + ")
end

function choice(chat, message, args)
	if not args then
		return message.Chat:SendMessage("I have no choice!")
	end

	local options = {} 
	for option in args:gmatch(",?([^%,%.\n\t%z]+),?") do
		table.insert(options, option)
	end

	--This construct here needed because sometimes choice
	--ends up being zero-length string and I have absolutely
	--no idea why. :(
	local choice
	repeat 
		choice = options[math.random(1, #options)]
	until (choice and #choice > 0)

	message.Chat:SendMessage("How about "..choice..", "..message.FromDisplayName.."?")
end

function ball(chat, message, question)
	message.Chat:SendMessage(getBallResponse())
end

function roll(chat, message, roll)
	local amount, sides = string.match(roll or "", "(%d+)d(%d+)")
	amount, sides = tonumber(amount), tonumber(sides)
	print("amount = "..(amount or "nil"), "sides = "..(sides or "nil"), "type(amount) = "..(type(amount) or "whoops"), "type(sides) = "..(type(sides) or "whoops"))
	message.chat:sendMessage(message.FromDisplayName.." rolled "..dice((amount and type(amount) ~= "string" and amount > 0) and amount or 1, sides or 20))
end