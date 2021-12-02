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

    // Load user
    /*
        id (number): Unique identifier of a user
     */
    async loadUser(id) {
        try {
            var start = new Date();
            const response = await axios.post('http://'+this.ip+'/load_objects.fcgi?session='+this.session,{
                "object": "users",
                "where": {
                    "users": { "id": id }
                }
            });
            var end = new Date() - start;
            console.log("Took: ", end);
            console.log("loadUser success: ", response.data);
        } catch (error) {
            console.log("Error performing loadUser: ", error);
        }          
    }

    // Destroy all users
    async destroyAllUsers() {
        try {
            const response = await axios.post('http://'+this.ip+'/destroy_objects.fcgi?session='+this.session,{
                "object": "users"
            });
            console.log("destroyAllUsers success: ", response.data);
        } catch (error) {
            console.log("Error performing destroyAllUsers: ", error);
        }          
    }    

    // Destroy user
    /*
        id (number): Unique identifier of a user
     */
    async destroyUser(id) {
        try {
            const response = await axios.post('http://'+this.ip+'/destroy_objects.fcgi?session='+this.session,{
                "object": "users",
                "where": {
                    "users": { "id": id }
                }
            });
            console.log("destroyUser success: ", response.data);
        } catch (error) {
            console.log("Error performing destroyUser: ", error);
        }          
    }

    // Destroy images from all users
    async user_destroy_image() {
        try {
            const response = await axios.post('http://'+this.ip+'/user_destroy_image.fcgi?session='+this.session,{
                "all":true
            });
            console.log("user_destroy_image success: ", response.data);
        } catch (error) {
            console.log("Error performing user_destroy_image: ", error);
        }  
    }

    // Create multiple new users
    /*
        ids (number array): Array with unique identifier of each user
     */
    async createUsers(ids) {
        try {
            var data = {
                "object": "users",
                "values": []
            }
            ids.forEach(id => {
                data.values.push({
                        "id": id,
                        "name": "Teste"+id,
                        "registration": ""
                });
            });

            const response = await axios.post('http://'+this.ip+'/create_objects.fcgi?session='+this.session,data);
            console.log("createUsers success: ", response.data);
        } catch (error) {
            console.log("Error performing createUsers: ", error.response.data);
        }           
    }

    // Create a new user
    /*
        id (number): Unique identifier of a user
        name (string): Text containing the name of a user
     */
    async createUser(id, name) {
        try {
            const response = await axios.post('http://'+this.ip+'/create_objects.fcgi?session='+this.session,{
                "object": "users",
                "values": [
                    {
                        "id": id,
                        "name": name,
                        "registration": ""
                    }
                ]
            });
            console.log("createUser success: ", response.data);
        } catch (error) {
            console.log("Error performing createUser: ", error.response.data);
        }        
    }

    // Set multiple users with the same photo
    /*
        ids (number array): Array with unique identifier of each user
        photo (base64 image): base64 user image
    */
    async setImageListSamePhoto(ids, photo) {
        try {
            var data = {
                "user_images" : []
            };
            ids.forEach(id => {
                data.user_images.push({
                    "user_id": id,
                    "image": photo,
                    "timestamp": 0
                });
            });
            var start = new Date();
            const response = await axios.post('http://'+this.ip+'/user_set_image_list.fcgi?session='+this.session,data);
            var end = new Date() - start;
            console.info('Execution time: %dms', end)
            console.log("setImageListSamePhoto success: ", response.data);
        } catch (error) {
            console.log("Error performing setImageListSamePhoto: ", error.data);
        }       
    }

    // Set user photos
    /*
        ids (number array): Array with unique identifier of each user
        photos (base64 image array): Array with base64 images of each user
    */
    async setImageList(ids, photos) {
        try {
            var data = {
                "user_images" : []
            };
            for (var i=0;i<ids.length;i++) {
                data.user_images.push({
                    "user_id": ids[i],
                    "image": photos[i],
                    "timestamp": 0
                });
            };
            var start = new Date();
            const response = await axios.post('http://'+this.ip+'/user_set_image_list.fcgi?session='+this.session,data);
            var end = new Date() - start;
            console.info('Execution time: %dms', end);
            return response.data;
        } catch (error) {
            console.log("Error performing setImageListSamePhoto: ", error);
        }       
    }

    // Create a new device
    /*
        id (number): Equipment identifier
        serverip (string): Equipment IP address
        port (string): Communication port
    */
    async createOnlineObject(id, serverip, port) {
        try {
            const response = await axios.post('http://'+this.ip+'/create_objects.fcgi?session='+this.session,{
                "object": "devices",
                "values": [
                    {
                        "id": id,
                        "name": "node",
                        "ip": serverip+":"+port,
                        "public_key": ""
                    }
                ]
            });
            console.log("createOnlineObject success: ", response.data);
        } catch (error) {
            console.log("Error performing createOnlineObject: ", error.data);
        }
    }

    // Destroy a device
    /*
        id (number): Equipment identifier
    */
    async destroyOnlineObject(id) {
        try {
            const response = await axios.post('http://'+this.ip+'/destroy_objects.fcgi?session='+this.session,{
                "object": "devices",
                "where": {
                    "devices": { "id": id }
                }
            });
            console.log("destroyOnlineObject success: ", response.data);
        } catch (error) {
            console.log("Error performing destroyOnlineObject: ", error);
        }        
    }

    // Set online client
    /*
        id (number): Access server id in the devices table, which indicates to whom the identification events 
        will be sent
    */
    async setOnline(id) {
        try {
            const response = await axios.post('http://'+this.ip+'/set_configuration.fcgi?session='+this.session,{
                "online_client": {
                    "server_id": id.toString()
                }
            });
            console.log("setOnline success: ", response.data);
        } catch (error) {
            console.log("Error performing setOnline: ", error);
        }
    }

    // Enable online mode
    async enableOnlinePRO() {
        try {
            const response = await axios.post('http://'+this.ip+'/set_configuration.fcgi?session='+this.session,{
                "general": {
                    "local_identification": "1",
                    "online": "1"
                },
                "online_client": {
                    "extract_template": "0",
                    "max_request_attempts": "3",
                }
            });
            console.log("enableOnlinePRO success: ", response.data);
        } catch (error) {
            console.log("Error performing enableOnlinePRO: ", error);
        }
    }

    // Disable online mode
    async disableOnline() {
        try {
            const response = await axios.post('http://'+this.ip+'/set_configuration.fcgi?session='+this.session,{
                "general": {
                    "online": "0"
                }
            });
            console.log("disableOnline success: ", response.data);
        } catch (error) {
            console.log("Error performing disableOnline: ", error);
        }        
    }

    // Performs face registration remotely with id 1000
    /*
       type (string): Parameter that defines the way in which the registration will be performed,
       being "card", "face" or "biometry"

       save (boolean): The "save" parameter indicates whether the object (card, face or fingerprint)
       should be saved in the equipment or not. If "save" is "false", the object will be sent to the
       registered manager, or to the server (if the equipment is in some online mode). If "save" is "true",
       the user_id parameter must be sent in the request and must contain the identification number of a user
       already existing in the equipment.

       sync (bool): The "sync" parameter determines whether the remote biometrics or facial registration will
       be synchronous or asynchronous. When the registration required for the device is synchronous, the return
       will come in response and will contain the fingerprint template or the registered face photo in base 64 format.
       When the required registration is asynchronous, the equipment will send the result in the form of a new POST
       request, which makes it necessary to configure an endpoint on your server to receive it.
    */
    async remoteEnroll(type,save,sync) {
        try {
            const response = await axios.post('http://'+this.ip+'/remote_enroll.fcgi?session='+this.session,{
                "type":type,
                "save":save,
                "user_id":1000,
                "sync":sync
            });
            console.log("remoteEnroll success: ", response.data);
        } catch (error) {
            console.log("Error performing remoteEnroll: ", error);
        }
    }

    // Cancel remote registration in progress
    async cancelRemoteEnroll() {
        try {
            const response = await axios.post('http://'+this.ip+'/cancel_remote_enroll.fcgi?session='+this.session);
            console.log("cancelRemoteEnroll success: ", response.data);
        } catch (error) {
            console.log("Error performing cancelRemoteEnroll: ", error);
        }        
    }

    // Configure monitor
    async configureMonitor(ip,port) {
        try {
            const response = await axios.post('http://'+this.ip+'/set_configuration.fcgi?session='+this.session,{
                "monitor": {
                    "request_timeout": "5000",
                    "hostname": ip,
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