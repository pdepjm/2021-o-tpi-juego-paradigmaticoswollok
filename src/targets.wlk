import entities.*
import scenario.*
import wollok.game.*

class Target {
	
	const entity = null
	
	var position = self.position()
	
	method position()
	
//	method image() = "guideCell.png"
		
}

class BottomTarget inherits Target {
	override method position() = entity.position().right(4).up(1)
}

class MiddleTarget inherits Target {
	override method position() = entity.position().right(4).up(3)
}

class UpperTarget inherits Target {
	override method position() = entity.position().right(4).up(6)
}