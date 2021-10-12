object left {
	method nextPosition(actualPosition) = actualPosition.left(1) 
}

object right {
	method nextPosition(actualPosition) = actualPosition.right(1) 
}

object up {
	method nextPosition(actualPosition) = actualPosition.up(1)
}

object down {
	method nextPosition(actualPosition) = actualPosition.down(1)
}

//object arriba {
//	method proximaPosicion(posicionActual) = posicionActual.up(1)
//}
//
//object abajo {
//	method proximaPosicion(posicionActual) = posicionActual.down(1)
//}