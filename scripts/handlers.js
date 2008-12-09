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

function switchstress(coords) {
	// called when a syllable's stress is changed
	shadowspan = $("prosody:shadow:" + coords.substring(13));
	if ($(coords).stress != "+") {
		shadowspan.removeAllChildren();
		shadowspan.appendChild(marker());
		$(coords).stress = '+';

	} else {
		shadowspan.removeAllChildren();
		shadowspan.appendChild(placeholder(coords));
		$(coords).stress = '-';
	}
}

function checkstress(linenumber) {
	// called to submit an answer to the checking servlet, returns the answer

	// first we assemble the answer from the "stress" member of the appropriate
	// line
	var answer = $("prosody:real:" + linenumber).select("span[real]").pluck(
			"stress").join('');

	// now we use Prototype's Ajax Updater convenience type to update the
	// checking signal
	new Ajax.Updater( {
		success :'checkstress' + linenumber
	}, 'check', {
		parameters : {
			answer: answer,
			line :linenumber,
			poem :$('title').text
		} , method: 'get'
	}

	);

}

// returns an appropriate token element for use as a stress marker
function marker() {
	mark = document.createElement("span");
	mark.setAttribute('class', 'prosody-marker');
	mark.appendChild(document.createTextNode("/"));
	return mark;
}

// returns an appropriate placeholder element for use as a slack marker
function placeholder(coords) {
	place = document.createElement("span");
	place.setAttribute('class', 'prosody-placeholder');
	place.innerHTML = document.getElementById(coords).innerHTML;
	return place;
}
