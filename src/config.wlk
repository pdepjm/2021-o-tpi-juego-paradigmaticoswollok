import wollok.game.*
import entities.*
import directions.*
import scenario.*

object background{
	
	var backgroundImage = null
	
	var position = game.origin()
	
	method image() = backgroundImage
	
	method image(image){
		backgroundImage = image
	}
	
	method position() = position
	
	method level(number){
//		backgroundImage = "level" + number + "_background.png"
		backgroundImage = "level" + number + ".png"
		game.addVisual(self)
	}
}

object general {
	
	method setupEntity(entity, position, freq, movStyle, fLimit){
		entity.position(position)
		entity.movementSetup(freq, movStyle, fLimit)
		game.addVisual(entity)
	}
	
	method keyAssigments(currentLevel) {
		keyboard.left().onPressDo({capybaraPlayer.walkTo(left)})	
		keyboard.right().onPressDo({capybaraPlayer.walkTo(right)})	
		keyboard.up().onPressDo({capybaraPlayer.jump()})		
		keyboard.down().onPressDo({capybaraPlayer.crouch()})


		keyboard.num1().onPressDo({background.image("level1.png")})
		keyboard.num2().onPressDo({background.image("level2.png")})
		
		
		keyboard.s().onPressDo({capybaraPlayer.mainAttack().execute(currentLevel.currentEnemy())})
		keyboard.d().onPressDo({capybaraPlayer.specialAttack().execute(currentLevel.currentEnemy())})
		
		keyboard.z().onPressDo({currentLevel.currentEnemy().mainAttack().execute(capybaraPlayer)})
		keyboard.x().onPressDo({currentLevel.currentEnemy().specialAttack().execute(capybaraPlayer)})


//		keyboard.space().onPressDo({capybaraPlayer.execute()})
	}
	
	method movement(entity) {
		game.onTick(entity.frequency(), "movement",{ entity.movement(entity.movementStyle(), entity.frameLimit()) })
	}
	
}