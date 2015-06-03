include_script("/scripts/fileManager.sh.js");

$("button[type=submit]").on("click", searchFiles);
$("#search").on("keydown", function(event){
	if (event.which==13) {
		event.preventDefault();
		searchFiles();
	}
});


function searchFiles(event){
	event.preventDefault();
	var string = $("#string").val();
	loadAsync("?GUI=XML&amp;string="+string,function(data){
		$("p.loading").show();
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