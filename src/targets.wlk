import entities.*
import scenario.*

class HitTarget {
	
	const entity = null
	
	var position = self.position()
	
	method position()
	
//	method image() = "guideCell.png"
		
}

class BottomTarget inherits HitTarget {
	override method position() = entity.position().right(4).up(1)
}

class MiddleTarget inherits HitTarget {
	override method position() = entity.position().right(4).up(3)
}

class UpperTarget inherits HitTarget {
	override method position() = entity.position().right(4).up(6)
}


