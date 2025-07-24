const express = require('express');
const app = express();
const port = process.env.PORT || 3000;

// Serve static HTML file
app.get('/', (req, res) => {
  res.sendFile(__dirname + '/index.html');
});

app.listen(port, () => {
  console.log(`App is running on http://localhost:${port}`);
});