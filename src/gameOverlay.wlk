import wollok.game.*
import preferences.*
import scenario.*
import sounds.*

object gameOverlay {
	
	var property image = "startscreen.png"
	var stillOnStartscreen = true
	const easterEggSound = soundProducer.sound("easterEgg.mp3")
	
	method position() = game.origin()
	
	method startscreen() {
		game.addVisual(self)
		keyboard.any().onPressDo({
			if(stillOnStartscreen) {
				general.ambientSound()
				game.removeVisual(self)
				general.initializeGame()
				stillOnStartscreen = false
			}
		})
		game.schedule(15000, {
			if(stillOnStartscreen) self.easterEgg()
		})
	}
	
	method easterEgg() {
		easterEggSound.play()
		keyboard.any().onPressDo({
			if(easterEggSound.played()) easterEggSound.stop()
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

