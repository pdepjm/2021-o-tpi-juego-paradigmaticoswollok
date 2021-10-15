import entities.*

object left {
	method nextPosition(actualPosition) = actualPosition.left(1)
	
	method canMove(entity) = !(entity.isJumping())
}

object right {
	method nextPosition(actualPosition) = actualPosition.right(1) 
	
	method canMove(entity) = !(entity.isJumping())
}

object up {
	method nextPosition(actualPosition) = actualPosition.up(1)
	
	method canMove(entity) = true
}

object down {
	method nextPosition(actualPosition) = actualPosition.down(1)
	
	method canMove(entity) = true
}