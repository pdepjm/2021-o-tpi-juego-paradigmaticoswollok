import wollok.game.*
import characters.*
import directions.*

object level1{
	
	method background() {
		game.boardGround("level1_background.png")
	}
	
	method characters() {
		game.addVisual(capybara)
	}
	
}

object general {
	
	method keyAssigments() {
		keyboard.left().onPressDo({capybara.moveTo(left)})		
		keyboard.right().onPressDo({capybara.moveTo(right)})	
		keyboard.up().onPressDo({capybara.jump()})		
//		keyboard.down().onPressDo(capybara.crouch())	
	}
	
}