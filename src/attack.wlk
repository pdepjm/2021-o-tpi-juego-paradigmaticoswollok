import wollok.game.*
import sounds.*
import scenario.*

class Attack {
	
	var property position = null
	const damagePoints = null
	const strength = null
	const eventName = "throw" + 1.randomUpTo(9)
	var status = normal
	
	method image() = status.toString() + "Attack" + strength + ".png"
	
	method status(aStatus) {
		status = aStatus
	}
	
	method collide(anEntity) {
		self.hit(anEntity)
		self.explode()
	}
	
	method hit(anEntity) = status.giveDamage(anEntity, damagePoints * strength)
	
	method explode() {
		status.explode(self)
	}
	
	method clash() {
		game.onCollideDo(self, {attack => attack.explode()})
	}
	
	
	method thr0w (dir) {
		game.addVisual(self)
		game.onTick(40, eventName, {
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
		if(position.x() == game.origin().x() || position.x() == game.width()) status.explode(self)
	}
	
	method approachingToEnemy() = position.x() == ourGame.currentEnemy().position().right(2).x() and ourGame.currentEnemy().isAlive()
}

object normal {
	
	method giveDamage(anEntity, realDamage) {
		soundProducer.sound("attackHit.wav").play()
		anEntity.takeDamage(realDamage) 
	}
	
	method explode(attack) {
		attack.remove()
		attack.status(exploded)
	}
	
}

object exploded {
	
	method giveDamage(anEntity, realDamage) {
		
	}
	
	method explode(attack) {
		
	}
	
}

class AttackType {
	
	const cooldownTime = null
	const strength = null
	var property pendingCooldown = true
	
	method cooldownTime() = cooldownTime
	
	method strength() = strength
	
}