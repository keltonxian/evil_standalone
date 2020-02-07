local Util = require("app.base.Util")

local Audio = class("Audio")

local BG_MUSIC_ID = nil

function Audio.preloadEffect(fullpath)
	local audio = cc.AudioEngine
	audio:preload(fullpath)
end

function Audio.stopEffect(sound_id)
	local audio = cc.AudioEngine
	audio:stop(sound_id)
end

function Audio.setMusicVolume(value)
	local audio = cc.AudioEngine
	audio:setMusicVolume(value)
end

function Audio.setEffectVolume(value)
	local audio = cc.AudioEngine
	audio:setEffectsVolume(value)
end

function Audio.loadVolume()
	local music_volume = Util.loadRms('music_volume', 'string')
	music_volume = tonumber(music_volume)
	if nil ~= music_volume then
		Audio.setMusicVolume(music_volume)
	end
	local effect_volume = Util.loadRms('effect_volume', 'string')
	effect_volume = tonumber(effect_volume)
	if nil ~= effect_volume then
		Audio.setEffectVolume(effect_volume)
	end
end

function Audio.playEffect(fullpath)
	local audio = cc.AudioEngine
	audio:play2d(fullpath, false)
end

function Audio.preloadMusic(fullpath)
	local audio = cc.AudioEngine
	audio:preload(fullpath)
end

function Audio.playBGMusic(fullpath)
	if true == Util.IS_MUTE then
		return
	end
	if nil ~= BG_MUSIC_ID then
		self:stopBGMusic()
	end
	local audio = cc.AudioEngine
	BG_MUSIC_ID = audio:play2d(fullpath, true)
    Audio.loadVolume()
end

function Audio.stopBGMusic()
	if nil == BG_MUSIC_ID then
		return
	end
	local audio = cc.AudioEngine
	audio:stop(BG_MUSIC_ID)
end

function Audio.resumeBGMusic()
	if nil == BG_MUSIC_ID then
		return
	end
	local audio = cc.AudioEngine
	audio:resume(BG_MUSIC_ID)
end

function Audio.playTap1()
	local path = Util.getFullPath(Util.F_SOUND, 'tap_1.mp3')
	Audio.playEffect(path)
end

function Audio.playTap2()
	local path = Util.getFullPath(F_SOUND, 'tap_2.mp3')
	Audio.playEffect(path)
end

function Audio.playTap3()
	local path = Util.getFullPath(F_SOUND, 'tap_3.mp3')
	Audio.playEffect(path)
end

function Audio.playTurnCard()
	local path = Util.getFullPath(F_SOUND, 'turn_card.mp3')
	Audio.playEffect(path)
end

return Audio

