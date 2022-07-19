/*
  This code is a simple example on how to use the Control iD API
  for the Monitor resource for Access Control devices.
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

app.use(bodyParser.raw(options));
app.use(bodyParser.json({ limit: '5mb' }));
app.use(bodyParser.urlencoded({ extended: false }));


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

// Device and server IP address
var deviceIp = '192.168.0.129';
async function configureMonitorTest(serverIp, serverPort) {
    let Device = require('./device');
    let device = new Device(deviceIp);
    await device.login();
    await device.configureMonitor(serverIp, serverPort);
}

// Initializing server listening at port 8000
var server = app.listen(8000, function () {
    console.log("The monitor ip and port will be %s and 8000", ip.address());
    configureMonitorTest(ip.address(), "8000");
    var host = server.address().address
    var port = server.address().port
    console.log("Example app listening at http://%s:%s \n", host, port)
 })