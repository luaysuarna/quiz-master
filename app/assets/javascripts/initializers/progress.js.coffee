$(document)
	.ajaxStart ->
		NProgress.start()
	.ajaxStop ->
		NProgress.done()