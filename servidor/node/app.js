const http = require('http');
const push = require('./push');
const monitor = require('./monitor');

http.createServer((request, response) => {
  push.init(request, response);
  monitor.init(request, response);
}).listen(3000, function(){
  console.log("Server start at port 3000");
});