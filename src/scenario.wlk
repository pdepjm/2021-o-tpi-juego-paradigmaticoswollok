import entity.*

class Level1{
	
	const currentFactory = new EasyEnemyFactory()
			
	method currentEnemy() = currentFactory.createEnemy()
	
}

class EasyEnemyFactory{
	
	method createEnemy() = new Enemy(health = 100) // Hay que revisar el any y generar PS al azar dentro de un intervalo
	
}