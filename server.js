const express = require('express');
const path = require('path');

const app = express();
const PORT = 80;

// Serve static files
app.use(express.static(path.join(__dirname, 'public')));

// Fallback to index.html for all routes
app.get('*', (req, res) => {
  res.sendFile(path.join(__dirname, 'public/index.html'));
});

app.listen(PORT, '0.0.0.0', () => {
  console.log(`Server is running on port ${PORT}`);
});
