<?php 
/*
 *	microAudio Wordpress Plugin
 *	(c) 2008-9 Christopher O'Connell
 *	Dual Licensed under the MIT and GPL licenses
 *  See license.txt, included with this package for more
 *
 *	microAudio.js.php
 *  Release 0.6.2, March 2009
 */
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
	
	// Variables for the Player
	$location = 'http://'.$_GET['siteurl']."/wp-content/plugins/microaudio/";
?>
//uAudio(c)http://compu.terlicio.us/
<?php
if ($_GET['autoconfig'] == 'true' || $_GET['autoconfig'] == 'magic') {
?>
var c_bg="0xE5E5E5";var c_leftbg="0xCCCCCC";var c_rightbg="0xB4B4B4";var c_rightbghover="0x999999";var c_lefticon="0x333333";var c_righticon="0x333333";var c_righticonhover="0xFFFFFF";var c_text="0x333333";var c_tracker="0xDDDDDD";var c_track="0xFFFFFF";var c_loader="0x009900";var c_border="0xCCCCCC";var c_voltrack="0xF2F2F2";var c_volslider="0x666666";var c_skip="0x666666";
<?php
} // autoconfig()
?>
mAjQ(document).ready(function(){<?php if ($_GET['autoconfig'] == 'true') echo "autoconfig();"; ?><?php if ($_GET['autoconfig'] == 'magic') echo "magicconfig();"; ?>pplr();});
function pplr(){mAjQ("a[href$='mp3']").live("click",function(){if(!mAjQ(this).hasClass("mAa")){<?php if ($_GET['download'] == 'true') echo "if (mAjQ(this).hasClass(\"microAudio-download\"))return true;"; ?> var mae="<embed id='mAP' height='26' src='<?php echo $location; ?>plr.swf' class='adplr' type='application/x-shockwave-flash' flashvars='playerID=mAP&titles="+mAjQ(this).text()+"&soundFile="+mAjQ(this).attr("href")+"&autostart=<?php 
				echo $_GET['autostart'];
				if ($_GET['autoconfig'] == 'true' || $_GET['autoconfig'] == 'magic') {
					echo "&bg=\" +c_bg+ \"&leftbg=\" +c_leftbg+ \"&rightbg=\" +c_rightbg+ \"&lefticon=\" +c_lefticon+ \"&righticon=\" +c_righticon+ \"&righticonhover=\" +c_righticonhover+ \"&text=\" +c_text+ \"&tracker=\" +c_tracker+ \"&track=\" +c_track+ \"&border=\" +c_border+ \"&voltrack=\" +c_voltrack+ \"&volslider=\" +c_volslider+ \"&skip=\" +c_skip+ \"&rightbghover=\" +c_rightbghover+ \"&tracker=\" +c_tracker+ \"&loader=\" +c_loader+ \"";
				}
					?>' quality='high' menu='false' wmode='transparent' />";mAjQ(this).addClass("mAa").after("<div class='mAp' style='height: 26;'>"+mae+"</div>")<?php if ($_GET['download'] == 'true') echo ".after(\"<span>&nbsp;[<a class='microAudio-download' href='\"+mAjQ(this).attr(\"href\")+\"'>Download</a>]&nbsp;</span>\")"; ?>;}else{mAjQ(this).next().remove();mAjQ(this).removeClass("mAa").next().remove();}return false;});}
<?php
if ($_GET['autoconfig'] == 'true' || $_GET['autoconfig'] == 'magic') {
?>
function autoconfig(){
    if (mAjQ(".content,#content").css("background-color")) c_bg=rgb2hex(mAjQ(".content,#content").css("background-color"),c_bg);
    if (mAjQ("#header").css("background-color")) c_leftbg=rgb2hex(mAjQ("#header").css("background-color"),c_leftbg);
    if (mAjQ("body").css("background-color")) c_rightbg=rgb2hex(mAjQ("body").css("background-color"),c_rightbg);
    if (mAjQ("h2 a").css("color")) c_lefticon=rgb2hex(mAjQ("h2 a").css("color"),c_lefticon);
    if (mAjQ("small").css("color")) c_righticon=rgb2hex(mAjQ("small").css("color"),c_righticon);
    if (mAjQ("a").css("color")) c_righticonhover=rgb2hex(mAjQ("a").css("color"),c_righticonhover);
    if (mAjQ(".entry").css("color")) c_text=rgb2hex(mAjQ(".entry").css("color"),c_text);
    if (mAjQ("#header").css("background-color")) c_tracker=rgb2hex(mAjQ("#header").css("background-color"),c_tracker);
    if (mAjQ("body").css("background-color")) c_track=rgb2hex(mAjQ("body").css("background-color"),c_track);
    if (mAjQ("#header").css("background-color")) c_border=rgb2hex(mAjQ("#header").css("background-color"),c_border);
}
function magicconfig() {
	mAjQ("div:first").after("<span class='microAudio-autoconfigWrapper'><span class='microAudio-bg' /><span class='microAudio-leftbg' /><span class='microAudio-lefticon' /><span class='microAudio-voltrack' /><span class='microAudio-rightbg' /><span class='microAudio-rightbghover' /><span class='microAudio-righticon' /><span class='microAudio-righticonhover' /><span class='microAudio-skip' /><span class='microAudio-text' /><span class='microAudio-track' /><span class='microAudio-border' /><span class='microAudio-loader' /><span class='microAudio-tracker' /></span>");
	if (mAjQ(".microAudio-bg").css("color")) c_bg=rgb2hex(mAjQ(".microAudio-bg").css("color"),c_bg);
	if (mAjQ(".microAudio-leftbg").css("color")) c_leftbg=rgb2hex(mAjQ(".microAudio-leftbg").css("color"),c_leftbg);
	if (mAjQ(".microAudio-rightbg").css("color")) c_rightbg=rgb2hex(mAjQ(".microAudio-rightbg").css("color"),c_rightbg);
	if (mAjQ(".microAudio-lefticon").css("color")) c_lefticon=rgb2hex(mAjQ(".microAudio-lefticon").css("color"),c_lefticon);
	if (mAjQ(".microAudio-righticon").css("color")) c_righticon=rgb2hex(mAjQ(".microAudio-righticon").css("color"),c_righticon);
	if (mAjQ(".microAudio-righticonhover").css("color")) c_righticonhover=rgb2hex(mAjQ(".microAudio-righticonhover").css("color"),c_righticonhover);
	if (mAjQ(".microAudio-text").css("color")) c_text=rgb2hex(mAjQ(".microAudio-text").css("color"),c_text);
	if (mAjQ(".microAudio-tracker").css("color")) c_tracker=rgb2hex(mAjQ(".microAudio-tracker").css("color"),c_tracker);
	if (mAjQ(".microAudio-track").css("color")) c_track=rgb2hex(mAjQ(".microAudio-track").css("color"),c_track);
	if (mAjQ(".microAudio-border").css("color")) c_border=rgb2hex(mAjQ(".microAudio-border").css("color"),c_border);
	if (mAjQ(".microAudio-voltrack").css("color")) c_voltrack=rgb2hex(mAjQ(".microAudio-voltrack").css("color"),c_voltrack);
	if (mAjQ(".microAudio-volslider").css("color")) c_volslider=rgb2hex(mAjQ(".microAudio-volslider").css("color"),c_volslider);
	if (mAjQ(".microAudio-skip").css("color")) c_skip=rgb2hex(mAjQ(".microAudio-skip").css("color"),c_skip);
	if (mAjQ(".microAudio-loader").css("color")) c_loader=rgb2hex(mAjQ(".microAudio-loader").css("color"),c_loader);
	if (mAjQ(".microAudio-rightbghover").css("color")) c_rightbghover=rgb2hex(mAjQ(".microAudio-rightbghover").css("color"),c_rightbghover);
}
function rgb2hex(S,me){
    if(S=='transparent'||S.substring(0,4)=='rgba'||S==null||S===null) return me;
    if(S.substring(0,1)=='#') return "0x"+S.substring(1,S.length);
    var chars=S.substring(4,S.length);
    var secs=chars.split(',');
    return"0x"+toHex(secs[0])+toHex(secs[1])+toHex(secs[2]);
}
function toHex(N){
    if(N==null)return"00";
    N=parseInt(N);
    if(N==0||isNaN(N)) return"00";
    N=Math.max(0,N);
    N=Math.min(N,255);
    N=Math.round(N);
    return"0123456789ABCDEF".charAt((N-N%16)/16)+"0123456789ABCDEF".charAt(N%16);
}
<?php
} // autoconfig()
?>