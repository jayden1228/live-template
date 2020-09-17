type $FUNCNAME$Param struct {
	$END$
}

func $FUNCNAME$(c *gin.Context) {
	var param $FUNCNAME$Param
	if err := c.ShouldBindJSON(&param); err != nil {

	}
}