const express = require('express');
const app = express();

const VERSION = process.env.VERSION || "BASE";

app.get('/', (req, res) => {
  res.send(`🚀 Running Version: ${VERSION}`);
});

app.get('/health', (req, res) => {
  res.status(200).send('OK');
});

const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
  console.log(`App running on port ${PORT}`);
});
