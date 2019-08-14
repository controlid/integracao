const http = require('http');
const url = require('url');

const port = 3000;

const push = require('./push');
const monitor = require('./monitor');
const event = require('./event');

http.createServer((request, response) => {
  const urlParsed = url.parse(request.url, true);

  var date = new Date();
  var hourString = date.getHours() + ':' + date.getMinutes() + ':' + date.getSeconds();

  console.log('\n--- NEW REQUEST @ ' + hourString + ' ---');
  console.log('Path -> ' + urlParsed.pathname);
  console.log('Query params -> ' + urlParsed.search);

  push(urlParsed, request, response);
  monitor(urlParsed, request, response);
  event(urlParsed, request, response);

}).listen(port, () => {
  console.log(`Server started @ ${port}`);
});