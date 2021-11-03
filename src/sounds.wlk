import wollok.game.*

object soundProducer {
	
	var provider = game
	var mainVolume = 0.2
	
	method provider(_provider) {
		provider = _provider
	}
	
	method sound(audioFile) {
		const sound = provider.sound(audioFile)
		sound.volume(mainVolume)
		return sound
	}
	
	method volumeUp() {
		mainVolume = (mainVolume + 0.1).min(1)
	}
	
	method volumeDown() {
		mainVolume = (mainVolume - 0.1).max(0)
	}
	
	method mute() {
		mainVolume = 0
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