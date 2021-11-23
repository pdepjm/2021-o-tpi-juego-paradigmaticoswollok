import wollok.game.*

object soundProducer {
	
	var provider = game
	var property status = unmuted
	var property mainVolume = 0.2
	var property lastVolume = mainVolume
	const ambientSound = self.sound("ambientSound.mp3")
	
	method provider(_provider) {
		provider = _provider
	}
	
	method sound(audioFile) {
		const sound = provider.sound(audioFile)
		sound.volume(mainVolume)
		return sound
	}
	
	method changeVolume(how) {
		how.change()
		ambientSound.volume(mainVolume)
	}
	
	method ambientSound() = ambientSound
	
}

object mute {
	
	method change() {
		soundProducer.status().switch()
	}
	
}

object unmuted {
	
	method switch() {
		soundProducer.lastVolume(soundProducer.mainVolume())
		soundProducer.mainVolume(0)
		soundProducer.status(muted)
	}
	
}

object muted {
	
	const lastVolume = soundProducer.lastVolume()
	
	method switch() {
		soundProducer.mainVolume(lastVolume)
		soundProducer.status(unmuted)
	}
	
}

object volumeUp {
	
	method wantedVolume() = (soundProducer.mainVolume() + 0.1).min(1)
	
	method change() {
		soundProducer.mainVolume(self.wantedVolume())
	}
	
}

object volumeDown {
	
	method wantedVolume() = (soundProducer.mainVolume() - 0.1).max(0)
	
	method change() {
		soundProducer.mainVolume(self.wantedVolume())
	}
	
}


object mockSoundProvider {
	
	method sound(audioFile) = soundMock
	
}

object soundMock {
	
	method pause() {}
	
	method paused() = true
	
	method play() {}
	
	method played() = false
	
	method resume() {}
	
	method shouldLoop(looping) {}
	
	method shouldLoop() = false
	
	method stop() {}
	
	method volume(newVolume) {}
	
	method volume() = 0
	
}