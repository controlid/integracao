/*
This code is an example of how to use and 
operate Monitor
*/

// Main modules
var express = require('express');
var bodyParser = require('body-parser');
var app = express();
var dateFormat = require('dateformat');
const fs = require('fs');
const { exit } = require('process');
require('console-stamp')(console, '[HH:MM:ss.l]');
var ip = require("ip");


// Configurations
var options = {
    inflate: true,
    limit: '2mb',
    type: 'application/octet-stream'
};

var pending = false
var access_answer = {
  result:{
    event: 7,
    user_name: 'Paiva',
    user_id: 10,
    user_image: true,
    portal_id: 0,
    actions: [
      {
        action: 'door',
        parameters: 'door=1, reason=1'
      }
    ]
  }
}

var access_pending_answer = {
  result:{
    event: 4,
    next_event: 'biometry',
    user_name: 'Paiva',
    user_id: 0,
    user_image: false,
    portal_id: 0,
  }
}

app.use(bodyParser.raw(options));
app.use(bodyParser.json({ limit: '5mb' }));
app.use(bodyParser.urlencoded({ extended: false }));

app.post('/device_is_alive.fcgi', function (req, res) {
    console.log("Data: ");
    console.log("Length: " + req.body.length);
    console.log(req.body);
    res.json({});
 })
 
 
 app.post('/new_card.fcgi', function (req, res) {
    console.log("Data: ");
    console.log("Length: " + req.body.length);
    console.log(req.body);
    if(pending){
       res.json(access_answer);
       pending = !pending
    } else {
       res.json(access_pending_answer);
       pending = !pending
    }
 })
 
 app.post('/new_user_id_and_password.fcgi', function (req, res) {
    console.log("Data: ");
    console.log("Length: " + req.body.length);
    console.log(req.body);
    res.json(access_answer);
 })
 
 app.post('/new_user_identified.fcgi', function (req, res) {
    console.log("Data: ");
    console.log("Length: " + req.body.length);
    console.log(req.body);
    res.json(access_answer);
 })
 
 app.post('/new_biometric_template.fcgi', function (req, res) {
    console.log("Data: ");
    console.log("Length: " + req.body.length);
    console.log(req.body);
    res.json(access_answer);
 })
 
 
 app.post('/new_biometric_image.fcgi', function (req, res) {
    console.log('Query: ');
    console.log(req.query);
    console.log("Data: ");
    console.log("Length: " + req.body.length);
    console.log(req.body);
 
    fs.writeFile("/tmp/test", req.body, function(err) {
        if(err) {
           return console.log(err);
        }
 
        console.log("The file was saved!");
    }); 
 
    res.json(access_answer);
 })
 
 
 app.get('/user_get_image.fcgi', function(req, res) {
    console.log('Device requested user image at /user_get_image.fcgi');
    console.log('Query: ');
    console.log(req.query);
    console.log('');
 
    res.contentType('image/jpeg');
    res.sendFile(__dirname + '/images/idtouch.jpeg');
 });
 
 
 app.post('/template_create.fcgi', function (req, res) {
    console.log('Query: ');
    console.log(req.query);
    console.log("Data: ");
    console.log("Length: " + req.body.length);
    console.log(req.body.toString());
    res.send();
 })
 
 app.post('/new_rex_log.fcgi', function (req, res) {
    console.log("Data: ");
    console.log("Length: " + req.body.length);
    console.log(req.body);
    res.send();
 })

 

// Notification DAO
app.post('/api/notifications/dao', function (req, res) {
    console.log("endpoint: API/NOTIFICATIONS/DAO");
    console.log("Data: ");
    console.log("Length: " + req.body.length);
    console.log(req.body);
    console.log(req.body.object_changes[0].values);
    res.send();
})

// Notification catra event
app.post('/api/notifications/catra_event', function (req, res) {
    console.log("endpoint: API/NOTIFICATIONS/CATRA EVENT");
    var date = new Date((req.body.event.time + 3*60*60)*1000);
    console.log("Time: " + dateFormat(date, '[HH:MM:ss.l]'));
    console.log(req.body);
    console.log("\n");
    res.send();
})

// Notification door
app.post('/api/notifications/door', function (req, res) {
    console.log("endpoint: API/NOTIFICATIONS/DOOR");
    console.log(req.body);
    console.log("\n");
    res.send();
})

// Notification operation mode
app.post('/api/notifications/operation_mode', function (req, res) {
    console.log("endpoint: API/NOTIFICATIONS/OPERATION MODE");
    console.log("Data: ");
    console.log("Length: " + req.body.length);
    console.log(req.body);
    console.log("\n");
    res.send();
})

//Notification template
app.post('/api/notifications/template', function (req, res) {
    console.log("endpoint: API/NOTIFICATIONS/TEMPLATE");
    console.log("Data: ");
    console.log("Length: " + req.body.length);
    console.log(req.body);
    console.log("\n");
    res.send();
})

// Notification face template
app.post('/api/notifications/face_template', function (req, res) {
    console.log("endpoint: API/NOTIFICATIONS/FACE TEMPLATE");
    console.log("Origin: ");
    console.log("Length: " + req.body.length);
    console.log(req.body);
    console.log("\n");
    res.send();
})


// Notification card
app.post('/api/notifications/card', function (req, res) {
    console.log("endpoint: API/NOTIFICATIONS/CARD");
    console.log("Data: ");
    console.log("Length: " + req.body.length);
    console.log(req.body);
    console.log("\n");
    res.send();
})

// Notification secbox
app.post('/api/notifications/secbox', function (req, res) {
    console.log("endpoint: API/NOTIFICATIONS/SECBOX");
    console.log("Data: ");
    console.log("Length: " + req.body.length);
    console.log(req.body);
    console.log("\n");
    res.send();
})

// Notification user image
app.post('/api/notifications/user_image', function (req, res) {
    console.log("endpoint: face_create");
    console.log(req.headers);
    console.log(req.body);
    console.log("\n");
    res.status(200).send();
})

app.post('/fingerprint_create.fcgi', function (req, res) {
    var charset = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=';
  
    var global_ret = true;
    for (var i = req.body.fingerprints.length - 1; i >= 0; i--) {
      var ret = true;
      console.log("Checking fingerprint " + (i+1) + "...");
      var fp = req.body.fingerprints[i].image;
      for (var j = fp.length - 1; j >= 0; j--) {
        if(charset.indexOf(fp.charAt(j)) == -1) {
          console.log("Invalid Character: " + fp.charCodeAt(j));
          ret = false;
          break;
        }
      }
      if(ret)
        console.log("Fingerprint " + (i+1) + " OK");
      else
        global_ret = false;
    }
  
    if(global_ret) {
      res.send();
    } else {
      res.status(400).send();
    }
  })
  

// Device and server IP address
var deviceIp = '192.168.0.129'


async function configureMonitorTest(serverIp, serverPort) {
    let Device = require('./device');
    let device = new Device(deviceIp);
    await device.login();
    await device.configureMonitor(serverIp, serverPort);
}

var server = app.listen(8000, function () {
    configureMonitorTest(ip.address(), "8000");
    var host = server.address().address
    var port = server.address().port
    console.log("Example app listening at http://%s:%s \n", host, port)
 })








