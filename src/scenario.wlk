import entities.*
import attack.*

class Level{
	
	const factory = null
	
	method currentEnemy() = ( new EnemyFactory() ).createEnemy()
	
//	method win() = self.currentEnemy().isDead()
//	
//	method lose() = capybaraPlayer.isDead()
	
}

class EnemyFactory{
	
	var healthPoints = null
	var difficultyLevel = null
	var damagePoints = null
		
	method createEnemy() = new Enemy(
		health = healthPoints,
//		difficulty = difficultyLevel,
		damagePoints = damagePoints
//		difficulty = 1,
//		mainAttack = new Punch(n = 1),
//		specialAttack = new Powershot(n = 1)
	)
	
}

//import entities.*
//import attack.*
//
//class Level1{
//	
//			
//	method currentEnemy() = ( new EasyEnemyFactory() ).createEnemy()
//	
//}
//
//class EasyEnemyFactory{
//	
//	method createEnemy() = new Enemy(
//		health = [100,110,120,130].anyOne(), 
//		difficulty = 1,
//		mainAttack = new Punch(n = 1),
//		specialAttack = new Powershot(n = 1)
//	)
//	
//}