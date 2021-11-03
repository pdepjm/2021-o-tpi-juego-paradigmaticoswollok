import wollok.game.*
import entities.*
import items.*
import preferences.*
import gameOverlay.*

object ourGame {
	
	const easyEnemyFactory = new EnemyFactory(healthPoints = 150, damagePoints = 10)
	const strongEnemyFactory = new EnemyFactory(healthPoints = 300, damagePoints = 25)
	var property currentEnemy = easyEnemyFactory.createEnemy()
	var property enemyNumber = 1
	
// ----------------------------------------------------------------------------------------	

	const x = (10..26).anyOne()
	const y = 7

	const items = [new Heart(position = game.at(x,y)), new Matienzo(position = game.at(x,y))]
	
	method appearRandomItem() {
		const item = items.anyOne()
		game.addVisual(item)
		game.schedule(5000, {
			if(game.hasVisual(item)) game.removeVisual(item)
		})
	}
		
// ----------------------------------------------------------------------------------------	
	
	method roundWon() = currentEnemy.isAlive().negate()
	method gameOver() = player.isAlive().negate()
	
	method endRound(){
		if(self.gameOver()) {
			game.sound("gameOver.wav").play()
			player.die()
			game.removeTickEvent("enemyAttack")
			game.removeTickEvent("attackAwareness")
			gameOverlay.gameEnd(lose)
		}
		else if(self.roundWon()){
			currentEnemy.die()
			gameOverlay.enemyDefeated()
			game.schedule(4000, {self.enemySpawner()})
		}
	}
	
	method enemyGenerator(enemyFactory) {
		self.currentEnemy(enemyFactory.createEnemy())
		general.setupEnemy()
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
			game.sound("youWin.mp3").play()
		}
		
//		game.sound(roundNumberSound).play()
	}
	
	method entitiesCooldown(boolean) {
		[player, currentEnemy].forEach({entity =>
			entity.main().pendingCooldown(boolean)
			entity.special().pendingCooldown(boolean)
		})
	}
	
}

class EnemyFactory{
	
	const healthPoints = null
	const damagePoints = null
		
	method createEnemy() = new Enemy(
		health = healthPoints,
		damagePoints = damagePoints
	)
	
}
