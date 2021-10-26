import wollok.game.*
import entities.*
import directions.*
import scenario.*
import attack.*
import targets.*
import items.*

object general {
	
	method background(){
		game.boardGround("background.png")
	}
	
	method appearItems() {
		game.onTick(45000, "Appear random item", {juego.appearRandomItem()})
	}
	
	method setupEntity(entity, position, freq, movStyle, fLimit){
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
	
	method hit(target, entity){
		game.onCollideDo(target, {something => 
			something.hit(entity)
		})
	}	
	
	method keyAssigments() {
		keyboard.left().onPressDo({capybaraPlayer.walkTo(left)})	
		keyboard.right().onPressDo({capybaraPlayer.walkTo(right)})	
		keyboard.up().onPressDo({capybaraPlayer.jump()})		
		keyboard.down().onPressDo({capybaraPlayer.crouch()})
		
		keyboard.s().onPressDo({capybaraPlayer.throwAttack(new Attack(damagePoints = capybaraPlayer.damagePoints(), strength = 1), right)})
		keyboard.d().onPressDo({capybaraPlayer.throwAttack(new Attack(damagePoints = capybaraPlayer.damagePoints(), strength = 3), right)})
		
		keyboard.z().onPressDo({juego.currentEnemy().mainAttack().giveDamage(capybaraPlayer)})
		keyboard.x().onPressDo({juego.currentEnemy().specialAttack().giveDamage(capybaraPlayer)})
		
		keyboard.i().onPressDo({game.say(capybaraPlayer, game.allVisuals().toString())})

//		keyboard.space().onPressDo({capybaraPlayer.giveDamage()})
	}
	
	method characterAnimation(entity) {
		game.onTick(entity.frequency(), "movement",{ entity.movement(entity.movementStyle(), entity.frameLimit()) })
	}
	
}