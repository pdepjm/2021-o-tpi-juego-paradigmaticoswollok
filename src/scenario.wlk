import wollok.game.*
import entities.*
import attack.*

object juego {
	
	const enemies = #{}
	
//	var items = #{}
//	
//	method addItem(item){
//		items.add(item)
//	}
//	
//	method appearHeart() {
//		const x = (0..game.width()-1).anyOne()
//		const y = (0..game.height()-1).anyOne()
//		game.addVisual( 
//			new Heart(
//				healthValue = [25,50,100].anyOne(),
//				position = game.at(x,y)
//			)
//		)
//	}	
//	method appearEnergyDrink() {
//		const x = (0..game.width()-1).anyOne()
//		const y = (0..game.height()-1).anyOne()
//		game.addVisual( 
//			new EnergyDrink(
//				damageValue = [10,20,30].anyOne(),
//				position = game.at(x,y)
//			)
//		)
//	}
//	
//	method collideWith(){
//		game.onCollideDo(capybaraPlayer,{item => capybaraPlayer.recollect(item)} )
//	}
	
	method addEnemy(enemy){
		enemies.add(enemy)
	}
	
	method currentEnemy() = enemies.find({enemy => game.hasVisual(enemy)})
	
//	method win() = enemies.all({enemy => enemy.isDead()})
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
