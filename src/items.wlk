import wollok.game.*
import entities.*
import targets.*

class Item { 
	
	var property healthPoints = 100
	var position = game.center()
	
	method position() = position
	
	method position(aPosition) {
		position = aPosition
	}
	
	method hit(entity) {
		entity.collidedWithItem(self)
//		entity.giveHealth(self.healthPoints())
//		game.removeVisual(self)
	}
	
	method realHit(entity) {
		entity.giveHealth(self.healthPoints())
		self.remove()
	}
	
	method remove() {
		game.removeVisual(self)
	}
	
//	method newHealth(quantity){ 
//		healthPoints += quantity
//	}

} 

class Heart inherits Item {
	
//	var position = game.center()
	method image() = "Heart.png"
	
} 

class Matienzo inherits Item {
	
//	var position = game.center()
	var property damagePoints = 100
	
	method image() = "Matienzo.png"
	
	override method realHit(entity) {
		entity.giveDamagePoints(self.damagePoints())
		super(entity)
	}
	
} 

//object itemTarget {
//	
//	var position = self.position()
//	
//	method position() = capybaraPlayer.position().right(4).up(2)
//	
////	method image() = "guideCell.png"
//	
//}