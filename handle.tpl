func $FUNCNAME$(c *gin.Context) {
	var body $RequestType$
	if err := c.ShouldBindJSON(&body); err != nil {
		ResponseError(c, RC_REQUEST_PARAM, err)
		return$END$
	}
}