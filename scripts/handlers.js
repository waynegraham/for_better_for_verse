function init() {

	// utility method for all elements
	Element.addMethods( {
		removeAllChildren : function(element) {
			element = $(element);
			if (element !== undefined && element !== null) {
				while (element.hasChildNodes()) {
					element.removeChild(element.firstChild);
				}
			}
			return element;
		}
	});

	// now we set 'stress' to be slack on all the real syllables
	$$('span[real]').collect( function(node) {
		node.stress = "-"
	});
}

function switchstress(shadowspan) {
	// called when a syllable's stress is changed
	realsyllable = $( "prosody:real:" + shadowspan.id.substring(15) );
	if (realsyllable.stress == "-") {
		new Effect.Opacity($(shadowspan), { from: 0, to: 1, duration: 0.4 });
		shadowspan.removeAllChildren();
		shadowspan.appendChild(marker(realsyllable));
		realsyllable.stress = '+';

	} else if (realsyllable.stress == "+") {
		new Effect.Opacity($(shadowspan), { from: 1, to: 0, duration: 0.4 });
		setTimeout(function() {
			shadowspan.removeAllChildren();
			shadowspan.appendChild(slackmarker(realsyllable));
			realsyllable.stress = '∪';}, 150);
		new Effect.Opacity($(shadowspan), { from: 0, to: 1, duration: 0.4 });
	}
	else {
		new Effect.Opacity($(shadowspan), { from: 1, to: 0, duration: 0.4 });
		setTimeout(function() {
		shadowspan.removeAllChildren();
		shadowspan.appendChild(placeholder());
		realsyllable.stress = '-';}, 150);
	}
}

function checkstress(linenumber) {
	// called to submit an answer to the scansion-checking servlet, returns the answer

	// first we assemble the answer from the "stress" members of the appropriate
	// line
	var answer = $("prosody:real:" + linenumber).select("span[real]").pluck(
			"stress").collect(function(s){return s.replace(/∪/,'-')}).join('');

	// now we use Prototype's Ajax Updater convenience type to update the
	// checking signal/control
	new Ajax.Updater( {
		success :'checkstress' + linenumber
	}, 'checkscansion', {
		parameters : {
			answer: answer,
			line :linenumber,
			poem :$('title').text
		} , method: 'get'
	}

	);

}

function switchfoot(coords){
	syllabletext = $(coords).innerHTML;
	if ( syllabletext.endsWith('|') ) {
		$(coords).innerHTML = syllabletext.substring(0,syllabletext.length-1);
	}
	else {
		$(coords).innerHTML = syllabletext + "|";
	}
	
}

function checkfeet(linenumber) {
	// called to submit an answer to the feet-checking servlet, returns the answer

	// first we assemble the answer from the "stress" members of the appropriate
	// line
	var answer = $("prosody:real:" + linenumber).select("span[real]").pluck("textContent").join('');
	/*console.log(answer); */
	
	// now we use Prototype's Ajax Updater convenience type to update the
	// checking signal/control
	new Ajax.Updater( {
		success :'checkfeet' + linenumber
	}, 'checkfeet', {
		parameters : {
			answer: answer,
			line :linenumber,
			poem :$('title').text
		} , method: 'get'
	}

	);

}

// returns an appropriate token element for use as a stress marker
function marker(real) {	
	mark = document.createElement("span");
	mark.setAttribute('class', 'prosody-marker');
	spacer = " ".times(Math.floor(real.textContent.length / 2 ));
	mark.appendChild(document.createTextNode(spacer + "/" + spacer))	
	return mark;
}

//returns an appropriate token element for use as a slack marker
function slackmarker(real) {	
	mark = document.createElement("span");
	mark.setAttribute('class', 'prosody-marker');
	if(real.textContent.length > 2){
	spacer = " ".times(Math.floor(real.textContent.length / 2 ));
	mark.appendChild(document.createTextNode(spacer + "∪" + spacer))
	} else {
	mark.appendChild(document.createTextNode("∪"))	
	}
	return mark;
}

// returns an appropriate placeholder element for use as a blank marker
function placeholder() {
	place = document.createElement("span");
	place.setAttribute('class', 'prosody-placeholder');
	return place;
}

function togglestress() {
	var toggle = document.getElementById('togglestress');
	if(toggle.hasClassName('on')) {
		toggle.removeClassName('on');
		toggle.addClassName('off');
		/*$$('.prosody-marker').each*/
	}
}