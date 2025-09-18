const express = require('express');
const app = express();
const port = process.env.PORT || 3000;

// Serve static HTML file
app.get('/', (req, res) => {
  res.sendFile(__dirname + '/index.html');
});

app.listen(process.env.PORT || 8080, '0.0.0.0', () => {
  console.log(`My App is running on http://localhost:${process.env.PORT || 8080}`)
})
