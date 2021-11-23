import wollok.game.*
import preferences.*
import scenario.*
import sounds.*

object gameOverlay {
	
	var property image = "movementKeys.png"
	var stillOnStartscreen = true
	
	method position() = game.origin()
	
	method instructions() {
		image = "movementKeys.png"
		game.addVisual(self)
		game.schedule(5000, {image = "soundModifierKeys.png"})
		game.schedule(10000, {game.removeVisual(self)})
	}
	
	method startscreen() {
		stillOnStartscreen = true
		image = "Startscreen.png"
		game.addVisual(self)
		keyboard.any().onPressDo({
			if(stillOnStartscreen) {
//				general.ambientSound()
				game.removeVisual(self)
				general.initializeGame()
				stillOnStartscreen = false
			}
		})
		game.schedule(15000, {
			if(stillOnStartscreen) ourGame.easterEgg()
		})
	}
	
	method round(number) {
		const roundName = "round" + number
		image = roundName + ".png"
		soundProducer.sound(roundName + ".wav").play()
		game.addVisual(self)
		game.schedule(2000, {
			image = "fight.png"
			soundProducer.sound("fight.wav").play()
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
		game.schedule(4000, {
			game.removeVisual(self)
			ourGame.enemySpawner()
		})
	}

	method gameEnd(reason) {
		game.addVisual(reason)
		game.schedule(4000, {
			game.removeVisual(reason)
			game.addVisual(self)
			image = "FinalScreen.png"
			keyboard.r().onPressDo({ourGame.restart()})
			keyboard.enter().onPressDo({game.stop()})
		})
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

