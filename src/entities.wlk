import wollok.game.*
import directions.*
import attack.*
import scenario.*

class HitTarget {
	
	const entity = null
	
	var position = self.position()
	
	method position()
	
	method text() = position.toString()
		
}

class BottomTarget inherits HitTarget {
	override method position() = entity.position().right(4).up(1)
}

class MiddleTarget inherits HitTarget {
	override method position() = entity.position().right(4).up(3)
}

class UpperTarget inherits HitTarget {
	override method position() = entity.position().right(4).up(6)
}

class Entity {
	
	var health = 200
	var damagePoints = 15
	const mainAttack = self.attack(1)
	const specialAttack = self.attack(3)
	var isDead = false
	
	// Graphics
	var position = null
	var frameLimit = null // Por si alguna animación requiere más fotogramas. La cantidad de fotogramas es frameLimit + 1 (Van del 0 a n)
	var frequency = null // Frecuencia de actualización en ms para el game.onTick()
	var isJumping = false // Se usa para evitar que camine en el aire
	var movementStyle = "DynamicPose" // Cuando haga una acción, se le cambia esto
	var cycleRepeat = 0 // Al llegar al último fotograma del movimiento, se suma un ciclo
	var poseNumber = 0 // Número de fotograma actual
	
	method image()
	
	// Graphics methods
	
	method text() = health.toString()
	
	method position() = position
	method position(aPosition){
		position = aPosition
	}
	
	method movementStyle() = movementStyle

	method frameLimit() = frameLimit

	method frequency() = frequency
	
	method isJumping() = isJumping

	method moveTo(dir) { // Se tratan polimórficamente las direcciones
		if(dir.canMove(self)) position = dir.nextPosition(position)
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
		if(!isJumping){ 
			self.movementSetup(10, "Jump", 9)
			self.fluidMovement(up, 3)
			isJumping = true
			game.schedule(350, {
				self.fluidMovement(down, 3)
				isJumping = false
			})
		}
		self.backToDynamicPose(430)
	}
	
	method crouch(){
		if(!isJumping){
			self.movementSetup(30, "Crouch", 24)
			self.backToDynamicPose(1150)
		}
	}
	
	method fluidMovement(dir, times){
		self.moveTo(dir)
		times.times({i => game.schedule(40, {self.moveTo(dir)})})
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
	
	// Class methods
	
	method health() = health
	
	method health(hp){
		health = hp
	}
	
//	method recollect(item) { 
//		health += item.healthValue()
//		damagePoints += item.damageValue()
//		game.removeVisual(item)
//	}
//	
//	method collide() {
//		game.onCollideDo(self,{item => self.recollect(item)} )
//	}
	
	method mainAttack() = mainAttack
	
	method specialAttack() = specialAttack
	
	method damagePoints() = damagePoints
	
	method damagePoints(dmgPoints){
		damagePoints = dmgPoints
	}
	method attack(strength) = new Attack(damagePoints = damagePoints, strength = strength)
		
	method takeDamage(damage){
//		if(self.isDead()) level1.endGame()
//		if(self.isDead()) self.currentLevel().endGame()
		if(self.isDead()) juego.endGame()
		health = (health - damage).max(0)
	}
	
	method isDead() = health == 0
	
}

class Enemy inherits Entity {
	
	override method image() = "Enemy" + movementStyle + poseNumber + ".png"
//	override method image() = "EnemyPose.png"
	
	method avoidAttack(attack) {
		attack.avoid()
	}
	
}

object capybaraPlayer inherits Entity{
		
	var direction = right
		
	override method image() = "Capybara" + movementStyle + poseNumber + ".png"
	
	method walkTo(dir) {
		if(!isJumping){
//			self.movementSetup(10, "Steps_" + dir.toString() + "_", 9)
			self.movementSetup(5, "Steps_" + dir.toString() + "_", 9)
			self.fluidMovement(dir, 2)
			self.backToDynamicPose(400)
		}
	}
	
}
