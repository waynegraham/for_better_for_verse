<?php
/*
 *	microAudio Wordpress Plugin
 *	(c) 2008-9 Christopher O'Connell
 *	Dual Licensed under the MIT and GPL licenses
 *  See license.txt, included with this package for more
 *
 *	microAudio.admin.php
 *  Release 0.6.2, March 2009
 */
// MicroAudio Admin Page

// Business Logic
if (isset($_POST['action'])) {
	if (!isset($_POST['_wpnonce'])) die("There was a problem authenticating. Please log out and log back in");
	if (!check_admin_referer('ma-update_options')) die("There was a problem authenticating. Please log out and log back in");
	if ($_POST['action'] == 'update') {
		if (isset($_POST['ma_include_jquery'])) {
			update_option('ma_include_jquery','true');
		} else {
			update_option('ma_include_jquery','false');
		}
		if (isset($_POST['ma_autostart'])) {
			update_option('ma_autostart','true');
		} else {
			update_option('ma_autostart','false');
		}
		update_option('ma_autoconfig',$_POST['ma_autoconfig']);
		if (isset($_POST['ma_download'])) {
			update_option('ma_download','true');
		} else {
			update_option('ma_download','false');
		}
		if (isset($_POST['ma_enable_widget'])) {
			update_option('ma_enable_widget','true');
		} else {
			update_option('ma_enable_widget','false');
		}			
		?><div class="updated"><p><strong>Options Updated</strong></p></div><?php
	}
}


?>
<div class="wrap">
	<h2>&micro;Audio Management Page</h2>
    <p>In most cases the way it's configured out of the box is just about right, but feel free to play with it.</p>
    <p>&micro;Audio Version: <em><?php echo get_option('ma_version'); ?></em></p>
    <form id="ma_options" name="ma_options" action="<?php echo str_replace( '%7E', '~', $_SERVER['REQUEST_URI']); ?>" method="post">
    <table class="form-table">
    	<tbody>
        	<tr valign="top">
            	<th scope="row">jQuery</th>
                <td>
                	<input type="checkbox" name="ma_include_jquery" id="ma_include_jquery" <?php if (get_option('ma_include_jquery') == 'true') echo "checked"; ?> />
                    <label for="ma_include_jquery">Include jQuery on the display pages</label>
                    <br />
                    <span call="explanatory-text">From 0.6 &micro;Audio requires jQuery 1.3+. DO NOT uncheck this unless you are 100% sure that you have jQuery 1.3 loaded.</span>
                </td>
            </tr>
            <tr valign="top">
            	<th scope="row">Autostart</th>
                <td>
                	<input type="checkbox" name="ma_autostart" id="ma_autostart" <?php if (get_option('ma_autostart') == 'true') echo "checked"; ?> />
                    <label for="ma_autostart">Autostart the player</label>
                    <br />
                    <span call="explanatory-text">Causes the player to start playin immediately on load if enabled.</span>                	
                </td>
            </tr>
            <tr valign="top">
            	<th scope="row">Widget</th>
                <td>
                	<input type="checkbox" name="ma_enable_widget" id="ma_enable_widget" <?php if (get_option('ma_enable_widget') == 'true') echo "checked"; ?> />
                    <label for="ma_enable_widget">Enable Sidebar Widget</label>
                    <br />
                    <span class="explanatory-text">NOTE: Increases the javascript size</span>
                </td>
            </tr>
            <tr valign="top">
            	<th scope="row">Configuration</th>
                <td>
                	<input type="radio" name="ma_autoconfig" id="ma_autoconfig_none" value="false" <?php if (get_option('ma_autoconfig') == 'false') echo "checked";?> />
                    <label for="ma_autoconfig">Player wears it's default skin</label>
					<br />
                	<input type="radio" name="ma_autoconfig" id="ma_autoconfig_true" value="true" <?php if (get_option('ma_autoconfig') == 'true') echo "checked";?> />
                    <label for="ma_autoconfig">Player configures based on the css already present on the page</label>
					<br />
                	<input type="radio" name="ma_autoconfig" id="ma_autoconfig_magic" value="magic" <?php if (get_option('ma_autoconfig') == 'magic') echo "checked";?> />
                    <label for="ma_autoconfig">Player expects css propertied as outlined in microAudio.example.css</label>
                    <br />
                    <span call="explanatory-text">How to color the player. If the last option is used, then you <em><b>must</b></em> have the css classes in microAudio.example.css somewhere in your css. NOTE: "default skin" produces the smallest and fastest javascript.</span>                	
                </td>
            </tr>
            <tr valign="top">
            	<th scope="row">Download Link</th>
                <td>
                	<input type="checkbox" name="ma_download" id="ma_download" <?php if (get_option('ma_download') == 'true') echo "checked"; ?> />
                    <label for="ma_autostart">Include a static download link</label>
                    <br />
                    <span call="explanatory-text">Whether to include a link next to the flash player to download the file. Marginally increases the javascript size.</span>                	
                </td>
            </tr>  
        </tbody>
    </table>
    <p class="submit">
    	<input type="hidden" name="action" value="update" />
        <?php wp_nonce_field('ma-update_options'); ?>
    	<input type="submit" name="Submit" value="Configureate >" class="button" />
    </p>
    </form>
</div>
<?php
?>