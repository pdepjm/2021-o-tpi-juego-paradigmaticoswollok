import wollok.game.*
import entities.*
import targets.*
import sounds.*

class Item { 
	
	var position = game.center()
	
	method position() = position
	
	method position(aPosition) {
		position = aPosition
	}
	
	method explode() {
		
	}
	
	method hit(entity) {
		entity.collidedWithItem(self)
	}
	
	method realHit(entity) {
		soundProducer.sound("item.wav").play()
		self.giveEffect(entity)
		self.remove()
	}
	
	method giveEffect(entity)
	
	method remove() {
		game.removeVisual(self)
	}
	
} 

class Heart inherits Item {
	
	var property healthPoints = 100
	
	method image() = "Heart.png"
	
	override method giveEffect(entity) {
		entity.giveHealth(self.healthPoints())
	}
	
} 

class Matienzo inherits Item {
	
	var property damagePoints = 100
	
	method image() = "Matienzo.png"
	
	override method giveEffect(entity) {
		entity.giveDamagePoints(self.damagePoints())
	}
	
}