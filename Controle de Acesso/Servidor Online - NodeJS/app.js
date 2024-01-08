/*
This code is an example of how to use and 
operate an iDFace on online mode
*/

// Main modules
var express = require('express');
var bodyParser = require('body-parser');
var app = express();
var dateFormat = require('dateformat');
const { fstat } = require('fs');
const fs = require('fs');
const { exit } = require('process');
require('console-stamp')(console, '[HH:MM:ss.l]');
var ip = require("ip");
const args = require('./argsParser');

// Configurations
var options = {
    inflate: true,
    limit: '2mb',
    type: 'application/octet-stream'
};


// Sleep
function sleepms(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
}

//flag
var pending = false

/*
Return message from the server to the equipment 
after an identification attempt event.
*/

// Answer for remote user authorization
var access_answer = {
    result: {
        event: 7, 
        user_name: 'John Doe',
        user_id: 1000,
        user_image: true, 
        portal_id: 1,
        actions: [
            {
                action: 'sec_box', 
                parameters: 'id=65793=1, reason=1' 
            }
        ],
        message:"Online access"
    }
};

// Not identified example
var not_identified_answer = {
    result: {
        event: 3, 
        user_name: '',
        user_id: 0,
        user_image: false,
        portal_id: 0,
        actions: [
        ],
        message: "NOTIDENT"
    }
};


// Pending identification answer
var access_pending_answer = {
    result: {
        event: 4, 
        next_event: 'biometry',
        user_name: 'Test',
        user_id: 0,
        user_image: false,
        portal_id: 0,
    }
}

app.use(bodyParser.raw(options));
app.use(bodyParser.json({ limit: '5mb' }));
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.text());

// Endpoint telemetry
app.post('/api/notifications/telemetry', function (req, res) {
    console.log("endpoint: TELEMETRY");
    console.log("Data: ");
    console.log("Length: " + req.body.length);
    console.log("Serial (query string): " + req.query.serial);
    console.log("Version (query string): " + req.query.version);
    console.log(req.body);
    res.json(access_answer);
  })

app.post('/telemetry', function (req, res) {
console.log("endpoint: TELEMETRY");
console.log(req.body);
})


// Endpoint new card detected
app.post('/new_card.fcgi', function (req, res) {
    console.log("endpoint: NEW CARD");
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

// Endpoint to new ID and password
app.post('/new_user_id_and_password.fcgi', function (req, res) {
    console.log("endpoint: NEW USER ID AND PASSWORD");
    console.log("Data: ");
    console.log("Length: " + req.body.length);
    console.log(req.body);
    res.json(access_answer);
})

// Endpoint new user

app.post('/new_user_identified.fcgi', function (req, res) {
    console.log("endpoint: NEW USER IDENTIFIED");
    console.log("Data: ");
    console.log("Length: " + req.body.length);
    console.log(req.body);
    res.json(access_answer);
  })


// Endpoint new face
app.post('/face_create.fcgi', function (req, res) {
    console.log("endpoint: FACE CREATE");
    console.log('Query: ');
    console.log(req.query);
    console.log("Data: ");
    console.log("Length: " + req.body.length);
    console.log(req.body.toString());
    res.send();
})

// Create objects
app.post('/create_objects.fcgi', function (req, res) {
    console.log("endpoint: CREATE OBJECTS");
    console.log('Query: ');
    console.log(req.query);
    console.log("Data: ");
    console.log("Length: " + req.body.length);
    console.log(req.body.toString());
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

// Notification door
app.post('/api/notifications/door', function (req, res) {
    console.log("endpoint: API/NOTIFICATIONS/DOOR");

    console.log(req.body);
    res.send();
})

// Notification operation mode
app.post('/api/notifications/operation_mode', function (req, res) {
    console.log("endpoint: API/NOTIFICATIONS/OPERATION MODE");
    console.log("Data: ");
    console.log("Length: " + req.body.length);
    console.log(req.body);
    console.log("NOT SENDING ANSWER");
    res.send();
})

// Notification face template
app.post('/api/notifications/face_template', function (req, res) {
    console.log("endpoint: API/NOTIFICATIONS/FACE TEMPLATE");
    console.log("Origin: ");
    console.log(req.connection.remoteAddress);
    console.log("Length: " + req.body.length);
    console.log(req.body);
    console.log("\n\n");
    res.send();
})


// Notification card
app.post('/api/notifications/card', function (req, res) {
    console.log("endpoint: API/NOTIFICATIONS/CARD");
    console.log("Data: ");
    console.log("Length: " + req.body.length);
    console.log(req.body);
    res.send();
})

// Notification secbox
app.post('/api/notifications/secbox', function (req, res) {
    console.log("endpoint: API/NOTIFICATIONS/SECBOX");
    console.log("Data: ");
    console.log("Length: " + req.body.length);
    console.log(req.body);
    res.send();
})

// Notification user image
// Remote enroll with sync = false;
app.post('/api/notifications/user_image', function (req, res) {
    console.log("endpoint: face_create");
    console.log(req.headers);
    console.log(req.body);
    res.status(200).send();
})

// Face create
//This is for online only!
app.post('face_create.fcgi', function (req, res) {
    console.log("endpoint: face_create");
    console.log(req.headers);
    console.log(req.query);
    res.status(200).send();
})

// Card create
//This is for online only!
app.post('card_create.fcgi', function (req, res) {
    console.log("endpoint: card_create");
    console.log(req.headers);
    console.log(req.query);
    res.status(200).send();
})

// Is alive
app.post('/device_is_alive.fcgi', function (req, res) {
    console.log("endpoint: DEVICE IS ALIVE");
    console.log("Origin: ");
    console.log(req.connection.remoteAddress)
    console.log("Length: " + req.body.length);
    console.log(req.body);
    res.sendStatus(200);
})

// Result
app.post('/result', function (req, res) {
    console.log("endpoint: RESULT");
    console.log("Header: ");
    console.log(req.headers);
    console.log("Query: ");
    console.log(req.query); console.log("Length: " + req.body.length);
    console.log(req.body);
    res.sendStatus(200);
})

// Push mode
var push_answer = {
    verb: "POST",
    endpoint: "load_objects",
    body: '{"object": "users"}',
    contentType: "application/json",
    queryString: ""
};


app.get('/push', function (req, res) {
    console.log("endpoint: PUSH");
    console.log(req.headers);
    console.log("Device id: " + req.query.deviceId)
    console.log("UUID: " + req.query.uuid)
    console.log("Length: " + req.body.length);
    console.log(req.body);
    res.send();
})

// New rex log
app.post('/new_rex_log.fcgi', function (req, res) {
    console.log("endpoint: NEW REX LOG");
    console.log("Header: ");
    console.log(req.headers);
    console.log("Query: ");
    console.log(req.query);
    console.log("Length: " + req.body.length);
    console.log(req.body);
    res.send();
})

// User get image
app.get('/user_get_image.fcgi', function (req, res) {
    console.log("endpoint: USER GET IMAGE");
    console.log(req.headers);
    console.log(req.query)
    res.sendFile(__dirname + '/picture.png');
    res.status(400).send();
})

// Device IP address
var deviceIp = args.ip;

// Init Device
let Device = require('./device');
let device = new Device(deviceIp);

// Start server
function startServer() {
    const server = app.listen(8000, function () {
        const host = server.address().address;
        const port = server.address().port;
        console.log(`Example app listening at http://${host}:${port}`);
    });
}

// Returns the card value from the card number without commas, to be convert to [part before comma] * 2^32 + [part after comma]
function getCardValue(cardNumber) {
    const numberBeforeComma = parseInt(cardNumber.toString().slice(0,3));
    const numberAfterComma = parseInt(cardNumber.toString().slice(3,8));
    return (numberBeforeComma * Math.pow(2, 32) + numberAfterComma);
}

/*
***************************
    Functions for testing
***************************    
*/

// Run online mode
async function runOnline () {
    await device.login();

    await device.disableOnline();
    await device.destroyOnlineObject(5);
    await device.createOnlineObject(5, ip.address(), 8000);
    await device.setOnline(5);
    await device.enableOnlinePRO();

    startServer();
}

// Disable online mode
async function disableOnlineMode () {
    await device.login();

    await device.disableOnline();
}

// Create user on device
async function createUsers () {
    await device.login();

    const fs = require('fs').promises;
    const photo = await fs.readFile('picture.jpg', {encoding: 'base64'});
    const idStart = 400000;
    const step = 50;
    for (var i=0;i<10000;i=i+step) {
        let ids = [];
        for (var j=0;j<step;j++) {
            ids.push(idStart+i+j);
        }
        await device.createUsers(ids);
        await device.setImageListSamePhoto(ids, photo);
    }
}

// Destroy images from all users
async function destroyImages() {
    await device.login();

    await device.userDestroyImage();
}

// Destroy all users
async function destroyAll() {
    await device.login();

    await device.destroyAllUsers();
}

// Load user
async function loadUserTest (userId) {
    await device.login();

    await device.loadUser(userId);
}


// Performs face registration remotely
async function runRemoteEnroll(userId, userName) {
    await device.login();

    startServer();

    await device.destroyUser(userId);
    await device.createUser(userId, userName);
    await device.remoteEnroll("face", true, userId, false);
}

// Starts and cancel face registration remotely
async function cancelRemoteEnroll(userId, userName) {
    await device.login();

    startServer();

    await device.destroyUser(userId);
    await device.createUser(userId, userName);
    await device.remoteEnroll("face", true, false);   
    await device.cancelRemoteEnroll();
}

// QR Code Alphanumeric test
async function qrCodeTestAlphanumeric(qrCodeId, qrCodeValueAlphaNumeric, userId) {
    await device.login();

    await device.configureQRCode("0")
    await device.createQRCode(qrCodeId, qrCodeValueAlphaNumeric, userId);
}


async function qrCodeTestNumeric(qrCodeId, qrCodeValueNumeric, userId) {
    await device.login();

    await device.configureQRCode("1")
    await device.createCard(qrCodeId, qrCodeValueNumeric, userId);
}

// Card registration test
async function cardTest(cardId, userId, cardNumber) {
    await device.login();

    const value = getCardValue(cardNumber);
    await device.createCard(cardId, value, userId);
}

// PIN registration test
async function pinTest(pinId, pinValue, userId) {
    await device.login();

    await device.createPin(pinId, pinValue, userId);
}

// Biometric registration test
async function biometricTest(bioId, userId) {
    await device.login();

    const fingerPosition = 3;
    const fingerType = 0;
    const template = 'SGVsbG8gV29ybGQh';
    await device.createBiometric(bioId, fingerPosition, fingerType, template, userId);
}


// Id + password registration test
async function idPasswordTest(userId, userName, password) {
    await device.login();
    
    await device.createIdPassword(userId, userName, password);
}


// Test definition
/* 
    1 - Remote enroll test
    2 - Create multiple users
    3 - Set online mode
    4 - Disable online mode
    5 - Destroy users photos
    6 - Destroy all users
    7 - Load user
    8 - QR Code Alphanumeric test
    9 - QR Code Numeric test
    10 - Card registration test
    11 - PIN registration test
    12 - Biometric registration test
    13 - ID + password registration test
*/
var test = args.test;

if (test == 1) {
    runRemoteEnroll(args.userId, args.userName);
} else if (test == 2) {
    createUsers();
} else if (test == 3) {
    runOnline();
} else if (test == 4) {
    disableOnlineMode();
} else if (test == 5) {
    destroyImages();
} else if (test == 6) {
    destroyAll()
} else if (test == 7) {
    loadUserTest(args.userId);
} else if (test == 8) {
    qrCodeTestAlphanumeric(args.qrCodeId, args.qrCodeValueAlphaNumeric, args.userId);
} else if (test == 9) {
    qrCodeTestNumeric(args.qrCodeId, args.qrCodeValueNumeric, args.userId);
} else if (test == 10) {
    cardTest(args.cardId, args.userId, args.cardNumber);
} else if (test == 11) {
    pinTest(args.pinId, args.pinValue, args.userId);
} else if (test == 12) {
    biometricTest(args.bioId, args.userId);
} else if (test == 13) {
    idPasswordTest(args.userId, args.userName, args.password);
}

