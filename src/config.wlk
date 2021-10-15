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
		
		const bottomTarget = new BottomTarget(entity = entity)
		const middleTarget = new MiddleTarget(entity = entity)
		const upperTarget = new UpperTarget(entity = entity)
		
		game.addVisual(entity)
		
		game.addVisual(bottomTarget)
		game.addVisual(middleTarget)
		game.addVisual(upperTarget)
	}
	
	method keyAssigments() {
		keyboard.left().onPressDo({capybaraPlayer.walkTo(left)})	
		keyboard.right().onPressDo({capybaraPlayer.walkTo(right)})	
		keyboard.up().onPressDo({capybaraPlayer.jump()})		
		keyboard.down().onPressDo({capybaraPlayer.crouch()})


		keyboard.num1().onPressDo({background.image("level1.png")})
		keyboard.num2().onPressDo({background.image("level2.png")})
		
		
		keyboard.s().onPressDo({capybaraPlayer.mainAttack().execute(juego.currentEnemy())})
		keyboard.d().onPressDo({capybaraPlayer.specialAttack().execute(juego.currentEnemy())})
		
		keyboard.z().onPressDo({juego.currentEnemy().mainAttack().execute(capybaraPlayer)})
		keyboard.x().onPressDo({juego.currentEnemy().specialAttack().execute(capybaraPlayer)})

//		keyboard.space().onPressDo({capybaraPlayer.execute()})
	}
	
	method movement(entity) {
		game.onTick(entity.frequency(), "movement",{ entity.movement(entity.movementStyle(), entity.frameLimit()) })
	}
	
}