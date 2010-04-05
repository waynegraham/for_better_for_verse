/** 
 * $Id$
 */ 

var prosodyUtils = {
	removeAllChildren: function (element) {
        element = $(element);
        
        return element.update();
    },

    getInnerText: function(element) {
        element = $(element);
        return element.innerText && !window.opera ? element.innerText
            : element.innerHTML.stripScripts().unescapeHTML().replace(/[\n\r\s]+/g, ' ');
    },
	
	pullText: function (element) {
    	
        element = $(element);

        if (element !== undefined && element !== null) {
        	if (element.innerText) {
        		return element.innerText;
        	}
        	
			return element.textContent;
        }
		return '';       
    }
};

// symbols used;
var space = '\u00A0';
var cup = '\u222a';
var backslash = '';

Element.addMethods(prosodyUtils);

function init() {
    
    // now we set 'stress' to be empty on all the real syllables
    $$('span[real]').collect(function (node) {
        node.stress = "";
    });
    
    var poemheight = $("poem").getHeight();
    $('rhymebar').setStyle({height: poemheight + 20 + 'px'});
    $('rhyme').setStyle({height: poemheight + 20 + 'px'});
    
    var titledim=$('poemtitle').getDimensions();
    $('rhymespacer').setStyle({height: titledim.height + 44 + 'px'});
    
    $('rhymebar').observe('click', function(event){
        $('rhyme').toggle();
        //Effect.toggle('rhyme','appear',{duration: 0.5});
    });
    $('rhymeflag').observe('click', function(event){
        $('rhyme').toggle();
        //Effect.toggle('rhyme','appear',{duration: 0.5});
    });
    Event.observe('rhymeform','submit', function(event){
        var scheme = $('rhymeform').readAttribute('name').replace(/\s/g, "");
        var ans = '';
        $('rhymeform').getInputs('text').each(function(item) {
            ans += item.getValue();
        });
        checkrhyme(scheme, ans);
        Event.stop(event);
    });
}

function checkrhyme(scheme, answer){
    if(scheme == answer) {
        $('rhymecheck').addClassName('right');
        $('rhymecheck').removeClassName('wrong');
		$('rhymecheck').setValue('\u2713');
    } else {
        $('rhymecheck').addClassName('wrong');
        $('rhymecheck').removeClassName('right');
		$('rhymecheck').setValue('X');
    }
}

function switchstress(shadowspan) {
    // called when a syllable's stress is changed
    realsyllable = $("prosody-real-" + shadowspan.id.substring(15));
    if (realsyllable.stress == "-" || realsyllable.stress == "") {
        new Effect.Opacity($(shadowspan), {
            from: 0,
            to: 1,
            duration: 0.4
        });
        shadowspan.removeAllChildren();
        shadowspan.appendChild(marker(realsyllable));
        realsyllable.stress = '+';
    } else if (realsyllable.stress == "+") {
        new Effect.Opacity($(shadowspan), {
            from: 1,
            to: 0,
            duration: 0.4
        });
        setTimeout(function () {
            shadowspan.removeAllChildren();
            shadowspan.appendChild(slackmarker(realsyllable));
            realsyllable.stress = '\u222a';
        },
        150);
        new Effect.Opacity($(shadowspan), {
            from: 0,
            to: 1,
            duration: 0.4
        });
    } else {
        new Effect.Opacity($(shadowspan), {
            from: 1,
            to: 0,
            duration: 0.4
        });
        setTimeout(function () {
            shadowspan.removeAllChildren();
            shadowspan.appendChild(placeholder(realsyllable));
            realsyllable.stress = '-';
        },
        150);
    }
	var stressimg=$("checkstress" + shadowspan.id.substring(15,16)).firstDescendant().firstDescendant();
	alert(shadowspan.id.substr(15,2);
	if(stressimg && stressimg.readAttribute("src")!="images/stress-default.png"){
		stressimg.writeAttribute("src","images/stress-default.png");
	}
}

function checkstress(linenumber) {
    // called to submit an answer to the scansion-checking servlet, returns the
    // answer
    debug("Entering checkstress line (" + linenumber + ")");
    // first we assemble the answer from the "stress" members of the appropriate
    // line

    var answer = $("prosody-real-" + linenumber).select("[real]").pluck(
    "stress").collect(function (s) {
        return s.replace(/\u222a/, '-')
    }).join('');
    debug("Answer set to: " + answer);

    //var met = $('prosody:shadow:' + linenumber).select('[met]');
    //var met = $('prosody:met:' + linenumber).innerHTML;
    //var exp = $('prosody:expected:' + linenumber).innerHTML;

    // now we check to see that this is a complete answer. if not, we alert and
    // return
    
    if (answer.length != $("prosody-real-" + linenumber).select("[real]").length) {
        alert("An answer must be complete to be submitted. Please fill in a symbol over each syllable in this line.");
        return;
    }

    debug("past if(answer.length)");
    // now we use Prototype's Ajax Updater convenience type to update the
    // checking signal/control
    new Ajax.Updater({
        success: 'checkstress' + linenumber
    },
    'checkscansion', {
        parameters: {
            answer: answer,
            line: linenumber,
            poem: $('title').text
        },
        method: 'get',
        onComplete: function () {
            // here we update the visibility of the "Show Discrepancies
            // control"
            if ($$("button.prosody-checkstress span[allowdis]").length == $$("button.prosody-checkstress").length) {
                $("toggle-discrepancies").show();
            }
            // and here we update any hint buttons
            updatehintbutton(linenumber);
        }
    });
}

function switchfoot(coords) {
	debug("Switching foot on element: " );
	debug($(coords));
	debug("Which contains .select('span') of: ");
	debug($(coords).select("span"));

	Prototype.Browser.IE6 = Prototype.Browser.IE && parseInt(navigator.userAgent.substring(navigator.userAgent.indexOf("MSIE")+5)) == 6;
	Prototype.Browser.IE7 = Prototype.Browser.IE && parseInt(navigator.userAgent.substring(navigator.userAgent.indexOf("MSIE")+5)) == 7;
	
    if ($(coords).select("span").length > 0) {
        $(coords).select("span")[0].remove();
		if(Prototype.Browser.IE6 || Prototype.Browser.IE7) {
			var target_syll = "prosody-shadow" + $(coords).identify().gsub('prosody-real','');
			$(target_syll).select('em')[0].remove();
		}
    } else {
		if(Prototype.Browser.IE6 || Prototype.Browser.IE7) {
			var target_syll = "prosody-shadow" + $(coords).identify().gsub('prosody-real','');
			$(target_syll).firstDescendant().insert('<em>\u00A0</em>')
		}
        $(coords).insert("<span class='prosody-footmarker'>|</span>");;
    }

	var feetimg=$("checkfeet" + coords.substring(13,14)).firstDescendant().firstDescendant();
	if(feetimg && feetimg.readAttribute("src")!="images/feet-default.png"){
		feetimg.writeAttribute("src","images/feet-default.png");
	}
}

function checkfeet(linenumber) {
    // called to submit an answer to the feet-checking servlet, returns the
    // answer
    
    // first we assemble the answer from the "stress" members of the appropriate
    // line
    var answer = $("prosody-real-" + linenumber).select("span[real]").invoke(
    "pullText").join('');
    /* console.log(answer); */
    
    // now we use Prototype's Ajax Updater convenience type to update the
    // checking signal/control
    new Ajax.Updater({
        success: 'checkfeet' + linenumber
    },
    'checkfeet', {
        parameters: {
            answer: answer,
            line: linenumber,
            poem: $('title').text
        },
        method: 'get',
        onComplete: function () {
            // here we update any hint buttons
            updatehintbutton(linenumber);
        }
    });
}

function checkmeter(linenumber, linegroupindex) {
	// creates a popup window with popup menus to offer a choice of meters
	// the user is told whether the answer is correct or not

	debug("create window object");

	Prototype.Browser.IE6 = Prototype.Browser.IE && parseInt(navigator.userAgent.substring(navigator.userAgent.indexOf("MSIE")+5)) == 6;
	Prototype.Browser.IE7 = Prototype.Browser.IE && parseInt(navigator.userAgent.substring(navigator.userAgent.indexOf("MSIE")+5)) == 7;
	if(Prototype.Browser.IE6 || Prototype.Browser.IE7) {
		var popup = window.open("meter-popup-ie.html?line=" + linenumber + "&linegroupindex=" + linegroupindex, "", "resizable=no,scrollbars=no,status=no,width=300,height=200");
	} else {
		var pop_url = "meter-popup.html?line=" + linenumber	+ "&linegroupindex=" + linegroupindex;
		var win = new Window({className: "mac_os_x", url:pop_url, width:300, height:200, zIndex: 100, resizable:true, title:"Meter", draggable:true, wiredDrag:true, effectOptions:{duration:0.2}});
		win.showCenter();
	}
}

function grabText(real){

    if(real.innerText){
        return real.innerText;
    }
    return real.textContent;
}

/**
 *
 */
function addMarker(real, symbol){
   var mark = new Element('span', {'class' : 'prosody-marker'});

   // get the text node from the real
   var text = grabText(real);
   
   var tLen = text.length; // text length
   var tMid = Math.floor(tLen / 2);

   var tMod = tLen % 2;
   spacer = "\u00A0".times(Math.floor(text.length / 2));

	//TODO: Explain logic

   if (tMod === 0) {
       lspacer = "\u00A0".times(Math.floor((text.length / 2) - 1));
       mark.update(lspacer + symbol + lspacer + "\u00A0");
   } else {

       mark.update(spacer + symbol + spacer);
   }
   return mark;
}

// returns an appropriate token element for use as a stress markehttp://localhost:8080/prosody/exercise.jsp?poem=test2.xmlr
function marker(real) {
    return addMarker(real, "/");
}

// returns an appropriate token element for use as a slack marker
function slackmarker(real) {
	Prototype.Browser.IE6 = Prototype.Browser.IE && parseInt(navigator.userAgent.substring(navigator.userAgent.indexOf("MSIE")+5)) == 6;
	Prototype.Browser.IE7 = Prototype.Browser.IE && parseInt(navigator.userAgent.substring(navigator.userAgent.indexOf("MSIE")+5)) == 7;
	if(Prototype.Browser.IE6 || Prototype.Browser.IE7) {
		return addMarker(real, "-");	
	} else {
		return addMarker(real, "\u222A");	
	}
}

//returns an appropriate placeholder element for use as a blank marker
function footmarker() {
	
	//var mark = new Element('a', {'class': 'prosody-footmarker'}).update('|');
	//return mark;
    var mark = document.createElement("span");
    mark.setAttribute('class', 'prosody-footmarker');
    mark.appendChild(document.createTextNode('|'));
    debug("Created footmarker " + mark);
    return mark;
    
}

// returns an appropriate placeholder element for use as a blank marker
function placeholder(real) {  
    return addMarker(real, " ");
}

// changes the visibility of the stress markers
function togglestress() {
    //if marks visible (value isn't null), hide marks, if marks hidden, show marks
    $$('.prosody-marker').each(function(el){
        if($('togglestress').getValue()) {
            el.show();
        } else {
            el.hide();
        }
    });
}

function togglefeet() {
    $$('.prosody-footmarker').each(function(el){
        if($('togglefeet').getValue()) {
            el.show();
        } else {
            el.hide();
        }
    });
}

function togglecaesura() {
    $$('.caesura').each(function(el){
        if($('togglecaesura').getValue()) {
            el.show();
        } else {
            el.hide();
        }
    });
}

// this function highlights those syllables in which real="" and met=""
// scansions are different.
// it assumes that any syllable featuring a @real attribute will have also a
// @met attribute and that
// they are different.
function toggledifferences(e) {
    if (e.value == "off") {
        //document.styleSheets[0].insertRule('span[discrepant] { color: #F0F055; }', 0);
		$$("span[discrepant]").invoke('addClassName', 'discrep');
        e.value = "on";
    } else if (e.value == "on") {
        //document.styleSheets[0].deleteRule(0);
		$$("span[discrepant]").invoke('removeClassName', 'discrep');
        e.value = "off"
    }
}

function updatehintbutton(id) {
    debug("Entering updatehintbutton(" + id + ")");
    e = $("displaynotebutton" + id);
    debug("	e = " + e);
    if($(e).firstDescendant()){
        debug(" e.firstDescendant() = " + $(e).firstDescendant());
    }
    if ($$("#checkstress" + id + " span[allowdis]").length > 0) {
        debug("	Passed test.");
        // if the stress button has an acceptable state
        //if ($$("#checkfeet" + id + " span[allowdis]").length > 0) {
        // and the feet button as well, then change visual state
        e.removeChild($(e).firstDescendant());
        e.appendChild(clickablehintimage());
        e.setAttribute('onclick', 'pophint("'+id+'");');
        // and clickability
		
		/*Event.observe(e, 'click', function(){
			debug("popping win1");
			var win = new Window({className: "mac_os_x", width:400, height:300, zIndex: 100, resizable: true, title: "Note on line " + id, draggable:true, wiredDrag: true});
			win.showCenter();
			win.setContent('hintfor' + id, 'prosody-note-show');
		}); */

       /** if (e.addEventListener) 
			e.addEventListener('click',pophint,false); //everything else    
		else if (e.attachEvent)
    		e.attachEvent('onclick',pophint);  //IE only
*/
        //e.setAttribute('onclick', "pophint(this)");
        //debug("	e.onclick = " + e.onclick);
        //}
    }
}

function pophint(id){
    debug("popping win1");
    Windows.closeAll();
	var win = new Window({className: "mac_os_x", width:400, height:300, zIndex: 100, resizable: true, title: "Note on line " + id, draggable:true, wiredDrag: true});
	win.showCenter();
    win.setContent('hintfor' + id, 'prosody-note-show');
}

function clickablehintimage() {
    debug("Entering clickablehintimage()");
    //var img = new Element('img', {'src': 'images/unclickablehint.png'}).update();
	img = document.createElement("img");
    img.setAttribute('src', 'images/unclickablehint.png');
    debug("img = ");
    debug(img);
    return img;
}
/*
function pophint(e) {
	debug("Entering pophint()");
	
	debug("E: " + Event.element(e).identify());
	
	// more IE crap
	if (e.target) {// stupid IE
		linenumber = e.target.id.substring(17);
	}
	else if (e.srcElement) {// normal browsers
    	linenumber = e.srcElement.id.substring(17);
		debug('getting the line for other');
	}
    //hintp = $("hintfor" + linenumber).className = 'note';
	debug('line number ' + linenumber);
	

	debug("create window object");
	debug("popping win2");
	var win = new Window({className: "mac_os_x", width:400, height:300, zIndex:100, resizable:true, title:"Note on line " + linenumber, draggable:true, wiredDrag:true, effectOptions:{duration:0.2}});
	
	win.setContent('hintfor' + linenumber, 'prosody-note-show');
	win.showCenter();

    //pop = window.open("", "Hint for line " + linenumber,"menubar=no,scrollbars=yes,height=300,width=400");
	//pop=window.open("popupbodyforie.html","Hint" + linenumber,"menubar=no,scrollbars=yes,height=300,width=400");
	//debug(pop.document);
	//debug("Popup opened");
   // pop.document.body.setAttribute("style", "background:#222;color:#fff;font-size:14px;font-family:arial;");
	//if (pop.document.body.importNode) // DOM Level 2 capable browsers
	//	setTimeout("pop.document.body.appendChild(pop.document.importNode(hintp, true))",500);
	//else // more MS crap
	//	debug("hintp nodetype = " + hintp.nodetype);
	//	setTimeout(function() { pop.document.body.appendChild(hintp) },500);
} */

function debug(s) {
    if (debugflag){
        console.log(s);
    }
}
