const express = require("express");
const bodyParser = require("body-parser");
const { exec } = require("child_process");
const cors = require("cors");
const path = require("path");

const app = express();
const PORT = process.env.PORT || 8080;

app.use(cors());
app.use(bodyParser.json());

// Serve frontend from backend/frontend
app.use(express.static(path.join(__dirname, "frontend")));

app.get("/", (req, res) => {
  res.sendFile(path.join(__dirname, "frontend", "index.html"));
});

// API endpoint to run kubectl commands
app.post("/api/kubectl", (req, res) => {
  const cmd = req.body.cmd;
  if (!cmd || !cmd.startsWith("kubectl")) {
    return res.status(400).send("Only kubectl commands allowed.");
  }

  exec(cmd, (error, stdout, stderr) => {
    if (error) return res.status(500).send(stderr || error.message);
    res.send(stdout);
  });
});

app.listen(PORT, () => {
  console.log(`MCP Backend running on port ${PORT}`);
});

