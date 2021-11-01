import wollok.game.*

object soundProducer {
	
	var provider = game
	
	method provider(_provider) {
		provider = _provider
	}
	
	method sound(audioFile) {
		const sound = provider.sound(audioFile)
		sound.volume(0.2)
		return sound
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