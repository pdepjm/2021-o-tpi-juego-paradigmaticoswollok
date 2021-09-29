class Punch{
	
	var n = 1
	
	method executeAttack(entity){
		entity.takeDamage(20 * n)
	}
	
}

class Powershot{
	
	var n = 1
	
	method executeAttack(entity){
		entity.takeDamage(35 * n)
	}
	
}