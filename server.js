const express = require("express");
const app = express();

const PORT = process.env.PORT || 3000;

// simple test route
app.get("/", (req, res) => {
  res.send("Hello from Railway + CloudFront CDN 🚀");
});

// API route (test cache rule later)
app.get("/api/time", (req, res) => {
  res.json({
    time: new Date(),
    message: "API from origin server"
  });
});

app.listen(PORT, () => {
  console.log("Server running on port", PORT);
});
