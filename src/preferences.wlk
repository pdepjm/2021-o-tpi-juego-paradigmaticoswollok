import wollok.game.*
import entities.*
import directions.*
import scenario.*
import targets.*
import sounds.*

const ambientSound = game.sound("ambientSound.mp3")

object general {
	
	method background() {
		game.boardGround("background.png")
	}
	
	method ambientSound() {
		ambientSound.shouldLoop(true)
		ambientSound.volume(0.1)
		ambientSound.play()
	}
	
	method appearItems() {
		game.onTick(21000, "Appear random item", {ourGame.appearRandomItem()})
	}
	
	method initializePlayer() {
		self.setupEntity(player, game.at(0,4), 80, "DynamicPose", 24)
		self.characterAnimation(player)
	}
	
	method initializeGame() {
		self.keyAssigments()
		self.appearItems()
		ourGame.enemySpawner()
	}
	
	method setupEnemy() {
		self.setupEntity(ourGame.currentEnemy(), game.at(27,4), 40, "DynamicPose", 24)
		game.schedule(5000, {ourGame.currentEnemy().attackPattern()})
		game.onTick(10000, "enemyAttack", {ourGame.currentEnemy().attackPattern()})
		game.onTick(10, "attackAwareness", {ourGame.currentEnemy().avoidAttack()})
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
		keyboard.s().onPressDo({player.throwAttack(1, right)})
		keyboard.d().onPressDo({player.throwAttack(3, right)})
		keyboard.num1().onPressDo({soundProducer.volumeDown()})
		keyboard.num2().onPressDo({soundProducer.volumeUp()})
		
		keyboard.i().onPressDo({game.say(player, ourGame.currentEnemy().pendingCooldown().toString())})
		keyboard.p().onPressDo({player.takeDamage(player.health())})
		keyboard.e().onPressDo({ourGame.currentEnemy().takeDamage(ourGame.currentEnemy().health())})
	}
	
	method characterAnimation(entity) {
		game.onTick(entity.frequency(), "movement",{entity.movement(entity.movementStyle(), entity.frameLimit()) })
	}
	
}