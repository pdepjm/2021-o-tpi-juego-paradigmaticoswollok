import wollok.game.*
import entities.*
import directions.*

class Attack {
	
	var position = null
	var damagePoints = null
	var strength = null
	
//	method image() = "guideCell.png"
	method image() = "attack.png"
	
	method position() = position
	
	method position(aPosition){
		position = aPosition
	}
		
	method giveDamage(anEntity){
		anEntity.takeDamage(damagePoints * strength)
	}
	
	method execute(dir){
		position = dir.nextPosition(position)
		self.outOfBounds()
	}
	
	method outOfBounds(){
		if(position.x() == 1 || position.x() == 34){
			game.removeVisual(self)
			game.removeTickEvent("throw")
		}
	}
}
