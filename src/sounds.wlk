import wollok.game.*

object soundProducer {
	
	var provider = game
	var property mainVolume = 0.2
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
		soundProducer.mainVolume(0)
	}
	
}

object volumeDown {
	
	const volume = soundProducer.mainVolume() - 0.1
	
	method change() {
		soundProducer.mainVolume(volume)
	}
	
}

object volumeUp {
	
	const volume = soundProducer.mainVolume() + 0.1
	
	method change() {
		soundProducer.mainVolume(volume)
	}
	
}

object soundProviderMock {
	
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