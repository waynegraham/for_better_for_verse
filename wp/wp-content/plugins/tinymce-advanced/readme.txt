=== TinyMCE Advanced ===
Contributors: Andrew Ozz
Donate link: 
Tags: wysiwyg, formatting, tinymce, write, edit, post
Requires at least: 2.8
Tested up to: 2.8
Stable tag: 3.2.4

Enables most of the advanced features of TinyMCE, the WordPress WYSIWYG editor. 

== Description ==

This plugin adds 15 plugins to [TinyMCE](http://tinymce.moxiecode.com/): Advanced hr, Advanced Image, Advanced Link, Context Menu, Emotions (Smilies), Date and Time, IESpell, Layer, Nonbreaking, Print, Search and Replace, Style, Table, Visual Characters and XHTML Extras. 

Version 2.0 includes an admin page for arranging the TinyMCE toolbar buttons, easy installation, a lot of bugfixes, customized "Smilies" plugin that uses the built-in WordPress smilies, etc. The admin page uses jQuery and jQuery UI that lets you "drag and drop" the TinyMCE buttons to arrange your own toolbars and enables/disables the corresponding plugins depending on the used buttons.

Version 2.1: Improved language selection, improved compatibility with WordPress 2.3 and TinyMCE 2.1.1.1, option to override some of the imported css classes and other small improvements and bugfixes.

Version 2.2: Deactivate/Uninstall option page, font size drop-down menu and other small changes.

Version 3.0: Support for WordPress 2.5 and TinyMCE 3.0.

Version 3.0.1: Compatibility with WordPress 2.5.1 and TinyMCE 3.0.7, added option to disable the removal of P and BR tags when saving and in the HTML editor (autop), added two more buttons to the HTML editor: autop and undo, fixed the removal of non-default TinyMCE buttons.

Version 3.1: Compatibility with WordPress 2.6 and TinyMCE 3.1, keeps empty paragrarhs when disabling the removal of P and BR tags, the buttons for MCImageManager and MCFileManager can be arranged (if installed).

Version 3.2: Compatibility with WordPress 2.7 and TinyMCE 3.2, minor bug fixes.

Version 3.2.4: Compatibility with WordPress 2.8 and TinyMCE 3.2.4, minor bug fixes.

**Language Support:** The plugin interface in only in English, but the TinyMCE plugins include several translations: German, French, Italian, Spanish, Portuguese, Russian, Chinese and Japanese. More translations are available at the [TinyMCE web site](http://tinymce.moxiecode.com/download_i18n.php).


= Some of the features added by this plugin =

* Imports all CSS classes from the main theme stylesheet and add them to a drop-down list.
* Support for making and editing tables.
* In-line css styles.
* Advanced link and image dialogs that offer a lot of options.
* Search and Replace while editing.
* Support for XHTML specific tags and for (div based) layers.


== Installation ==

1. Download.
2. Unzip.
3. Upload to the plugins directory (wp-content/plugins).
4. Activate the plugin.
5. Set your preferences at "Manage - TinyMCE Advanced".
6. Clear your browser cache.


= Upgrading from TinyMCE Advanced 2.x  =

1. Deactivate the previous version.
2. Delete the "tinymce-advanced" folder from the WordPress plugins directory.
3. Follow the above steps to install the new version.


== Frequently Asked Questions ==

= No styles are imported in the Styles drop-down menu. =

These styles (just the classes) are imported from your current theme style.css file. However some themes use @import to load the actual css file(s). Tiny does not follow these links. To make the classes appear, add their names to tadv-mce.css file located in "tinymce-advanced/css". You do not need to copy the whole classes, just add the names, like that:

    .my-class{}
    .my-other-class{}

= I have just installed this plugin, but it does not do anything. =

Log out of WordPress, clear your browser cache, quit and restart the browser and try again. If that does not work, there may be a caching proxy or network cache somewhere between you and your host. You may need to wait for a few hours until this cache expires.

= When I add "Smilies", they do not show in the editor. =

The "Emotions" button in TinyMCE adds the codes for the smilies. The actual images are added by WordPress when viewing the Post/Page. Make sure the checkbox "Convert emoticons to graphics on display" in "Options - Writing" is checked.

= The plugin does not add any buttons. =

Make sure the "Use the visual editor when writing" checkbox under "Users - Your Profile" is checked.

= Other questions? More screenshots? =

Please visit the homepage for [TinyMCE Advanced](http://www.laptoptips.ca/projects/tinymce-advanced/). 


== Screenshots ==

1. The TinyMCE Advanced options page
