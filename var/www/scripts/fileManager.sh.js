var currentItem = -1;
$(function($){
	$("body").on("keydown",function(event){
		console.log("Key pressed: "+ event.which);
		if (event.which == 39 ) { // Right
			currentItem++;
		}
		if (event.which == 37 ) { // Left
			currentItem--;
		}	
		if (currentItem == -1) currentItem = $("fieldset li").length -1;
		if (currentItem >=  $("fieldset li").length ) currentItem = 0; 
		
		$("fieldset li").removeClass("highlight");
		$("fieldset li")[2].className+=" highlight";
	});
});