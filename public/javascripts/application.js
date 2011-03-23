// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(document).ready(function(){
    $("input#post-box").blur(function() 
    { 
       		if($("input#post-box").val == "")
				$("input#post-box").val("Post something...");
    }); 
 
    $("input#post-box").click(function() 
    { 
        	$("input#post-box").val("");
    }); 


});