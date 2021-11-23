class Target {
	
	const entity = null
	
	method position()
	
	method explode() {
		
	}
	
}

class MiddleTarget inherits Target {
	override method position() = entity.position().right(4).up(3)
}

class UpperTarget inherits Target {
	override method position() = entity.position().right(4).up(6)
}