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
	
//	method newHealth(quantity){ 
//		healthPoints += quantity
//	}

} 

class Heart inherits Item {
	
//	var position = game.center()
	method image() = "Heart.png"
	
	method givePoints(entity) {
		entity.giveHealth(self.healthPoints())
	}
	
} 

class Matienzo inherits Item {
	
//	var position = game.center()
	var property damagePoints = 100
	
	method image() = "Matienzo.png"
	
	method givePoints(entity) {
		entity.giveHealth(self.healthPoints())
		entity.giveDamagePoints(self.damagePoints())
	}
	
} 

object itemTarget {
	
	var position = self.position()
	
	method position() = capybaraPlayer.position().right(4).up(2)
	
//	method image() = "guideCell.png"
	
}