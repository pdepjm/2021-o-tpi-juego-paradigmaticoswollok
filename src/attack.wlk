import wollok.game.*

class Attack {
	var damagePoints = null
	var strength = null
//	var frameNumber = 0

	method execute(entity){
		entity.takeDamage(damagePoints * strength)
	}
	
}