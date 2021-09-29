import attack.*

class Entity {
	
	var health
	var difficulty
	var mainAttack
	var specialAttack
	
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

//class Player inherits Entity {
//	
//	override method takeDamage(damage){
//		health -= damage
//	}
//	
//}

object capybaraPlayer {
	
	var health = 200
	var mainAttack = new Punch(n = 1)
	var specialAttack = new Powershot(n = 1)
	
	method takeDamage(damage){
		health -= damage
	}
	
	method mainAttack() = mainAttack
	method specialAttack() = specialAttack
	method isDead() = health == 0
}