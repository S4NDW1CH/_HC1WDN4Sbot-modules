local t_update
local t_newyear

local message = skype:sendMessage("xx_killer_xx_l", "hi")

function f(m)
	message = m.chat:sendMessage(string.format("%.2d:%.2d:%.2d",(((1451595600 - os.time())/(60*60))%24), (1451595600 - os.time())/60%60, (1451595600 - os.time())%60))
	t_update = timer.newTimer{type="delay", time = 1}
end

function onLoad()
	t_newyear = timer.newTimer{type="set", time=1451595600}

	bot.registerCommand{name="ny", func = f}
end

function timerTriggered(t)
	if t == t_newyear then
		chat:sendMessage("(fireworks)(fireworks)(fireworks)(fireworks)(fireworks)(fireworks)(fireworks)(fireworks)(fireworks)(fireworks)(fireworks)(fireworks)(fireworks)(fireworks)(fireworks)(fireworks)(fireworks)(fireworks)\n(festiveparty)(festiveparty)(festiveparty)(festiveparty)(festiveparty)(festiveparty)(festiveparty)(festiveparty)(festiveparty)(festiveparty)(festiveparty)(festiveparty)(festiveparty)(festiveparty)(festiveparty)(festiveparty)(festiveparty)(festiveparty)(festiveparty)")
		t_newyear:delete()
	end

	if t == t_update and os.time() <= 1451595600 then
		message.Body = string.format("%.2d:%.2d:%.2d",(((1451595600 - os.time())/(60*60))%24), (1451595600 - os.time())/60%60, (1451595600 - os.time())%60)
		t_update = timer.newTimer{type="delay", time = 1}
	end
end