function onLoad()
	bot.registerCommand{name = "alb8ball", func = ball, pattern = "(.+)"}
	bot.registerCommand{name = "88", func = ball, pattern = "(.+)"}
end

local function getBallResponse()
	local file = io.open("./modules/albBallResponses.txt", "r")

	local responseList = {}
	for line in file:lines() do
		table.insert(responseList, line)
	end
	file:close()

	return responseList[math.random(#responseList)]
end

function ball(chat, message, question)
	message.Chat:SendMessage(getBallResponse())
end