import wollok.game.*
import sounds.*
import scenario.*

class Attack {
	
	var property position = null
	const damagePoints = null
	const strength = null
	const eventName = "throw" + 1.randomUpTo(100)
	var status = "attack"
	
	method image() = status + strength + ".png"
	
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
			if(self.approachingToEnemy()) ourGame.currentEnemy().attackApproaching(true)
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
	
	method approachingToEnemy() = position.x() == ourGame.currentEnemy().position().right(2).x() and ourGame.currentEnemy().isAlive()
}
