import wollok.game.*
import directions.*
import attack.*
import scenario.*
import moves.*
import sounds.*
import healthbars.*
import gameOverlay.*

class Entity {
	
	const maxHealth = 200
	var property health = maxHealth
	const healthbar = new Healthbar(entity = self)
	var property damagePoints = 15
	var pendingCooldown = true
	var property attackApproaching = false
	const main = new AttackType(cooldownTime = 800, strength = 1)
	const special = new AttackType(cooldownTime = 21000, strength = 3)
	const attackTypes = [main, special]
	
	// Visuals
	var property position = null
	var frameLimit = null // Por si alguna animación requiere más fotogramas. La cantidad de fotogramas es frameLimit + 1 (Van del 0 a n)
	var frequency = null // Frecuencia de actualización en ms para el game.onTick()
	var isJumping = false // Se usa para evitar que camine en el aire
	var movementStyle = "DynamicPose" // Cuando haga una acción, se le cambia esto
	var poseNumber = 0 // Número de fotograma actual
	var targets = #{}
	var property upperTarget = null
	
	method image()
	
	method name()
	
	// Graphics methods
	method targets() = targets
	
	method addTargets(targetCollection) {
		targets += targetCollection
	}
		
	method movementStyle() = movementStyle

	method frameLimit() = frameLimit

	method frequency() = frequency
	
	method isJumping() = isJumping

	method moveTo(dir) {
		if(dir.canMove(self)) position = dir.nextPosition(position)
	}

	method movement(style, frames) {
		movementStyle = style
		poseNumber ++
		if(poseNumber == frames) {
			poseNumber = 0
		}
	}
	
	method jump() {
		if(!isJumping) {
			soundProducer.sound("jumpStart.wav").play()
			self.resetUpperTarget()
			self.animationSetup(0, 10, "Jump", 9)
			self.moveTo(up)
			isJumping = true
			game.schedule(350, {
				if(self.isAlive()) {
					self.moveTo(down)
					isJumping = false
					soundProducer.sound("jumpEnd.wav").play()
				}
			})
		}
		self.backToDynamicPose(430)
	}
	
	method crouch() {
		if(!isJumping) {
			soundProducer.sound("crouch.wav").play()
			self.animationSetup(0, 30, "Crouch", 24)
			if(game.hasVisual(upperTarget)) self.removeUpperTarget()	
			self.backToDynamicPose(750)
		}
	}
	
	method explode() {
		
	}
	
	method removeUpperTarget() {
		game.removeVisual(upperTarget)
		targets.remove(upperTarget)
	}
	
	method addUpperTarget() {
		targets.add(upperTarget)		
		game.addVisual(upperTarget)
	}
	
	method resetUpperTarget() {
		if(!(game.hasVisual(upperTarget)) and self.isAlive()) {
			self.addUpperTarget()
		}
	}
		
	method fluidMovement(dir, times) {
		self.moveTo(dir)
		times.times({i => game.schedule(40, {self.moveTo(dir)})})
	}
	
	method animationSetup(poseNum, freq, movStyle, fLimit) {
		poseNumber = poseNum
		frequency = freq
		movementStyle = movStyle
		frameLimit = fLimit
	}
	
	method backToDynamicPose(when) {
		game.schedule(when, {
			movementStyle = "DynamicPose"
			frameLimit = 24
			frequency = 40
			self.resetUpperTarget()
		})
		
	}
	
	// Class methods
	method attack(strength) = new Attack(damagePoints = damagePoints, strength = strength)

	method throwAttack(type, dir) {
		if(!type.pendingCooldown()) {
			const attack = self.attack(type.strength())
			soundProducer.sound("attack.wav").play()
			type.pendingCooldown(true)
			self.attackOrigin(attack)
			attack.thr0w(dir)
			game.schedule(type.cooldownTime(), {
				if(!game.hasVisual(gameOverlay))type.pendingCooldown(false)
			})
		}
	}
	
	method throwMainAttack(dir) {
		self.throwAttack(main, dir)
	}
	
	method throwSpecialAttack(dir) {
		self.throwAttack(special, dir)
	}

	method attackOrigin(attack)

	method takeDamage(damage) {
		soundProducer.sound("sufferingEntity.wav").play()
		health = (health - damage).max(0)
		if(!self.isAlive()) ourGame.endRound()
	}

	method isAlive() = health > 0
	
	method die() {
		targets.forEach({target => game.removeVisual(target)})
		game.removeVisual(healthbar)
		game.removeVisual(self)
	}
	
	method main() = main
	
	method special() = special
	
	method pendingCooldown(boolean) {
		pendingCooldown = boolean
	}
	
	method collidedWithItem(item) {
		
	}
	
	method maxHealth() = maxHealth
	
	method healthLevel() = ((16 / maxHealth) * health).roundUp(0).min(16)
	
	method healthbar() = healthbar
	
}

class Enemy inherits Entity {
	
	const movements = [jumping, jumping, crouching, crouching, noMove]
	
	override method image() = "Enemy" + movementStyle + poseNumber + ".png"

	override method name() = "Enemy"

	override method attackOrigin(attack) {
		attack.position(position.up(3))
	}
		
	method attackPattern() {
		self.attackRandomly()
		3.randomUpTo(5).roundUp().times({i => game.schedule(800, {
			if(self.isAlive()) self.attackRandomly()
		}) })
	}
	
	method attackRandomly() {
		self.moveRandomly()
		self.throwAttack(attackTypes.anyOne(), left)
	}
	
	method removeTickEvents() {
		game.removeTickEvent("enemyAttack")
		game.removeTickEvent("attackAwareness")
	}
	
	override method die() {
		self.removeTickEvents()
		super()
	}
	
	method poseNumber() = poseNumber
	
	method moveRandomly() = movements.anyOne().move(self)
	
	method avoidAttack() {
		if(attackApproaching) {
			self.moveRandomly()
			attackApproaching = false
		}
	}
	
}

object player inherits Entity{
	
	override method image() = "Capybara" + movementStyle + poseNumber + ".png"
	
	override method name() = "Capybara"
	
	override method attackOrigin(attack) {
		attack.position(position.right(5).up(3))
	}
	
	override method collidedWithItem(item) {
		item.giveEffect(self)
		item.hit()
	}
	
	method giveDamagePoints(n) {
		damagePoints += n
	}
	
	method giveHealth(n) {
		health = (health + n).min(maxHealth)
	}
	
	method walkTo(dir) {
		if(!isJumping) {
			soundProducer.sound("footsteps.wav").play()
			self.resetUpperTarget()
			self.animationSetup(0, 5, "Steps_" + dir.toString() + "_", 9)
			self.fluidMovement(dir, 2)
			self.backToDynamicPose(400)
		}
	}
	
}
