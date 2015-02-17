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
	item=0;
	$("fieldset li").each(function(item){
		var fullpath = $(this).prop("id");
		$(this).data("itemnumber",item);
		$(this).on("click",zoomTo);
		var link = $(this).find("a");
		var imgpath = link.prop("href");
		link.prop("href","#");
		//link.prop("href","javascript:zoomTo('"+fullpath+"')"); // Disable the link
		if ($(this).hasClass("image")){
			$(this).data("imagepath",imgpath);
			$(this).css("background-image","url('" + imgpath+ "')");
		}
		item++;
	});	
}

function zoomTo(event) {
	currentItem = $(this).data("itemnumber");
	$("#imagepreview").show("slow");
	var imagepath = $($("fieldset li")[currentItem]).data("imagepath");
	var pi = $($("fieldset li")[currentItem-1]?$("fieldset li")[currentItem-1]).data("imagepath"):"";
	var ci = $($("fieldset li")[currentItem]?$("fieldset li")[currentItem]).data("imagepath"):"";
	var ni = $($("fieldset li")[currentItem+1]?$("fieldset li")[currentItem+1]).data("imagepath"):"";
	
	$("div.previousimage").css("background-image","url('" +  pi + "')");
	$("div.currentimage").css("background-image","url('" +  ci + "')");
	$("div.nextimage").css("background-image","url('" +  ni + "')");
}