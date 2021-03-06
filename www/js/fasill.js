var program;
var lattice;
var sim;
var goal;
var tests;
var limit;
var output;
var derivation;
var substitution;

window.addEventListener("load", function() {
	var program_value = document.getElementById("program").innerHTML.replace(/&lt;/g,"<").replace(/&gt;/g,">");
	document.getElementById("program").innerHTML = "";
	program = CodeMirror(document.getElementById("program"), {
		value: program_value,
		lineNumbers: true,
		theme: "fasill",
		placeholder: "Your program here...",
		mode: "prolog"
	});
	var lattice_value = document.getElementById("lattice").innerHTML.replace(/&lt;/g,"<").replace(/&gt;/g,">");
	document.getElementById("lattice").innerHTML = "";
	lattice = CodeMirror(document.getElementById("lattice"), {
		value: lattice_value,
		lineNumbers: true,
		theme: "fasill",
		placeholder: "Your lattice here...",
		mode: "prolog"
	});
	var sim_value = document.getElementById("sim").innerHTML.replace(/&lt;/g,"<").replace(/&gt;/g,">");
	document.getElementById("sim").innerHTML = "";
	sim = CodeMirror(document.getElementById("sim"), {
		value: sim_value,
		lineNumbers: true,
		theme: "fasill",
		placeholder: "Your similarity equations here...",
		mode: "prolog"
	});
	var goal_value = document.getElementById("goal").innerHTML.replace(/&lt;/g,"<").replace(/&gt;/g,">");
	document.getElementById("goal").innerHTML = "";
	goal = CodeMirror(document.getElementById("goal"), {
		value: goal_value,
		lineNumbers: false,
		theme: "fasill",
		placeholder: "Type a FASILL goal in here",
		mode: "prolog"
	});
	var limit_value = document.getElementById("limit").innerHTML.replace(/&lt;/g,"<").replace(/&gt;/g,">");
	document.getElementById("limit").innerHTML = "";
	limit = CodeMirror(document.getElementById("limit"), {
		value: limit_value,
		lineNumbers: false,
		theme: "fasill",
		placeholder: "Max. number of inferences",
		mode: "prolog"
	});
	output = CodeMirror(document.getElementById("out"), {
		lineNumbers: true,
		theme: "fasill",
		mode: "prolog",
		readOnly: true
	});
	derivation = CodeMirror(document.getElementById("derivation"), {
		lineNumbers: true,
		theme: "fasill",
		mode: "prolog",
		readOnly: true
	});
	program.setSize("100%", "100%");
	lattice.setSize("100%", "100%");
	sim.setSize("100%", "100%");
	goal.setSize("100%", "100%");
	limit.setSize("100%", "100%");
	output.setSize("100%", "100%");
	derivation.setSize("100%", "100%");
});

function load_lattice( from ) {
	post( from, "", function(data) {
		lattice.setValue(data);
	});
}

function post( url, data, callback ) {
	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			callback(this.responseText);
		}
	};
	xhttp.open("POST", url, true);
	xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	xhttp.send(data);
}

function cancel(e) {
	var lst = document.getElementById("listing");
	if(lst)
		lst.innerHTML = "";
}

function addClassName( elem, name ) {
	var arr = elem.className.split(" ");
	if( arr.indexOf(name) == -1 )
		elem.className += " " + name;
}

function removeClassName( elem, name ) {
	elem.className = elem.className.replace(name, "");
} 

function show_running() {
	var t = document.getElementById("button-show-tuning");
	var r = document.getElementById("button-show-run");
	addClassName(t, "btn-secondary"); removeClassName(t, "btn-primary");
	addClassName(r, "btn-primary"); removeClassName(r, "btn-secondary");
	document.getElementById("collapse-tuning").style.display = "none";
	document.getElementById("collapse-run").style.display = "block";
	document.getElementById("output-tuning").style.display = "none";
	document.getElementById("output-run").style.display = "block";
}

function show_tuning() {
	var t = document.getElementById("button-show-tuning");
	var r = document.getElementById("button-show-run");
	addClassName(r, "btn-secondary"); removeClassName(r, "btn-primary");
	addClassName(t, "btn-primary"); removeClassName(t, "btn-secondary");
	document.getElementById("collapse-run").style.display = "none";
	document.getElementById("collapse-tuning").style.display = "block";
	document.getElementById("output-run").style.display = "none";
	document.getElementById("output-tuning").style.display = "block";
	if(!tests) {
		var tests_value = document.getElementById("tests").innerHTML.replace(/&lt;/g,"<").replace(/&gt;/g,">");
		document.getElementById("tests").innerHTML = "";
		tests = CodeMirror(document.getElementById("tests"), {
			value: tests_value,
			lineNumbers: true,
			theme: "fasill",
			placeholder: "Your test cases here...",
			mode: "prolog"
		});
		tests.setSize("100%", "100%");
		substitution = CodeMirror(document.getElementById("symbolic-substitution"), {
			lineNumbers: true,
			theme: "fasill",
			mode: "prolog",
			readOnly: true
		});
		substitution.setSize("100%", "100%");
	}
}

function fasill_run() {
	var data = jQuery.param({
		"program": program.getValue(),
		"lattice": lattice.getValue(),
		"sim": sim.getValue(),
		"goal": goal.getValue(),
		"limit": limit.getValue()
	});
	output.setValue("Running...");
	derivation.setValue("Running...");
	post("php/run.php", data, function(data) {
		data = data.trim();
		if(data === "")
			data = "uncaught exception: unknown";
		data = data.trim().split("\n\n");
		if(data.length == 1)
			data[1] = "";
		output.setValue(data[0]);
		derivation.setValue(data[1]);
		draw_tree( data[1], "tree" );
	});
}

function fasill_listing() {
	var lst = document.getElementById("listing");
	var data = jQuery.param({
		"program": program.getValue()
	});
	lst.innerHTML = "Parsing rules...";
	post("php/listing.php", data, function(data) {
		data = data.trim();
		if(data === "") {
			data = "uncaught exception: unknown";
		} else if(data.substring(0,19) === "uncaught exception:") {
			
		} else {
			data = data.split("\n");
			var html = "";
			for(var i = 0; i < data.length; i++) {
				data[i] = data[i].trim().split(/ (.+)/);
				html += "<div onClick=\"fasill_unfold(event, '" + data[i][0] + "');\" class=\"lst-rule mt-3\"><span class=\"lst-rule-id\">" + data[i][0] + "</span><span class=\"lst-rule-content\">" + data[i][1] + "</span></div>";
			}
		}
		lst.innerHTML = html;
	});
}

function fasill_unfold(e, rule) {
	e.stopPropagation();
	var lst = document.getElementById("listing");
	lst.innerHTML = "Unfolding program...";
	var data = jQuery.param({
		"program": program.getValue(),
		"lattice": lattice.getValue(),
		"sim": sim.getValue(),
		"rule": rule
	});
	post("php/unfold.php", data, function(data) {
		lst.innerHTML = "";
		data = data.trim();
		if(data !== "")
			program.setValue(data);
	});
}

function fasill_tuning() {
	var data = jQuery.param({
		"program": program.getValue(),
		"lattice": lattice.getValue(),
		"sim": sim.getValue(),
		"tests": tests.getValue(),
		"limit": limit.getValue()
	});
	substitution.setValue("Tuning...");
	post("php/tuning.php", data, function(data) {
		data = data.trim();
		if(data === "")
			data = "uncaught exception: unknown";
		substitution.setValue(data);
	});
}
