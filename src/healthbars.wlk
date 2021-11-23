import wollok.game.*

class Healthbar {
	
	const entity = null
	
	method image() = entity.name() + "Healthbar" + entity.healthLevel() + ".png"
	
	method position() = game.origin()
	
}