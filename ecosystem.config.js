const path = require('path');

module.exports = {
  apps: [
    {
      name: "myapp-v1",
      script: path.join(__dirname, "app/v1/index.js"),
      cwd: path.join(__dirname),
      env: {
        PORT: 3000,
        VERSION: "v1-STABLE"
      }
    },
    {
      name: "myapp-v2",
      script: path.join(__dirname, "app/v2/index.js"),
      cwd: path.join(__dirname),
      env: {
        PORT: 3001,
        VERSION: "v2-NEW"
      }
    }
  ]
};
