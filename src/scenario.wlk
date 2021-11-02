import wollok.game.*
import entities.*
import items.*
import config.*
import gameOverlay.*

object juego {
	
	const easyEnemyFactory = new EnemyFactory(healthPoints = 150, damagePoints = 10)
	const strongEnemyFactory = new EnemyFactory(healthPoints = 300, damagePoints = 25)
	var property currentEnemy = easyEnemyFactory.createEnemy()
	var enemyNumber = 1
	
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
	method lose() = player.isAlive().negate()
	
	method gameWon() {
		gameOverlay.gameEnd(won)
	}
	
	method endRound(){
		if(self.lose()) {
			player.die()
			game.removeTickEvent("enemyAttack")
			gameOverlay.gameEnd(lose)
		}
		else if(self.roundWon()){
			currentEnemy.die()
			gameOverlay.enemyDefeated()
			game.schedule(4000, {self.enemyGenerator()})
		}
	}
	
	method enemyGenerator() {
		
		if(enemyNumber <= 3) {
			self.currentEnemy(easyEnemyFactory.createEnemy())
			general.setupEnemy()
		}
		else if(enemyNumber == 4) {
			self.currentEnemy(strongEnemyFactory.createEnemy())
			general.setupEnemy()
		}
		else {
			self.gameWon()
		}
		
		enemyNumber++
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
