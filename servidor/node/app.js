const http = require('http');
const url = require('url');
const push = require('./push');
const monitor = require('./monitor');
const event = require('./event');

http.createServer((request, response) => {
  const urlParsed = url.parse(request.url, true);

  push(urlParsed, request, response);
  monitor(urlParsed, request, response);
  event(urlParsed, request, response);

}).listen(3000, function(){
  console.log("Server start at port 3000");
});