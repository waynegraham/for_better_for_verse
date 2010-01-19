jQuery(document).ready(function() {
	jQuery("a[href$='mp3']").click(function() {
		var popup = window.open('','Audio','width=470,height=26');
		var text = jQuery(this).text();
		var file = jQuery(this).attr("href");
		var html = ("<!DOCTYPE html><html lang='en'><head><title>Audio</title></head><body style='margin:20px 20px 0;padding:0;font-size:11px;font-family:arial,sans-serif;background:#666;'><embed id='mAP' width='430' height='26' src='/wp-content/themes/cat4-site/plr.swf' class='adplr' type='application/x-shockwave-flash' flashvars='playerID=mAP&titles=" + text + "&soundFile=" + file + "&autostart=yes' quality='high' menu='false' wmode='transparent' /><a style='color:#fff!important;float:right;' href='" + file + "'>Download</a></body></html>")
		/*var player = "<embed id='mAP' width='430' height='26' src='/wp-content/themes/cat4-site/plr.swf' class='adplr' type='application/x-shockwave-flash' flashvars='playerID=mAP&titles=" + text + "&soundFile=" + file + "&autostart=yes' quality='high' menu='false' wmode='transparent' />";
		popup.document.write("<!DOCTYPE html><html lang='en'><head><title>Audio</title>");
		popup.document.write("</head><body style='margin:20px 20px 0;padding:0;font-size:11px;font-family:arial,sans-serif;background:#666;'>");
		popup.document.write(player);
		popup.document.write("<a style='color:#fff!important;float:right;' href='" + file + "'>Download</a>");
		popup.document.write("</body></html>");*/
		
		return false;
	});
});
