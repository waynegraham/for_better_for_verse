=== µAudio Player ===
Contributors: jwriteclub
Donate link: http://compu.terlicio.us/
Tags: mp3, flash player, jQuery, audio
Requires at least: 2.0
Tested up to: 2.7.1
Stable tag: 0.6.2

µAudio is a slim and basic plugin (Only 450 Bytes!). It does one thing: capture mp3 links and insert a small flash player on click.

== Description ==

µAudio is a slim (450 Bytes!), fast plugin to create a flash mp3 player when mp3 links are clicked. In order to reduce clutter and file transfer, the links are unmodified until they are clicked, at which point a div with the player is faded in after the link. A second click on the link fades the player back out.

µAudio also contains an 'autoconfig' feature which automatically examines the site CSS and attempts to pick colors for the various flash player elements based on the CSS values. This may not provide a "good" look in every situation, but should integrate well with most themes. In order to provide more fine grained control, you can also write custom css to specifically skin any aspect of the player which the autoconfig does not skin to your satisfaction.

In order to help keep file loads down, the basic javascript is extremely small*. In addition, every effort has been made to use the smallest player possible and generally keep the plugin as small and light as possible.

*µAudio does rely upon jQuery, however, the packed jQuery is quite lite, and many other plugins use it as well, making the total burden quite small. All data sizes assume that a jQuery has already been loaded.

== Installation ==

The most basic installation is a simple two step:

1. Upload the `microaudio` folder to the `/wp-content/plugins/` directory
1. Activate the plugin through the 'Plugins' menu in WordPress

That's it, you're done. You have an audio player smaller than 1/2 of a kilobyte.

In order to activate autoconfiguration and autostart for the player:

1. Goto "Settings > µAudio"
1. Activate the options as appropriate.

One requested feature is a way for people to download the file in addition to seeing the flash player. To that end, there is now an option to add a download link.

In addition, the skinning capabilities have been extended. You can now fine tune every aspect of the player through the use of custom css classes which you can add to your style.css. To that end see microAudio.example.css for a full list of classes. Any classes not overridden will retain their default colors.

To change the player width look at the **.mAp, .adplr** classes in the css file.

Older versions required a change to **k2.rollingarchives.js** if &micro;Audio was used with k2. This is no longer an issue. If upgrading from a previous &micro;Audio, **k2.rollingarchives.js** should be restored to its default.

== Frequently Asked Questions ==

= Do I need to do anything special in my posts? =

No, µAudio automatically converts any link to an mp3 file so that it can automatically create a player. So, if you put in &lt;a href="somefile.mp3"&gt;A Link&lt;/a&gt; &micro;Audio will automatically add a flash player when that link is clicked.

= Why doesn't it immediately load the player? =

It waits for the user to click on the link for several reasons:

1. It saves bandwidth not to load a bunch of (potentially needless) flash players.
1. If the link is in the middle of a paragraph, it might look odd for the player to be sitting in the text.
1. It just makes sense that the player appears when the user indicates a desire to listen by clicking on the link

= Why is my installation larger than 450 Bytes? =

Since the javascript is dynamically rewritten, it can grow in size depending on what options you have enabled and certain environment variables. 450 B represents the smallest possible installation, my own site is 452 Bytes.

== Screenshots ==

1.  The expanded player. In auto-color mode. With the Sidebar Widget. "The Whole Nine Yards".
1.  The collapsed player. In default colors.
1.  The expanded advanced player player. In auto color mode, with a "download link" enabled.
1.  An unadulterated link to an mp3 file. Nothing to see here, move along.
1.  Firebug results for loading microAudio.js. 446 Bytes. Oh Yeah! (Your Mileage May Vary).

== Notes ==

*   µAudio uses the super slim mp3 player from [1 Pixel Out](http://www.1pixelout.net/code/audio-player-wordpress-plugin/ "Crazy Cool"). This nifty little player clocks in at just 5 KB, smaller than many JavaScripts. Indeed, the total change to your pages (when no player is loaded) is about 450 Bytes. Even with a player loaded the entire system is under 6 KB. If bandwidth is expensive (and let's be honest, when isn't it?) µAudio is about the smallest you can get and still run.
*   Currently uses jQuery 1.3, the most recent version as of the release date. Any jQuery 1.3 should work. jQuery pre 1.3 will not work. To that end, jQuery is running in agressive no conflict mode and does not expose the global jQuery or $ objects. To use &micro;Audio's version of jQuery elsewhere add `var jQuery = mAjQ; to the top of your code. In the event that you already load jQuery _1.3_+, then you can uncheck the _jQuery_ checkbox in 'Settings > µAudio'. In this case you will need to add `var mAjQ = jQuery` to the top of microAudio.js.php.


== Known Issues ==

*    Please post any questions or bugs on the [Version Installation Page](http://compu.terlicio.us/code/plugins/audio/micro-audio-installation/). Feature requests and comments of a more general nature should go on the [µAudio Home Page] (http://compu.terlicio.us/code/plugins/audio/).
*    The widget is having some issues. There is a completly new widget in the works for 0.7, that does not use the jw player, so if you really want the widget, visit [Compu.terlicio.us Contact](http://compu.terlicio.us/about-contact/) and I'll send you a development version.

== Changelog ==

*0.6.2*
*    Fixed the fact that some hosts reject query strings containing http://.
*    Added player sizing documentation.

*0.6.1*
*    Properly escape header links, passes W3C Validation.
*    Fixed improperly spelled css attributes (see microAudio.example.css).

*0.6*
*    Slimmed down the default installation to less than 450 Bytes (from 446 Bytes).
*    Removed all browser dependant code.
*    Updated the autoconfiguration for greater accuracy
*    Added mamnual configuration using css. See microAudio.example.css to see what classes are required in your style.css
*    Update jQuery to 1.3
*    Update 1PixelOut to 2.0 Beta 6
*    Fixed bugs in Internet Explorer 7 and Opera
*    Fixed all known environment conflict bugs. Should run with almost any other javascript on the page.
*    Massivly increased flash embedding speed, and use a simple two state system instead of the more complex four state system.
*    Added the option to provide for static download links in addition to player insertion.

*0.5*
*    Slimmed down the default installation to less than 500 Bytes (from 495 Bytes)
*    Removed browser dependant code from the basic installation (the widget still uses IE detection)
*    Update the autoconfiguration for greater accuracy
*    Update jQuery to 1.2.6
*    Fixed the bugs plaguing Firefox 3 and Safari

*0.4*
*    Not Released
*    An attempt to use a different javascript loading routine
*    The less said the better!

*0.3*
*    Completly re-wrote the flash injection routines. They now work under *all* common browsers.
*    Finished the autoconfiguration feature.
*    Moved the options screen to "Settings > µAudio"

*0.2.2*
*    Fixed the problem with the **jquery.flash** extension sometimes failing to show up as javascript.

*0.2.1*
*    Fixed the problem with the way the embed was created through use of the **jquery.flash** extension.
*    Updated a stupid mistake which caused jquery to load last, leading to all sorts of problem.

*0.2*
*    Updated the JavaScript to run without needing to call **prepare_player()** even on pages with dynamic reload of links (such as k2's rolling archives.
*    Updated jQuery to 1.2.3
*    Removed the now superfluous **k2.rollingarchives.js** from the package.

*0.1.0.1*
*    Fixed error in folder case (WordPress extend converts all folder names to lower case).