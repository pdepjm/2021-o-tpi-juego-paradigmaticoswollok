import wollok.game.*
import entities.*
import attack.*

object juego {
	
	const enemies = #{}
	
	method addEnemy(enemy){
		enemies.add(enemy)
	}
	
	method currentEnemy() = enemies.find({enemy => game.hasVisual(enemy)})
	
//	method win() = enemies.all({enemy => enemy.isDead()})
	method win() = self.currentEnemy().isDead()
	method lose() = capybaraPlayer.isDead()
	
	method endGame(){
		if(self.win()) {
			game.say(capybaraPlayer, "Ya gané")
			game.removeVisual(self.currentEnemy())
			}
		else if(self.lose()) game.say(capybaraPlayer, "Perdí :'(")
	}
	
}

//class Level{
//	
//	const enemies = #{}
//	
//	method currentEnemy() = enemies.find({enemy => game.hasVisual(enemy)})
//	
//	
////	method win() = enemies.all({enemy => enemy.isDead()})
//	method win() = self.currentEnemy().isDead()
//	method lose() = capybaraPlayer.isDead()
//	
//	method endGame(){
//		if(self.win()) game.say(capybaraPlayer, "Ya gané")
//		else if(self.lose()) game.say(capybaraPlayer, "Perdí :'(")
//	}
//	
//}

//const level1 = new Level(enemies = #{})

class EnemyFactory{
	
	var healthPoints = null
//	var difficultyLevel = null
	var damagePoints = null
		
	method createEnemy() = new Enemy(
		health = healthPoints,
		damagePoints = damagePoints
	)
	
}