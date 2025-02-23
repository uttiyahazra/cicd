const express = require("express");

const app = express();

app.get("/", (req, res) => {
	res.send("Node.js demo app using Express.");
});

app.listen(3000, () => {
	console.log("App is listening.");
});
