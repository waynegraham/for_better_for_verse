<?php 
	// JavaScript for microAudio Widget
	// Christopher O'Connell, 2008
	// Following Cribbed from k2
	// check to see if the user has enabled gzip compression in the WordPress admin panel
	if(ob_get_length() === FALSE and !ini_get('zlib.output_compression') and ini_get('output_handler') != 'ob_gzhandler' and ini_get('output_handler') != 'mb_output_handler') {
		ob_start('ob_gzhandler');
	}

	// The headers below tell the browser to cache the file and also tell the browser it is JavaScript.
	header("Cache-Control: public");
	header("Pragma: cache");

	$offset = 518400; // 60 * 60 * 24 * 6
	$ExpStr = "Expires: ".gmdate("D, d M Y H:i:s", time() + $offset)." GMT";
	$LmStr = "Last-Modified: ".gmdate("D, d M Y H:i:s", filemtime($_SERVER['SCRIPT_FILENAME']))." GMT";

	header($ExpStr);
	header($LmStr);
	header('Content-Type: text/javascript; charset: UTF-8');
//	header('Etag: '.substr(md5('microAudio.widget.js.php version included in 0.5'),2,12));
	
?>
var player = null; 
function playerReady(thePlayer) { 
	player = window.document[thePlayer.id]; 
	var lst = mAjQ("a[href$='mp3']").addToList();
	if (lst.length > 0) player.sendEvent('VOLUME','0');
}	
(function($){
	$.fn.addToList=function(){
		var lst = new Array();
		var i = 0;
        $.each(this,function(){
			var h=$(this).attr("href");
			var k=h.split(/\//);
			var t=$(this).html();
			lst[i] = {type: "audio", file: h, title: t, link: k[0]+"//"+k[2]+"/" };
			i++;
        });
        return lst;
    }
})(mAjQ);
