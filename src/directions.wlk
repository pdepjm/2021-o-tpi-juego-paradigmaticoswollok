object left {
	method nextPosition(actualPosition) = actualPosition.left(3) 
}

object right {
	method nextPosition(actualPosition) = actualPosition.right(3) 
}

object up {
	method nextPosition(actualPosition) = actualPosition.up(4)
}

object down {
	method nextPosition(actualPosition) = actualPosition.down(4)
}

//object arriba {
//	method proximaPosicion(posicionActual) = posicionActual.up(1)
//}
//
//object abajo {
//	method proximaPosicion(posicionActual) = posicionActual.down(1)
//}