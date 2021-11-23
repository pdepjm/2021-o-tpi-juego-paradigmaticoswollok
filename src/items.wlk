import wollok.game.*
import sounds.*
import scenario.*

class Item { 
	
	var property position = null
	
	method explode() {
		// Un item debe entender el mensaje pero no hacer nada
	}
	
	method collide(entity) {
		entity.collidedWithItem(self)
	}
	
	method hit() {
		soundProducer.sound("item.wav").play()
		self.remove()
	}
	
	method giveEffect(entity)
	
	method remove() {
		game.removeVisual(self)
	}
	
} 

object heart inherits Item {
	
	const healthPoints = 50
	
	method image() = "Heart.png"
	
	override method giveEffect(entity) {
		entity.giveHealth(healthPoints)
	}
	
} 

object snack inherits Item {
	
	const damagePoints = 5
	
	method image() = ourGame.currentSnack() + ".png"
	
	override method giveEffect(entity) {
		entity.giveDamagePoints(damagePoints)
		game.schedule(5000, {entity.giveDamagePoints(-damagePoints)})
	}
	
}