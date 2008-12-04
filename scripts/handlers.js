function highlight(e){
	e.style.setProperty('color', '#00ff00', '');
}

function unhighlight(e){
	e.style.setProperty('color', "'#000000", '');
}

function stress(coords) {
	if (document.getElementById("shadow" + coords.substring(4)).innerHTML == '') {
		document.getElementById("shadow" + coords.substring(4)).innerHTML = "✔";
	}
	else {
		document.getElementById("shadow" + coords.substring(4)).innerHTML = "";
	}
}