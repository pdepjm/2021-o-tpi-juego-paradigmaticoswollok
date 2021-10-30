import wollok.game.*
import entities.*
import directions.*
import sounds.*
import scenario.*

class Attack {
	
	var position = null
	var damagePoints = null
	var strength = null
	var eventName = "throw" + 1.randomUpTo(9).toString()
	var status = "attack"
	
	method image() = status + ".png"
	
	method position() = position
	
	method position(aPosition){
		position = aPosition
	}
		
	method hit(anEntity) {
		soundProducer.sound("attackHit.wav").play()
		soundProducer.sound("damage.wav").play()
		self.giveDamage(anEntity)
		self.explode()
	}
	
	method giveDamage(anEntity) {
		anEntity.takeDamage(damagePoints * strength)
	}
	
	method clash() {
		game.onCollideDo(self, {attack =>
//			soundProducer.sound("attackHit.wav").play()
			attack.explode()
		})
	}
	
	method explode() {
		status = "explosion"
		self.remove()
	}
	
	method thr0w (dir) {
		game.addVisual(self)
		game.onTick(10, self.eventName(), {
			self.execute(dir)
			if(self.isClose() and juego.currentEnemy().isAlive()){
			juego.currentEnemy().randomMove()
			}
		})
		self.clash()
	}
	
	method eventName() = eventName
	
	method remove() {
		game.removeTickEvent(self.eventName())
		game.schedule(100, {game.removeVisual(self)})
//		game.removeVisual(self)
	}
	
	method execute(dir){
		position = dir.nextPosition(position)
		self.outOfBounds()
	}
	
	method outOfBounds(){
		if(position.x() == game.origin().x() || position.x() == game.width()){
			self.remove()
		}
	}
	
	method isClose() = self.position().x() == juego.currentEnemy().position().right(2).x()
}
