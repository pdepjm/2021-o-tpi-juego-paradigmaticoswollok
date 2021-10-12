import wollok.game.*
import entities.*
import directions.*

object background{
	
	var backgroundImage
	
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

object level1{
	
//	method background() {
////		game.boardGround("level1_background.png")
//		game.boardGround("Nordelta1.png")
//	}
	
	method setupEntity(entity, position, freq, movStyle, fLimit){
		entity.position(position)
		entity.movementSetup(freq, movStyle, fLimit)
		game.addVisual(entity)
	}
	
}

object general {
	method keyAssigments() {
		keyboard.left().onPressDo({capybaraPlayer.walkTo(left)})	
		keyboard.right().onPressDo({capybaraPlayer.walkTo(right)})	
		keyboard.up().onPressDo({capybaraPlayer.jump()})		
		keyboard.down().onPressDo({capybaraPlayer.crouch()})


		keyboard.num1().onPressDo({background.image("level1.png")})
		keyboard.num2().onPressDo({background.image("level2.png")})
//		keyboard.space().onPressDo({})

//		keyboard.space().onPressDo({capybaraPlayer.execute()})
	}
	
	method movement(entity) {
		game.onTick(entity.frequency(), "movement",{ entity.movement(entity.movementStyle(), entity.frameLimit()) })
	}
	
}