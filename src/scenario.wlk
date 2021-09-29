import entity.*
import attack.*

class Level1{
	
			
	method currentEnemy() = ( new EasyEnemyFactory() ).createEnemy()
	
}

class EasyEnemyFactory{
	
	method createEnemy() = new Enemy(
		health = [100,110,120,130].anyOne(), 
		difficulty = 1,
		mainAttack = new Punch(n = 1),
		specialAttack = new Powershot(n = 1)
	)
	
}