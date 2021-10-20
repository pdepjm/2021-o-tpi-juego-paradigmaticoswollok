import wollok.game.*
import entities.*
import attack.*
import items.*

object juego {
	
	const enemies = #{}
	
// ----------------------------------------------------------------------------------------	

	const items = #{}
	
	method addItem(item){
		items.add(item)
	}
	
	method appearHeart() {
		const x = (10..26).anyOne()
//		const y = (4..7).anyOne()
		game.addVisual(new Heart(
//				healthValue = [25,50,100].anyOne(),
//				position = game.at(x,y)
				position = game.at(x,6)
			)
		)
	}	
	method appearMatienzo() {
		const x = (10..26).anyOne()
//		const y = (4..7).anyOne()
		game.addVisual( 
			new Matienzo(
//				damageValue = [10,20,30].anyOne(),
//				position = game.at(x,y)
				position = game.at(x,6)
			)
		)
	}
		
// ----------------------------------------------------------------------------------------	
	
	method addEnemy(enemy){
		enemies.add(enemy)
	}
	
	method currentEnemy() = enemies.find({enemy => game.hasVisual(enemy)})
	
	method win() = self.currentEnemy().isDead()
	method lose() = capybaraPlayer.isDead()
	
	method endGame(){
		if(self.win()) {
			self.currentEnemy().targets().forEach({target => game.removeVisual(target)})
			game.removeTickEvent("enemyAttack")
			game.removeVisual(self.currentEnemy())
		}
		else if(self.lose()) game.say(capybaraPlayer, "Perdí :'(")
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
