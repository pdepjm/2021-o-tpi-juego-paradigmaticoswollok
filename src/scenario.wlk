import wollok.game.*
import entities.*
import items.*
import preferences.*
import gameOverlay.*
import sounds.*

object ourGame {
	
	const easyEnemyFactory = new EnemyFactory(possibleHealthPoints = [140, 150, 160], damagePoints = 15)
	const strongEnemyFactory = new EnemyFactory(possibleHealthPoints = [290, 300, 310], damagePoints = 25)
	var currentEnemy = easyEnemyFactory.createEnemy()
	const easterEggSound = soundProducer.sound("easterEgg.mp3")
	var enemyNumber = 1
	var property snack = "Matienzo"
	
// ----------------------------------------------------------------------------------------	

	const x = (10..19).anyOne()
	const y = 7

	const items = [new Heart(position = game.at(x,y)), new Snack(position = game.at(x,y))]
	
	method appearRandomItem() {
		const item = items.anyOne()
		game.addVisual(item)
		game.schedule(5000, {
			if(game.hasVisual(item)) game.removeVisual(item)
		})
	}
	
// ----------------------------------------------------------------------------------------	
	
	method roundWon() = !currentEnemy.isAlive()
	method gameOver() = !player.isAlive()
	
	method endRound(){
		if(self.gameOver()) {
			soundProducer.sound("gameOver.wav").play()
			player.die()
			currentEnemy.removeTickEvents()
			gameOverlay.gameEnd(lose)
		}
		else if(self.roundWon()){
			currentEnemy.die()
			gameOverlay.enemyDefeated()
		}
	}
	
	method currentEnemy() = currentEnemy
	
	method enemyGenerator(enemyFactory) {
		currentEnemy = enemyFactory.createEnemy()
		general.enemySetup()
		gameOverlay.round(enemyNumber)
		enemyNumber++
	}
	
	method enemySpawner() {
		if(enemyNumber <= 4) {
			self.enemyGenerator(easyEnemyFactory)
		}
		else if(enemyNumber == 5) {
			self.enemyGenerator(strongEnemyFactory)
		}
		else {
			gameOverlay.gameEnd(won)
			soundProducer.sound("youWin.mp3").play()
		}
	}
	
	method entitiesCooldown(boolean) {
		[player, currentEnemy].forEach({entity =>
			entity.main().pendingCooldown(boolean)
			entity.special().pendingCooldown(boolean)
		})
	}
	
	method easterEgg() {
		easterEggSound.play()
		snack = "Donut"
		keyboard.any().onPressDo({
			if(easterEggSound.played()) easterEggSound.stop()
		})
	}
	
}

class EnemyFactory{
	
	const possibleHealthPoints = null
	const damagePoints = null
		
	method createEnemy() = new Enemy(
		maxHealth = possibleHealthPoints.anyOne(),
		damagePoints = damagePoints
	)
	
}
