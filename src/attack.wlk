import wollok.game.*
import entities.*

class AttackVisual {
	var frameNumber = 0
	var attack = null
//	var frameNumber = 0

//	method execute(anEntity){
//		anEntity.takeDamage(damagePoints * strength)
//	}
	
	method position() = attack.position().left(3).down(1)
	
//	method position(aPosition){
//		position = aPosition
//	}
	
	method image() = "CapybaraFireball" + frameNumber.toString() + ".png"
	
	method movement() {
		frameNumber ++
		if(frameNumber == 4){
			frameNumber = 0
		}
	}
	
}

class Attack {
	
	var position = null
	var damagePoints = null
	var strength = null
	const visual = new AttackVisual(attack = self)
	
//	method image() = "guideCell.png"
	
	method visual() = visual
	
	method position() = position
	
	method position(aPosition){
		position = aPosition
	}
		
	method execute(anEntity){
		anEntity.takeDamage(damagePoints * strength)
	}
		
	method addVisuals(){
		game.addVisual(self)
		game.addVisual(self.visual())
	}
	
	method removeVisuals(){
		game.removeVisual(self)
		game.removeVisual(self.visual())
	}
}
//import wollok.game.*
//
//class Attack {
//	var damagePoints = null
//	var strength = null
//	var position = game.at(10,10)
//	var frameNumber = 0
////	var frameNumber = 0
//
//	method execute(anEntity){
//		anEntity.takeDamage(damagePoints * strength)
//	}
//	
//	method position() = position
//	
//	method position(aPosition){
//		position = aPosition
//	}
//	
//	method image() = "CapybaraFireball" + frameNumber.toString() + ".png"
//	
//	method movement() {
//		frameNumber ++
//		if(frameNumber == 4){
//			frameNumber = 0
//		}
//	}
//	
//}
