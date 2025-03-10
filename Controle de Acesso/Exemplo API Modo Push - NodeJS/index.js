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

const yargs = require('yargs');

const args = yargs
  .option('batch', {
    type: 'boolean',
    description: 'Run in batch mode',
    default: false
  })
  .help()
  .argv;

// The port is 8080
var port = 8080;

var router = express.Router();

// Counter for message toggling
var counter = 0;
var batch = args.batch;

// Get the push and define the response
router.get('/push', function(req, res) {
  console.log("Query string: ", req.query.deviceId);
  counter++;
  console.log("Counter: ", counter);
  if (batch) {
    if (counter % 2 == 0) {
      res.json({transactions:[
        {
          transactionid : "1",
          verb: "POST",
          endpoint: "create_objects",
          body: {
            object: "users",
            values: [{
              "id": counter,
              "name": "user_"+counter,
              "registration": ""
            }]
          },
          "contentType": "application/json"
        },
        {
          transactionid : "2",
          verb: "POST",
          endpoint: "create_objects",
          body: {
            object: "cards",
            values: [{
              "id": counter,
              "value": 528281023086+counter,
              "user_id": counter
            }]
          },
          "contentType": "application/json"
        },
        {
          transactionid : "3",
          verb: "POST",
          endpoint: "create_objects",
          body: {
            object: "access_rules",
            values: [{
              "id": counter,
              "name": "Happy Hour",
              "type": 1,
              "priority": 0
            }]
          },
          "contentType": "application/json"
        },
        {
          transactionid : "4",
          verb: "POST",
          endpoint: "create_objects",
          body: {
            object: "user_access_rules",
            values: [{
              "user_id": counter,
              "access_rule_id": counter
            }]
          },
          "contentType": "application/json"
        },
        {
          transactionid : "5",
          verb: "POST",
          endpoint: "set_configuration",
          body: {
            ntp: {
              "enabled": "1",
              "timezone": "UTC-3"
            }
          },
          "contentType": "application/json"
        }
      ]});
    }
  } else {
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

console.log(`Batch mode: ${batch}`);

// Listen to port
app.listen(port, () => {
  console.log('Listening to port: ', + port);
});
