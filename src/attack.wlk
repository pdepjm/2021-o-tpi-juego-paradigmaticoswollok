import wollok.game.*
import entities.*
import directions.*
import sounds.*
import scenario.*

class Attack {
	
	var property position = null
	const damagePoints = null
	const strength = null
	const eventName = "throw" + 1.randomUpTo(9).toString()
	var status = "attack"
	
	method image() = status + ".png"
	
	method hit(anEntity) {
		soundProducer.sound("attackHit.wav").play()
		self.giveDamage(anEntity)
		self.explode()
	}
	
	method giveDamage(anEntity) = anEntity.takeDamage(damagePoints * strength)
	
	method clash() {
		game.onCollideDo(self, {attack => attack.explode()})
	}
	
	method explode() {
		status = "explosion"
		self.remove()
	}
	
	method thr0w (dir) {
		game.addVisual(self)
		game.onTick(10, eventName, {
			self.execute(dir)
			if(self.approachingEnemy() and juego.currentEnemy().isAlive()) { // Darle la responsabilidad al enemigo
				juego.currentEnemy().randomMove()
			}
		})
		self.clash()
	}
	
	method remove() {
		game.removeTickEvent(eventName)
		game.schedule(100, {game.removeVisual(self)})
	}
	
	method execute(dir) {
		position = dir.nextPosition(position)
		self.outOfBounds()
	}
	
	method outOfBounds() {
		if(position.x() == game.origin().x() || position.x() == game.width()) self.remove()
	}
	
	method approachingEnemy() = position.x() == juego.currentEnemy().position().right(2).x()
}
