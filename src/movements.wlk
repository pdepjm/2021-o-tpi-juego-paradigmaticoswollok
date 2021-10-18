object jumping{
	
	method move(entity) = entity.jump()
	
}

object crouching{
	
	method move(entity) = entity.crouch()
	
}

object noMove{
	
	method move(entity) = entity.movementSetup(entity.poseNumber(), 40, "DynamicPose", 24)
	
}