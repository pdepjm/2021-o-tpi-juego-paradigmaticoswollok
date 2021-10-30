import wollok.game.*
import entities.*
import attack.*
import items.*
import config.*

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
		game.schedule(20000, {
			if(game.hasVisual(item)) game.removeVisual(item)
		})
	}
		
// ----------------------------------------------------------------------------------------	
	
	method roundWon() = currentEnemy.isDead()
	method lose() = capybaraPlayer.isDead()
	method gameWon() = game.say(capybaraPlayer, "Gané!")
	
	method endRound(){
		if(self.lose()) {
			capybaraPlayer.die()
			game.removeTickEvent("enemyAttack")
			game.say(currentEnemy, "Game Over")
		}
		else if(self.roundWon()){
			currentEnemy.die()
			game.say(capybaraPlayer, "¡Derroté al enemigo " + (enemyNumber - 1) + "!")
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
//			game.stop()
		}
		
		enemyNumber++
	}
	
}

class EnemyFactory{
	
	var healthPoints = null
//	var difficultyLevel = null
	var damagePoints = null
		
	method createEnemy() = new Enemy(
		health = healthPoints,
		damagePoints = damagePoints
	)
	
}
