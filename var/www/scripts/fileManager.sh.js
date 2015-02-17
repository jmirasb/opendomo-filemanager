var repositoryURL="https://github.com/jmirasb/opendomo-filemanager/";

var currentItem = -1;
$(function($){
	/* This will be moved as CGI's feature when it's finally stable */
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
		
		try {
			var item = $($("fieldset li")[currentItem]);
			
			/* FUNCTIONAL KEYS */
			if (event.which == 46 ) { // Delete
				item.addClass("deleted");
				setTimeout(function(){
					item.remove();
					if (currentItem == -1) currentItem = $("fieldset li").length -1;
					if (currentItem >=  $("fieldset li").length ) currentItem = 0; 							
					$("fieldset li")[currentItem].className+=" highlight";
				},500);
			}
			
			if (event.which == 13) {  // Enter
				window.location.replace(item.find("a").prop("href"));
			}		
		}catch(e) {
			
		}
				
		$("fieldset li").removeClass("highlight");
		$("fieldset li")[currentItem].className+=" highlight";
	});
	
	initialize_thumbnails();
	$("body").append("<div id='imagepreview' style='display:none;'>"+
		"<div class='previousimage'></div>"+
		"<div class='currentimage'></div>"+
		"<div class='nextimage'></div>"+
		"</div>");
});

function initialize_thumbnails() {
	// Processing thumbnails
	$("fieldset.indexed li.image").each(function(item){
		var fullpath = $(this).prop("id");
		$(this).on("click",zoomTo);
		var link = $(this).find("a");
		var imgpath = link.prop("href");
		link.prop("href","#");
		$(this).data("imagepath",imgpath);
		//link.prop("href","javascript:zoomTo('"+fullpath+"')"); // Disable the link
		$(this).css("background-image","url('" + imgpath+ "')");
	});	
}

function zoomTo(event) {
	$("#imagepreview").show("slow");
	var imagepath = $(this).data("imagepath");
	$("div.currentimage").css("background-image","url('" + imagepath+ "')");
}