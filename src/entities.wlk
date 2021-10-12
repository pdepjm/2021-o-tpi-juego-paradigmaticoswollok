import wollok.game.*
import directions.*
import attack.*

class Entity {
	
	var health = null
	var difficulty = null
	var damagePoints = null
	var attack = null
//	var mainAttack = null
//	var specialAttack = null
	var position = null
	var frameLimit = null // Por si alguna animación requiere más fotogramas. La cantidad de fotogramas es frameLimit + 1 (Van del 0 a n)
	var frequency = null // Frecuencia de actualización en ms para el game.onTick()
	var isJumping = "no" // Se usa para evitar que camine en el aire
	var movementStyle = "DynamicPose" // Cuando haga una acción, se le cambia esto
	var cycleRepeat = 0 // Al llegar al último fotograma del movimiento, se suma un ciclo
	var poseNumber = 0 // Número de fotograma actual
	
	method image()
	
	method position() = position
	
	method position(aPosition){
		position = aPosition
	}
			
	method movementStyle() = movementStyle
	
	method frameLimit() = frameLimit
	
	method frequency() = frequency
	
	method takeDamage(damage)
	
	method attack() = new Attack(damagePoints = damagePoints, difficulty = difficulty)
		
	method isDead() = health == 0
	
	method isJumping() = isJumping == "yes"
	
	method moveTo(dir) {
		if(dir.toString() == "left" || dir.toString() == "right"){
			if(isJumping == "no") position = dir.nextPosition(position)
		}
		else position = dir.nextPosition(position)
	}
	
	method movement(style, frames){
		movementStyle = style
		poseNumber ++
		if(poseNumber == frames){
			poseNumber = 0
			cycleRepeat ++
		}
		self.blink()
	}
	
	method blink(){
		if(cycleRepeat == 3){
			cycleRepeat = 0
			game.schedule(frequency, {movementStyle += "Blink"})	
			game.schedule(frequency*2, {movementStyle = "DynamicPose"})	
		}
	}
	
	method jump(){
		if(self.isJumping().negate()){ 
			self.movementSetup(10, "Jump", 9)
			self.fluidMovement(up, 5)
			isJumping = "yes"
			game.schedule(350, {
				self.fluidMovement(down, 5)
				isJumping = "no"
			})
		}
		self.backToDynamicPose(430)
	}
	
	method crouch(){
		if(self.isJumping().negate()){
			self.movementSetup(40, "Crouch", 24)
			self.backToDynamicPose(1000)
		}
	}
	
	method fluidMovement(dir, times){
		self.moveTo(dir)
		times.times({i => game.schedule(40, {self.moveTo(dir)})})
//		game.schedule(40, {self.moveTo(dir)})
//		game.schedule(80, {self.moveTo(dir)})
	}
	
	method movementSetup(freq, movStyle, fLimit){
		poseNumber = 0
		frequency = freq
		movementStyle = movStyle
		frameLimit = fLimit
	}
	
	method backToDynamicPose(when){
		game.schedule(when, {movementStyle = "DynamicPose"; frameLimit = 24; frequency = 40})
	}
	
}

class Enemy inherits Entity {
	
//	override method image() = "Enemy" + movementStyle + poseNumber + ".png"
	override method image() = "EnemyPose.png"
	
	override method takeDamage(damage){
		health -= damage * 1.5
	}
	
	method avoidAttack(attack) {
		attack.avoid()
	}
	
}

object capybaraPlayer inherits Entity{
		
	var direction = right
		
	override method image() = "Capybara" + movementStyle + poseNumber + ".png"
	
	method walkTo(dir) {
		if(self.isJumping().negate()){
			self.movementSetup(10, "Steps_" + dir.toString() + "_", 9)
			self.fluidMovement(dir, 3)
			self.backToDynamicPose(240)
		}
	}
		
	override method takeDamage(damage){
		health -= damage
	}	
	
}