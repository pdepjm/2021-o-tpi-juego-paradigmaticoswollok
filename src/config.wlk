import wollok.game.*
import entities.*
import directions.*
import scenario.*
import attack.*

//object background{
//	
//	var backgroundImage = null
//	
//	var position = game.origin()
//	
//	method image() = backgroundImage
//	
//	method image(image){
//		backgroundImage = image
//	}
//	
//	method position() = position
//	
//	method level(number){
////		backgroundImage = "level" + number.toString() + "_background.png"
//		backgroundImage = "level" + number.toString() + ".png"
//		game.addVisual(self)
//	}
//}

object general {
	
	method background(){
		game.boardGround("background.png")
	}
	
	method setupEntity(entity, position, freq, movStyle, fLimit){
		entity.position(position)
		
		const bottomTarget = new BottomTarget(entity = entity)
		const middleTarget = new MiddleTarget(entity = entity)
		const upperTarget = new UpperTarget(entity = entity)
		
		
		entity.movementSetup(freq, movStyle, fLimit)
		
		game.addVisual(entity)
		
		game.addVisual(bottomTarget)
		game.addVisual(middleTarget)
		game.addVisual(upperTarget)
		
		entity.addTargets(#{bottomTarget, middleTarget, upperTarget})		
		
		self.hit(bottomTarget, entity)		
		self.hit(middleTarget, entity)		
		self.hit(upperTarget, entity)
	}
	
//	method setupAttack(entity){
////		const mainAttack =  new Attack(damagePoints = entity.damagePoints(), strength = 1)
////		const specialAttack =  new Attack(damagePoints = entity.damagePoints(), strength = 3)
////		game.addVisual(mainAttack.visual())
////		game.addVisual(mainAttack)
////		game.onTick(40, "Fireball", {mainAttack.visual().movement()})
//	}
	
	method hit(target, entity){
		game.onCollideDo(target, {attack => attack.execute(entity)
			attack.removeVisuals()
			game.removeTickEvent("throw")
		})
	}	
	
	method keyAssigments() {
		keyboard.left().onPressDo({capybaraPlayer.walkTo(left)})	
		keyboard.right().onPressDo({capybaraPlayer.walkTo(right)})	
		keyboard.up().onPressDo({capybaraPlayer.jump()})		
		keyboard.down().onPressDo({capybaraPlayer.crouch()})
		
		keyboard.s().onPressDo({capybaraPlayer.throwAttack(new Attack(position = game.at(5,7), damagePoints = 15, strength = 1))})
		keyboard.d().onPressDo({capybaraPlayer.throwAttack(new Attack(position = game.at(5,7), damagePoints = 15, strength = 3))})
//		keyboard.s().onPressDo({capybaraPlayer.throwAttack(capybaraPlayer.mainAttack())})
//		keyboard.d().onPressDo({capybaraPlayer.throwAttack(capybaraPlayer.specialAttack())})
		
		keyboard.z().onPressDo({juego.currentEnemy().mainAttack().execute(capybaraPlayer)})
		keyboard.x().onPressDo({juego.currentEnemy().specialAttack().execute(capybaraPlayer)})

//		keyboard.space().onPressDo({capybaraPlayer.execute()})
	}
	
	method movement(entity) {
		game.onTick(entity.frequency(), "movement",{ entity.movement(entity.movementStyle(), entity.frameLimit()) })
	}
	
}