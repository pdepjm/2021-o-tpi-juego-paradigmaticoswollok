import wollok.game.*
import directions.*

object capybara {
	
	var position = game.at(0,8)
	
	var isJumping = "no"

	var direction = right

	method image() = "capybara1_" + direction.toString() + ".png"
		
	method lookTo(newDirection){
		direction = newDirection
	}
	
	method position() = position
	
	method newPosition(aPosition) {
		position = aPosition
	}
	
	method moveTo(dir) {
		if(dir.toString() == "left" || dir.toString() == "right"){
			if(isJumping == "no") position = dir.nextPosition(position)
		}
		else position = dir.nextPosition(position)
	}
	
	method jump(){
		if(isJumping == "no"){ 
			self.moveTo(up)
			isJumping = "yes"
			game.schedule(500, {
				self.moveTo(down)
				isJumping = "no"
			})
		}
	}
	
//	method jump(){
//		self.moveTo(up)
//		isJumping = "yes"
//		game.schedule(500, {
//			self.moveTo(down)
//			isJumping = "no"
//		})
//	}
	
	method isJumping() = isJumping == "yes"
	
}