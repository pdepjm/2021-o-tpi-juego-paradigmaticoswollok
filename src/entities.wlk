import wollok.game.*
import directions.*
import attack.*
import scenario.*
import movements.*
import targets.*
import items.*
import sounds.*

class Entity {
	
	var health = 200
	var damagePoints = 15
	const mainAttack = self.attack(1)
	const specialAttack = self.attack(3)
	var pendingCooldown = false
	
	// Graphics
	var property position = null
	var frameLimit = null // Por si alguna animación requiere más fotogramas. La cantidad de fotogramas es frameLimit + 1 (Van del 0 a n)
	var frequency = null // Frecuencia de actualización en ms para el game.onTick()
	var isJumping = false // Se usa para evitar que camine en el aire
	var movementStyle = "DynamicPose" // Cuando haga una acción, se le cambia esto
	var cycleRepeat = 0 // Al llegar al último fotograma del movimiento, se suma un ciclo
	var poseNumber = 0 // Número de fotograma actual
	var targets = #{}
	var property upperTarget = null
	
	method image()
	
	// Graphics methods
	
	method targets() = targets
	
	method addTargets(targetCollection){
		targets += targetCollection
	}
		
	method text() = health.toString()
	
	method poseNumber() = poseNumber
	
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
			soundProducer.sound("jumpStart.wav").play()
			self.resetUpperTarget()
			self.animationSetup(0, 10, "Jump", 9)
			self.moveTo(up)
			isJumping = true
			game.schedule(350, {
				self.moveTo(down)
				isJumping = false
				soundProducer.sound("jumpEnd.wav").play()
			})
		}
		self.backToDynamicPose(430)
	}
	
	method crouch(){
		if(!isJumping){
			soundProducer.sound("crouch.wav").play()
			self.animationSetup(0, 30, "Crouch", 24)
			if(game.hasVisual(self.upperTarget())) self.removeUpperTarget()	
			self.backToDynamicPose(1150)
		}
	}
	
	method explode() {
		
	}
	
	method removeUpperTarget(){
		game.removeVisual(self.upperTarget())
		targets.remove(upperTarget)
	}
	
	method addUpperTarget(){
		targets.add(self.upperTarget())		
		game.addVisual(self.upperTarget())
	}
	
	method resetUpperTarget() {
		if(!(game.hasVisual(self.upperTarget())) and self.isAlive()) {
				self.addUpperTarget()
			}
	}
		
	method fluidMovement(dir, times){
		self.moveTo(dir)
		times.times({i => game.schedule(40, {self.moveTo(dir)})})
	}
	
	method animationSetup(poseNum, freq, movStyle, fLimit){
		poseNumber = poseNum
		frequency = freq
		movementStyle = movStyle
		frameLimit = fLimit
	}
	
	method backToDynamicPose(when){
		game.schedule(when, {
			movementStyle = "DynamicPose"
			frameLimit = 24
			frequency = 40
			self.resetUpperTarget()
		})
		
	}
	
	// Class methods
	
	method health() = health
	
	method health(hp){
		health = hp
	}
	
	method mainAttack() = mainAttack
	
	method specialAttack() = specialAttack
	
	method damagePoints() = damagePoints
	
	method damagePoints(dmgPoints){
		damagePoints = dmgPoints
	}
	method attack(strength) = new Attack(damagePoints = damagePoints, strength = strength)
	
	method throwAttack(attack, dir){
		if(!pendingCooldown and juego.currentEnemy().isAlive()){
			soundProducer.sound("attack.wav").play()
			pendingCooldown = true
			self.attackOrigin(attack)
			attack.thr0w(dir)
			game.schedule(900, {pendingCooldown = false})
		}
	}

	method attackOrigin(attack)

	method takeDamage(damage){
		health = (health - damage).max(0)
		if(self.isDead()) juego.endRound()
	}

	method isDead() = health == 0
	
	method isAlive() = not self.isDead()
	
	method die() {
		self.targets().forEach({target => game.removeVisual(target)})
		game.removeVisual(self)
	}
	
}

class Enemy inherits Entity {
	
	const movements = [jumping,crouching, noMove, noMove]
	const strengths = [1,2]
	
	override method image() = "Enemy" + movementStyle + poseNumber.toString() + ".png"

	override method attackOrigin(attack){
		attack.position(self.position().up(3))
	}
		
	method attackPattern(){
//		self.randomMove()
		self.throwAttack(self.attack(strengths.anyOne()), left)
		game.schedule(600, {
//			self.randomMove()
			self.throwAttack(self.attack(strengths.anyOne()), left)
		})
	}
	
	override method die() {
		game.removeTickEvent("enemyAttack")
		super()
	}
	
	method collidedWithItem(item) {
		// Un enemigo debe entender el mensaje pero no verse afectado
	}
	
	method randomMove() = movements.anyOne().move(self)
	
}

object capybaraPlayer inherits Entity{
	
	const maxHealth = 200
		
	override method image() = "Capybara" + movementStyle + poseNumber.toString() + ".png"
	
	override method attackOrigin(attack){
		attack.position(self.position().right(5).up(3))
	}
	
	method collidedWithItem(item) {
		item.realHit(self)
	}
	
	method giveDamagePoints(n) {
		damagePoints += n
	}
	
	method giveHealth(n) {
		health = (health + n).min(maxHealth)
	}
	
	method walkTo(dir) {
		if(!isJumping){
			soundProducer.sound("footsteps.wav").play()
			self.resetUpperTarget()
			self.animationSetup(0, 5, "Steps_" + dir.toString() + "_", 9)
			self.fluidMovement(dir, 2)
			self.backToDynamicPose(400)
		}
	}
	
}
