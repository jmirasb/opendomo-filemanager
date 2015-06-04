include_script("/scripts/fileManager.sh.js");

$("button[type=submit]").on("click", searchFiles);
$("#string").on("keydown", function(event){
	if (event.which==13) {
		searchFiles(event);
	}
});
$("fieldset.selectable li").on("mouseup touchend", function(event) {
	var keywords = $("li.keyword.selected").text();
	searchFiles();
});

function searchFiles(event){
	if (event) event.preventDefault();
	$("p.loading").show();
	var string = $("#string").val();
	loadAsync("?GUI=XML&string="+string,function(data){
		$(data).find("item").each(function(){
			
		});
		setTimeout(function(){
			$("p.loading").hide();
		}, 1000);
	});
}

if (typeof loadAsync == "undefined") {
	//TODO Remove this block on 2.2.6
	function loadAsync(filePath, callback){
		jQuery.ajax({
			type : "GET",
			url : filePath
		}).success(callback);		
	}
}