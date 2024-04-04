require('dotenv').config();
const express = require("express");
const morgan = require('morgan');

const app = express();
const PORT = process.env.PORT || 8080;

// Simple Endpoint
app.get("/", (req, res) => {
  res.send("Hello World");
});

// Simple API Endpoint
app.get("/api/status", (req, res) => {
  res.json({version: "1.01"});
});

app.listen(PORT, () => {
  console.log(`Server started on port ${PORT}!`);
});