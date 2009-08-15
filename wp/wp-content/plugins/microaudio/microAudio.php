<?php
/*
Plugin Name: &micro;Audio Player
Plugin URI: http://compu.terlicio.us/code/plugins/audio/
Description: Converts links to mp3 files to a small flash player and a link to the raw file. Player by <a href="http://www.1pixelout.net/code/audio-player-wordpress-plugin/">1 Pixel Out</a>.
Version: 0.6.2
Author: Christopher O'Connell
Author URI: http://compu.terlicio.us/
****************************************************
/*
 *	microAudio Wordpress Plugin
 *	(c) 2008-9 Christopher O'Connell
 *	Dual Licensed under the MIT and GPL licenses
 *  See license.txt, included with this package for more
 *
 *	microAudio.php
 *  Release 0.6.2, March 2009
 */
?>
<?php

$MICROAUDIO_VERSION = "0.6.2 Release 1";

// Hook to add scripts
add_action('admin_menu','ma_add_pages');
add_action('wp_head','ma_head');
add_action("plugins_loaded", "ma_init");

// See if we need to install/update
if (get_option('ma_version') != $MICROAUDIO_VERSION) ma_setup($MICROAUDIO_VERSION);

// PluginsLoaded Init
function ma_init() {
	if (get_option('ma_enable_widget') == 'true') {
		register_sidebar_widget('&micro;Audio', 'ma_widget');
		register_widget_control('&micro;Audio', 'ma_widget_control', 300, 200 );     
	}
}

// Add the script
function ma_add_pages() {
	// Add a new submenu under options
	add_options_page('&micro;Audio','&micro;Audio',6,'microaudio','ma_manage_page');
}

// Add the page header
function ma_head() {
	$ma_url = str_replace('http://','',get_option('siteurl'));
	if (get_option('ma_include_jquery') != 'false') {
		echo "<script type='text/javascript' src='http://$ma_url".htmlentities("/wp-content/plugins/microaudio/jquery-1.3.js.php?ver=1.3")."'></script>\n";
	}
	if (get_option('ma_autostart') == 'true') {
		$ma_auto = 'yes';
	} else {
		$ma_auto = 'no';
	}
	$ma_config = get_option('ma_autoconfig');
	$ma_download = get_option('ma_download');
	echo "<script type='text/javascript' src='http://$ma_url".htmlentities("/wp-content/plugins/microaudio/microAudio.js.php?siteurl=$ma_url&autostart=$ma_auto&autoconfig=$ma_config&download=$ma_download")."'></script>\n";
	if (get_option('ma_enable_widget') == 'true') {
		echo "<script type='text/javascript' src='http://$ma_url".htmlentities("/wp-content/plugins/microaudio/microAudio.widget.js.php?siteurl=$ma_url")."'></script>\n";
	}
}

// Create the widget
function ma_widget($args) {
  extract($args);
  echo $before_widget;
  echo $before_title; echo get_option('ma_widget_title'); echo $after_title;
  ma_widget_body();
  echo $after_widget;
}

// Widget body
function ma_widget_body() {
?><p id="microAudio-widget-container">
<embed src="<?php echo get_option('blogurl'); ?>/wp-content/plugins/microaudio/mediaplayer.swf"
id="microAudio-widget-player"
width="170"
height="150"
allowscriptaccess="always"
allowfullscreen="true"
flashvars="height=150&width=170&displaywidth=0&backcolor=0xDDDDDD&screencolor=0xDDDDDD&javascriptid=microAudio-widget-player&searchbar=false&showicons=false&usefullscreen=false&showdownload=true&autoscroll=true&thumbsinplaylist=false&enablejs=true"
/>
</p><?php
}

// Widget Control
function ma_widget_control() { 
	if (isset($_POST['ma_widget_options_updated'])) {
		if (wp_verify_nonce($_POST['ma_widget_options_nonce'],'ma-update_widget-options')) {
			if (isset($_POST['ma_widget_title'])) update_option('ma_widget_title',$_POST['ma_widget_title']);
		}
	}
?><p>
	<label for="ma_widget_title">
    	Title:
        <input type="text" name="ma_widget_title" id="ma_widget_title" value="<?php echo get_option('ma_widget_title'); ?>" />
	</label>
    <input type="hidden" name="ma_widget_options_updated" value="true" />
    <input type="hidden" name="ma_widget_options_nonce" value="<?php echo wp_create_nonce('ma-update_widget-options'); ?>" />
</p><?php 
}

// Management Page
function ma_manage_page() {
	include_once('microAudio.admin.php');
}

// 

// Setup Function
function ma_setup($MICROAUDIO_VERSION) {
	update_option('ma_version',$MICROAUDIO_VERSION);
//	update_option('ma_autostart','false');
//	update_option('ma_autoconfig','false');
	update_option('ma_enable_widget','false');
//	update_option('ma_widget_title','&micro;Audio');
	update_option('ma_include_jquery','true');
}
?>