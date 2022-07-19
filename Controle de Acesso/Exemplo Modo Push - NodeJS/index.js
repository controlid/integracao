/*
  This example express the basic functionalities of the push mode.
  The equipment must be correctly connected and configured to your
  network prior to executing this code.
*/

var express = require('express');
var app = express();
var bodyParser = require('body-parser');
var sleep = require('sleep');
var ip = require("ip");
const axios = require('axios');

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

// The port is 8080
var port = 8080;

var router = express.Router();

// Counter for message toggling
var counter = 0;

// Get the push and define the response
router.get('/push', function(req, res) {
  console.log("Query string: ", req.query.deviceId);
  counter++;
  console.log("Counter: ", counter);
  if (counter % 6 == 0 || counter % 6 == 2 || counter % 6 == 4) {
    res.send();
  } else if (counter % 6 == 1) {
    res.json({
      verb: 'POST',
      endpoint: 'set_configuration',
      body: { 
        general: {"language": "pt_BR"}
      },
      contentType: 'application/json'
    });
  } else if (counter % 6 == 3) {
    res.json({
      verb: 'POST',
      endpoint: 'set_configuration',
      body: {
        general: {"language": "en_US"}
      },
      contentType: 'application/json'
    });
  } else if (counter % 6 == 5) {
    res.json({
      verb: 'POST',
      endpoint: 'set_configuration',
      body: {
        general: {"language": "spa_SPA"}
      },
      contentType: 'application/json'
    }); 
  }
});

// login and push configuration of remote device
var deviceIp = '192.168.0.129';
async function init() {
  let Device = require('./device');
  let device = new Device(deviceIp);
  await device.login();
  await device.setPush();
}

// Post the response
router.post('/result', function(req, res) {
  console.log(req.body);
  res.json();
}); 

app.use(router);

init();
// Listen to port
app.listen(port, () => {
  console.log('Listening to port: ', + port);
});
