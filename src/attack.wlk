import wollok.game.*
import entities.*
import directions.*

class Attack {
	
	var position = null
	var damagePoints = null
	var strength = null
	var eventName = "throw" + 1.randomUpTo(9).toString()
	
//	method image() = "guideCell.png"
	method image() = "attack.png"
	
	method position() = position
	
	method position(aPosition){
		position = aPosition
	}
		
	method hit(anEntity){
		anEntity.takeDamage(damagePoints * strength)
		self.remove()
	}
	
	method thr0w (dir) {
		game.addVisual(self)
		game.onTick(10, self.eventName(), {self.execute(dir)})
	}
	
	method eventName() = eventName
	
	method remove() {
		game.removeTickEvent(self.eventName())
		game.removeVisual(self)
	}
	
	method execute(dir){
		position = dir.nextPosition(position)
		self.outOfBounds()
	}
	
	method outOfBounds(){
		if(position.x() == 1 || position.x() == game.width()){
			self.remove()
		}
	}
}
