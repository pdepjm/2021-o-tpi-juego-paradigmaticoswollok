import wollok.game.*
import entities.*
import attack.*
import items.*

object juego {
	
	const enemies = #{}
	
// ----------------------------------------------------------------------------------------	

	const x = (10..26).anyOne()
	const y = [5,7,8,10,13].anyOne()

	const items = [new Heart(position = game.at(x,y)), new Matienzo(position = game.at(x,y))]
	
//	method addItem(item){
//		items.add(item)
//	}
	
	method appearRandomItem() {
		const item = items.anyOne()
		game.addVisual(item)
		game.schedule(20000, {
			if(game.hasVisual(item)) game.removeVisual(item)
		})
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
