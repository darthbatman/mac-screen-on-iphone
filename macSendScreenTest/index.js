var app = require("express")();
var http = require("http").Server(app);
var PythonShell = require("python-shell");

app.get("/", function(req, res){

	var options = {
		  scriptPath: __dirname + "/"
	};

	PythonShell.run('screenshot.py', options, function(err, results){
		if (err) throw err;
	});

	res.sendFile(__dirname + "/foo.png");
});

http.listen(8080, function(){
	console.log("Listening on *:8080");
});