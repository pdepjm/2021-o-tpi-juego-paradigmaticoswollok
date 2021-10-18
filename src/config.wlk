import wollok.game.*
import entities.*
import directions.*
import scenario.*
import attack.*
import targets.*

object general {
	
	method background(){
		game.boardGround("background.png")
	}
	
	method setupEntity(entity, position, freq, movStyle, fLimit){
		entity.position(position)
		
		const bottomTarget = new BottomTarget(entity = entity)
		const middleTarget = new MiddleTarget(entity = entity)
		const upperTarget = new UpperTarget(entity = entity)
		const targets = #{bottomTarget, middleTarget, upperTarget}
		
		entity.movementSetup(0, freq, movStyle, fLimit)
		
		game.addVisual(entity)
		
		targets.forEach({target => game.addVisual(target)})
		
		entity.addTargets(targets)
		
		entity.upperTarget(upperTarget)
		
		targets.forEach({target => self.hit(target, entity)})	
	}
	
	method hit(target, entity){
		game.onCollideDo(target, {attack => 
			attack.giveDamage(entity)
			game.removeTickEvent("throw")
			game.removeVisual(attack)
		})
	}	
	
	method keyAssigments() {
		keyboard.left().onPressDo({capybaraPlayer.walkTo(left)})	
		keyboard.right().onPressDo({capybaraPlayer.walkTo(right)})	
		keyboard.up().onPressDo({capybaraPlayer.jump()})		
		keyboard.down().onPressDo({capybaraPlayer.crouch()})
		
		keyboard.s().onPressDo({capybaraPlayer.throwAttack(new Attack(damagePoints = 15, strength = 1), right)})
		keyboard.d().onPressDo({capybaraPlayer.throwAttack(new Attack(damagePoints = 15, strength = 3), right)})
//		keyboard.s().onPressDo({capybaraPlayer.throwAttack(capybaraPlayer.mainAttack())})
//		keyboard.d().onPressDo({capybaraPlayer.throwAttack(capybaraPlayer.specialAttack())})
		
		keyboard.z().onPressDo({juego.currentEnemy().mainAttack().giveDamage(capybaraPlayer)})
		keyboard.x().onPressDo({juego.currentEnemy().specialAttack().giveDamage(capybaraPlayer)})
		
		keyboard.i().onPressDo({game.say(capybaraPlayer, game.allVisuals().toString())})

//		keyboard.space().onPressDo({capybaraPlayer.giveDamage()})
	}
	
	method movement(entity) {
		game.onTick(entity.frequency(), "movement",{ entity.movement(entity.movementStyle(), entity.frameLimit()) })
	}
	
}