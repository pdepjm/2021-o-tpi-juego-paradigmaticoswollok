class Punch{
	
	var n
	
	method executeAttack(entity){
		entity.takeDamage(20 * n)
	}
	
}

class Powershot{
	
	var n
	
	method executeAttack(entity){
		entity.takeDamage(35 * n)
	}
	
}