import attack.*
import scenario.*

class Entity {
	
	var health = 0
	var difficulty = 1
	var mainAttack = new Punch(n = difficulty)
	var specialAttack = new Powershot(n = difficulty)
	
	method takeDamage(damage)	
		
	method mainAttack() = mainAttack
	
	method specialAttack() = specialAttack
	
	method isDead() = health == 0
	
}

class Enemy inherits Entity {
	
	override method takeDamage(damage){
		health -= damage
	}
	
	method avoidAttack(attack) {
		attack.avoid()
	}
	
}

class Player inherits Entity {
	
	override method takeDamage(damage){
		health -= damage
	}
	
}

//object player {
//	
//	var health = 0
//	
//	method takeDamage(damage){s
//		health -= damage * 2
//	}
//	
//}