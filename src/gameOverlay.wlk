import wollok.game.*
import preferences.*
import scenario.*

object gameOverlay {
	
	var property image = "startscreen2.png"
	var stillOnStartscreen = true
	
	method position() = game.origin()
	
	method startscreen() {
		general.initializePlayer()
		game.addVisual(self)
		keyboard.any().onPressDo({
			if(stillOnStartscreen) {
				general.ambientSound()
				game.removeVisual(self)
				general.initializeGame()
				stillOnStartscreen = false
			}
		})
	}
	
	method round(number) {
		const roundName = "round" + number
		image = roundName + ".png"
		game.sound(roundName + ".wav").play()
		game.addVisual(self)
		game.schedule(2000, {
			image = "fight.png"
			game.sound("fight.wav").play()
		})
		game.schedule(4000, {
			game.removeVisual(self)
			ourGame.entitiesCooldown(false)
		})
	}
	
	method enemyDefeated() {
		image = "enemyDefeated.png"
		game.addVisual(self)
		ourGame.entitiesCooldown(true)
		game.schedule(4000, {game.removeVisual(self)})
	}

	method gameEnd(reason) {
		game.addVisual(reason)
		game.schedule(10000, {game.stop()})
	}
	
}

object won {
	method position() = game.origin()
	method image() = "youWin.png"
}

object lose {
	method position() = game.origin()
	method image() = "gameOver.png"
}

