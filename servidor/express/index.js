const express = require('express');
const moment = require('moment');
const bodyParser = require('body-parser');

const push = require('./push');
const monitor = require('./monitor');
const event = require('./event');

const app = express();
const port = 5000;

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({
    extended: true
}));

app.all('/**', (request, response) => {
    console.log('\n--- NEW REQUEST @ ' + moment().format('DD/MM/YYYY kk:mm:ss') + ' ---');
    console.log('Path -> ' + request.path);
    console.log('Query params -> ' + JSON.stringify(request.query));
    console.log('Content type -> ' + request.get('content-type'));
    console.log('Body length -> ' + request.get('content-length'));

    push(request, response);
    monitor(request, response);
    event(request, response);
});

app.listen(port, () => {
    console.log(`Server started @ ${port}`);
});
