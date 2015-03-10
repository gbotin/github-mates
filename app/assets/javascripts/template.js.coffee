$(document).ready ->

	$(".alert").alert()

	$(".more-info").live 'click', (e)->
		$("#map").addClass 'span9'
		$("#side").addClass 'span3'
		$("#side").removeClass 'hidden'
		$("#side .content").html('<div class="progress progress-striped active"><div class="bar" style="width: 100%;"></div></div>')  
		$("#side .content").load("contributor-infos/" + $(e.currentTarget).attr('href').replace('#', ''))
		false

	$(".close-infos").live 'click', ->
		$("#map").removeClass 'span9'
		$("#side").removeClass 'span3'
		$("#side").addClass 'hidden'
		false