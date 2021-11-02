import wollok.game.*
import config.*

object gameOverlay {
	
	const backgroundSound = game.sound("backgroundSound.mp3")
	var property image = "startscreen1.png"
	var stillOnStartscreen = true
	
	method position() = game.origin()
	
	method startscreen() {
		backgroundSound.shouldLoop(true)
		backgroundSound.volume(0.1)
		general.initializePlayer()
		game.addVisual(self)
		keyboard.any().onPressDo({
			if(stillOnStartscreen) {
				backgroundSound.play()
				game.removeVisual(self)
				general.initializeGame()
				stillOnStartscreen = false
			}
		})
	}
	
	method enemyDefeated() {
		image = "enemyDefeated.png"
		game.addVisual(self)
		game.schedule(4000, {game.removeVisual(self)})
	}
	
	method gameOver() {
		image = "gameOver.png"
		game.addVisual(self)
		game.schedule(10000, {game.stop()})
	}
	
	method gameEnd(reason) {
		game.addVisual(reason)
		game.schedule(10000, {game.stop()})
	}
	
}

object won {
	method position() = game.origin()
	method image() = "youWon.png"
}

object lose {
	method position() = game.origin()
	method image() = "gameOver.png"
}

