import wollok.game.*
import entities.*
import directions.*
import scenario.*
import targets.*
import sounds.*

object general {
	
	method background() {
		game.boardGround("background.png")
	}
	
	method ambientSound() {
		soundProducer.ambientSound().shouldLoop(true)
		soundProducer.ambientSound().play()
	}
	
	method appearItems() {
		game.onTick(21000, "Appear random item", {ourGame.appearRandomItem()})
	}
	
	method initializeGame() {
		self.entitySetup(player, game.at(0,4), 80, "DynamicPose", 24)
		self.characterAnimation(player)
		self.keyAssigments()
		self.appearItems()
		ourGame.enemySpawner()
	}
	
	method enemySetup() {
		self.entitySetup(ourGame.currentEnemy(), game.at(27,4), 40, "DynamicPose", 24)
		game.schedule(5000, {ourGame.currentEnemy().attackPattern()})
		game.onTick(10000, "enemyAttack", {ourGame.currentEnemy().attackPattern()})
		game.onTick(10, "attackAwareness", {ourGame.currentEnemy().avoidAttack()})
	}
	
	method entitySetup(entity, position, freq, movStyle, fLimit) {
		self.entityAnimationSetup(entity, position, freq, movStyle, fLimit)
		self.characterAnimation(entity)
		game.addVisual(entity.healthbar())
	}
	
	method entityAnimationSetup(entity, position, freq, movStyle, fLimit) {
		entity.position(position)
		
		const middleTarget = new MiddleTarget(entity = entity)
		const upperTarget = new UpperTarget(entity = entity)
		const targets = #{middleTarget, upperTarget}
		
		entity.animationSetup(0, freq, movStyle, fLimit)
		
		game.addVisual(entity)
		
		targets.forEach({target => game.addVisual(target)})
		
		entity.addTargets(targets)
		
		entity.upperTarget(upperTarget)
		
		targets.forEach({target => self.hit(target, entity)})
		
		game.schedule(4000, {entity.pendingCooldown(true)})
	}
	
	method hit(target, entity) {
		game.onCollideDo(target, {something => something.hit(entity)})
	}	
	
	method keyAssigments() {
		keyboard.left().onPressDo({player.walkTo(left)})	
		keyboard.right().onPressDo({player.walkTo(right)})	
		keyboard.up().onPressDo({player.jump()})		
		keyboard.down().onPressDo({player.crouch()})
		keyboard.s().onPressDo({player.throwMainAttack(right)})
		keyboard.d().onPressDo({player.throwSpecialAttack(right)})
		keyboard.num1().onPressDo({soundProducer.changeVolume(volumeDown)})
		keyboard.num2().onPressDo({soundProducer.changeVolume(volumeUp)})
		keyboard.m().onPressDo({soundProducer.changeVolume(mute)})
		
		
		// 
		keyboard.e().onPressDo({ourGame.currentEnemy().takeDamage(ourGame.currentEnemy().health())})
		keyboard.p().onPressDo({player.takeDamage(player.health())})
		
		keyboard.h().onPressDo({game.say(player, player.health().toString())})
	}
	
	method characterAnimation(entity) {
		game.onTick(entity.frequency(), "movement",{entity.movement(entity.movementStyle(), entity.frameLimit()) })
	}
	
}