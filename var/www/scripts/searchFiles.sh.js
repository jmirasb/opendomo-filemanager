include_script("/scripts/fileManager.sh.js");

function searchFiles(){
	var string = $("#string").val();
	loadAsync("?GUI=XML&amp;string="+string,function(data){
		
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