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
	
	method appearItems() {
		game.onTick(21000, "Appear random item", {juego.appearRandomItem()})
	}
	
	method initializePlayer() {
		self.setupEntity(player, game.at(0,4), 80, "DynamicPose", 24)
		self.characterAnimation(player)
	}
	
	method initializeGame() {
		self.keyAssigments()
		self.appearItems()
		juego.enemyGenerator()
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
		keyboard.s().onPressDo({player.throwAttack(1, right)})
		keyboard.d().onPressDo({player.throwAttack(3, right)})
		keyboard.num1().onPressDo({soundProducer.volumeDown()})
		keyboard.num2().onPressDo({soundProducer.volumeUp()})
	}
	
	method characterAnimation(entity) {
		game.onTick(entity.frequency(), "movement",{entity.movement(entity.movementStyle(), entity.frameLimit()) })
	}
	
}