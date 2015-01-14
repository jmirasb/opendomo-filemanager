var currentItem = -1;
$(function($){
	$("body").on("keydown",function(event){
		console.log("Key pressed: "+ event.which);
		/* NAVIGATION KEYS */
		if (event.which == 39 ) { // Right 
			currentItem++;
		}
		if (event.which == 37 ) { // Left
			currentItem--;
		}	
		if (currentItem == -1) currentItem = $("fieldset li").length -1;
		if (currentItem >=  $("fieldset li").length ) currentItem = 0; 		
		
		var item = $("#" + $("fieldset li")[currentItem].id );
		
		/* FUNCTIONAL KEYS */
		if (event.which == 46 ) { // Delete
		
		}
		
		if (event.which == 13) {  // Enter
			window.location.replace(item.prop("href"));
		}		
		

		
		$("fieldset li").removeClass("highlight");
		$("fieldset li")[currentItem].className+=" highlight";
	});
});