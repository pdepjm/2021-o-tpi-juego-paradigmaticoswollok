import wollok.game.*
import entities.*
import attack.*

class Level{
	
	const enemies = []
	
	method currentEnemy() = enemies.filter({enemy => game.hasVisual(enemy)}).head()
	
	method win() = enemies.all({enemy => enemy.isDead()})
//	method win() = self.currentEnemy().isDead()
	method lose() = capybaraPlayer.isDead()
	
	method endGame(){
		if(self.win()) game.say(capybaraPlayer, "Ya gané")
		else if(self.lose()) game.say(capybaraPlayer, "Perdí :'(")
	}
	
}

const level1 = new Level()

class EnemyFactory{
	
	var healthPoints = null
//	var difficultyLevel = null
	var damagePoints = null
		
	method createEnemy() = new Enemy(
		health = healthPoints,
		damagePoints = damagePoints
	)
	
}