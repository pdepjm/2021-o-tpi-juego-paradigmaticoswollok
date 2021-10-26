object jumping{
	
	method move(entity) = entity.jump()
	
}

object crouching{
	
	method move(entity) = entity.crouch()
	
}

object noMove{
	
	method move(entity) = entity.animationSetup(entity.poseNumber(), 40, "DynamicPose", 24)
	
}