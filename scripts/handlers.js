function init() {
    
    // utility method for all elements
    Element.addMethods({
        removeAllChildren: function (element) {
            element = $(element);
            if (element !== undefined && element !== null) {
                while (element.hasChildNodes()) {
                    element.removeChild(element.firstChild);
                }
            }
            return element;
        }
    });
    
    // now we set 'stress' to be empty on all the real syllables
    $$('span[real]').collect(function (node) {
        node.stress = ""
    });
    
    $("toggle-discrepancies").toggle();
}

function switchstress(shadowspan) {
    // called when a syllable's stress is changed
    realsyllable = $("prosody:real:" + shadowspan.id.substring(15));
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
            realsyllable.stress = '∪';
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
}

function checkstress(linenumber) {
    // called to submit an answer to the scansion-checking servlet, returns the
    // answer
    debug("Entering checkstress(" + linenumber + ")");
    // first we assemble the answer from the "stress" members of the appropriate
    // line
    
    var answer = $("prosody:real:" + linenumber).select("span[real]").pluck(
    "stress").collect(function (s) {
        return s.replace(/∪/, '-')
    }).join('');
    debug("past var answer");
    // now we check to see that this is a complete answer. if not, we alert and
    // return
    
    if (answer.length != $("prosody:real:" + linenumber).select("span[real]").length) {
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
                $("toggle-discrepancies").toggle();
            }
            // and here we update any hint buttons
            updatehintbutton(linenumber);
        }
    });
}

function switchfoot(coords) {
    syllabletext = $(coords).innerHTML;
    if (syllabletext.endsWith('|')) {
        $(coords).innerHTML = syllabletext
        .substring(0, syllabletext.length - 1);
    } else {
        $(coords).innerHTML = syllabletext + "|";
    }
}

function checkfeet(linenumber) {
    // called to submit an answer to the feet-checking servlet, returns the
    // answer
    
    // first we assemble the answer from the "stress" members of the appropriate
    // line
    var answer = $("prosody:real:" + linenumber).select("span[real]").pluck(
    "textContent").join('');
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
	var popup = window.open("meter-popup.html?line=" + linenumber
			+ "&linegroupindex=" + linegroupindex, "Check your meter, friend!",
			"resizable=no,scrollbars=no,status=no");

}

// returns an appropriate token element for use as a stress marker
function marker(real) {
    var mark = document.createElement("span");
    mark.setAttribute('class', 'prosody-marker');
    if (real.innerText) {
        if (real.innerText.length > 1) {
            spacer = " ".times(Math.floor(real.innerText.length / 2));
            if (real.innerText.length > 3) {
            	mark.appendChild(document.createTextNode(spacer + "/" + spacer));
            } else {
            	mark.appendChild(document.createTextNode("/" + spacer));
            }
        } else {
            mark.appendChild(document.createTextNode("/"));
        }
    } else {
        if (real.textContent.length > 3) {
            spacer = " ".times(Math.floor(real.textContent.length / 2));
            mark.appendChild(document.createTextNode(spacer + "/" + spacer));
        } else {
            mark.appendChild(document.createTextNode("/"));
        }
    }
    return mark;
}

// returns an appropriate token element for use as a slack marker
function slackmarker(real) {
    var mark = document.createElement("span");
    mark.setAttribute('class', 'prosody-marker');
    if (real.innerText) {
        if (real.innerText.length > 1) {
            spacer = " ".times(Math.floor(real.innerText.length / 2));
            if (real.innerText.length > 3) {
            	mark.appendChild(document.createTextNode(spacer + "∪" + spacer));
            } else {
            	mark.appendChild(document.createTextNode("∪" + spacer));
            }
        } else {
            mark.appendChild(document.createTextNode("∪"));
        }
    } else {
        if (real.textContent.length > 3) {
            spacer = " ".times(Math.floor(real.textContent.length / 2));
            mark.appendChild(document.createTextNode(spacer + "∪" + spacer));
        } else {
            mark.appendChild(document.createTextNode("∪"));
        }
    }
    return mark;
}

// returns an appropriate placeholder element for use as a blank marker
function placeholder(real) {
    var mark = document.createElement("span");
    mark.setAttribute('class', 'prosody-placeholder');
    if (real.innerText) {
        spacer = " ".times(Math.floor(real.innerText.length));
    } else {
        spacer = " ".times(Math.floor(real.textContent.length));
    }
    mark.appendChild(document.createTextNode(spacer));
    return mark;
}

// changes the visibility of the stress markers
function togglestress() {
    $$('.prosody-marker').invoke("toggle");
}





// this function highlights those syllables in which real="" and met=""
// scansions are different.
// it assumes that any syllable featuring a @real attribute will have also a
// @met attribute and that
// they are different.
function toggledifferences(e) {
    if (e.value == "off") {
        document.styleSheets[0].insertRule('span[discrepant] { color: red; }',
        0);
        e.value = "on";
    } else if (e.value == "on") {
        document.styleSheets[0].deleteRule(0);
        e.value = "off"
    }
}

function updatehintbutton(id) {
    debug("Entering updatehintbutton(" + id + ")");
    e = $("displaynotebutton" + id);
    debug("	e = " + $("displaynotebutton" + id));
    debug(" e.firstDescendant() = " + $(e).firstDescendant());
    if ($$("#checkstress" + id + " span[allowdis]").length > 0) {
        debug("	Passed test.");
        // if the stress button has an acceptable state
        //if ($$("#checkfeet" + id + " span[allowdis]").length > 0) {
        // and the feet button as well, then change visual state
        e.removeChild($(e).firstDescendant());
        e.appendChild(clickablehintimage());
        // and clickability
        e.setAttribute('onclick', "pophint(this)");
        //}
    }
}

function clickablehintimage() {
    debug("Entering clickablehintimage()");
    img = document.createElement("img");
    img.setAttribute('src', 'images/clickablehint.png');
    debug("img = ");
    debug(img);
    return img;
}

function pophint(e) {
    linenumber = e.id.substring(17);
    hintp = $("hintfor" + linenumber);
    pop = window.open("", "Hint for line " + linenumber, "menubar=no,height=100,width=200");
    pop.document.body.appendChild(pop.document.importNode(hintp, true));
}

function debug(s) {
    if (debugflag)
    console.log(s);
}