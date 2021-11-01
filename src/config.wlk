import wollok.game.*
import entities.*
import directions.*
import scenario.*
import attack.*
import targets.*
import items.*

object general {
	
	method background() {
		game.boardGround("background.png")
	}
	
	method appearItems() {
		game.onTick(21000, "Appear random item", {juego.appearRandomItem()})
	}
	
	method initializeGame() {
		self.setupEntity(player, game.at(0,4), 40, "DynamicPose", 24)
		self.characterAnimation(player)
		self.keyAssigments()
		self.appearItems()
	}
	
	method setupEnemy() {
		self.setupEntity(juego.currentEnemy(), game.at(27,4), 40, "DynamicPose", 24)
		game.onTick(3500, "enemyAttack", {juego.currentEnemy().attackPattern()})
	}
	
	method setupEntity(entity, position, freq, movStyle, fLimit) {
		self.setupEntityAnimation(entity, position, freq, movStyle, fLimit)
		self.characterAnimation(entity)
	}
	
	method setupEntityAnimation(entity, position, freq, movStyle, fLimit) {
		entity.position(position)
		
		const bottomTarget = new BottomTarget(entity = entity)
		const middleTarget = new MiddleTarget(entity = entity)
		const upperTarget = new UpperTarget(entity = entity)
		const targets = #{bottomTarget, middleTarget, upperTarget}
		
		entity.animationSetup(0, freq, movStyle, fLimit)
		
		game.addVisual(entity)
		
		targets.forEach({target => game.addVisual(target)})
		
		entity.addTargets(targets)
		
		entity.upperTarget(upperTarget)
		
		targets.forEach({target => self.hit(target, entity)})
	}
	
	method hit(target, entity) {
		game.onCollideDo(target, {something => something.hit(entity)})
	}	
	
	method keyAssigments() {
		keyboard.left().onPressDo({player.walkTo(left)})	
		keyboard.right().onPressDo({player.walkTo(right)})	
		keyboard.up().onPressDo({player.jump()})		
		keyboard.down().onPressDo({player.crouch()})
		
		keyboard.s().onPressDo({player.throwAttack(new Attack(damagePoints = player.damagePoints(), strength = 1), right)})
		keyboard.d().onPressDo({player.throwAttack(new Attack(damagePoints = player.damagePoints(), strength = 3), right)})
	}
	
	method characterAnimation(entity) {
		game.onTick(entity.frequency(), "movement",{entity.movement(entity.movementStyle(), entity.frameLimit()) })
	}
	
}