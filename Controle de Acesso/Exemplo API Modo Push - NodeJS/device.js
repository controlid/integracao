var ip = require("ip");
const axios = require('axios');

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

    async setPush(session) {
        try {
            console.log(this.ip);
            console.log(this.session);
            const response = await axios.post('http://'+this.ip+'/set_configuration.fcgi?session='+this.session,{
                "push_server": {
                "push_request_timeout": "4000",
                "push_request_period": "5",
                "push_remote_address": "http://" + ip.address() + ":8080"
                }
            });
            console.log("set push success: ", response.data);
            console.log("The server IP is " + ip.address());
        } catch (error) {
            console.log("Error performing set push: ", error);
        }  
    }
}

module.exports = Device;