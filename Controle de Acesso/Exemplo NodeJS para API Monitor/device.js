const axios = require('axios')

class Device 
{
    constructor(ip)
    {
        console.log("Creating device with ip="+ip);
        this.ip = ip;
    }

    // Does login
    async login() {
        try {
            console.log("Will login to ip: "+this.ip);
            const response = await axios.post('http://'+this.ip+'/login.fcgi',{
                "login": "admin",
                "password": "admin"
            });
            this.session = response.data.session;
            console.log("login success: ", response.data);
        } catch (error) {
            console.log("Error performing request: ", error.data);
        }
    };
    
    // Configure monitor on remote device
    /*
        hostname (string): The address where a request will be sent, for example the IP of the server.
        port (string): The port where the request will be sent.
    */
    async configureMonitor(hostname,port) {
        try {
            const response = await axios.post('http://'+this.ip+'/set_configuration.fcgi?session='+this.session,{
                "monitor": {
                    "request_timeout": "5000",
                    "hostname": hostname,
                    "port": port,
                    "path":"api/notifications"
                }
            });
            console.log("configureMonitor success: ", response.data);
        } catch (error) {
            console.log("Error performing configureMonitor: ", error);
        }        
    }
}

module.exports = Device;