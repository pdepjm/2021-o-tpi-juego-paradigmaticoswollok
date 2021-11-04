import wollok.game.*
import sounds.*
import scenario.*

class Item { 
	
	var property position = null
	
	method explode() {
		// Un item debe entender el mensaje pero no hacer nada
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
	
	const healthPoints = 50
	
	method image() = "Heart.png"
	
	override method giveEffect(entity) {
		entity.giveHealth(healthPoints)
		game.schedule(4500, {entity.giveHealth(-healthPoints)})
	}
	
} 

class Snack inherits Item {
	
	const damagePoints = 5
	
	method image() = ourGame.snack() + ".png"
	
	override method giveEffect(entity) {
		entity.giveDamagePoints(damagePoints)
		game.schedule(4500, {entity.giveDamagePoints(-damagePoints)})
	}
	
}