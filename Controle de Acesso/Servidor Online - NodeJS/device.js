const axios = require('axios');
const { response } = require('express');

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
    async userDestroyImage() {
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
                    "max_request_attempts": "5",
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
    async remoteEnroll(type,save,id,sync) {
        try {
            const response = await axios.post('http://'+this.ip+'/remote_enroll.fcgi?session='+this.session,{
                "type":type,
                "save":save,
                "user_id":id,
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

    // Configure QR Code mode
    /*
        legacy (string): Set the operation mode of the QR Code
    */
    async configureQRCode(legacy) {
        try {
            const response = await axios.post('http://'+this.ip+'/set_configuration.fcgi?session='+this.session,{
                "face_id": {
                    "qrcode_legacy_mode_enabled": legacy
                }
            });
            console.log("configureQRCode success: ", response.data);
        } catch (error) {
            console.log("Error performing configureQRCode: ", error);
        }        
    }

    // Create a new QR Code
    /*
        id (number): Unique identifier of an identification QR code
        value (string): Content represented in the QR code
        user_id (number): Identifier of the user to which the identification QR Code belongs
    */
    async createQRCode(id, value, user_id) {
        try {
            const response = await axios.post('http://'+this.ip+'/create_objects.fcgi?session='+this.session,{
                "object": "qrcodes",
                "values": [
                    {
                        "id": id,
                        "value": value,
                        "user_id": user_id
                    }
                ]
            });
            console.log("createQRCode success: ", response.data);
        } catch (error) {
            console.log("Error performing createQRCode: ", error.data);
        }
    }

    // Create a new card
    /*
        id (number): Unique identifier of an identification card

        value (number): This field indicates the card numbering, for proximity cards (ASK, FSK, PSK), 
        also called Wiegand, the value to be sent by the API is [part before comma] * 2^32 + 
        [part after comma]
        
        user_id (number): Unique identifier of the user to which the identification card belongs
    */
    async createCard(id, value, user_id) {
        try {
            const response = await axios.post('http://'+this.ip+'/create_objects.fcgi?session='+this.session,{
                "object": "cards",
                "values": [
                    {
                        "id": id,
                        "value": value,
                        "user_id": user_id
                    }
                ]
            });
            console.log("createCard success: ", response.data);
        } catch (error) {
            console.log("Error performing createCard: ", error.data);
        }
    }

    // Create a new PIN
    /*
        id (number): Unique identifier of an identification PIN

        value (string): This field indicates the value of the PIN
        
        user_id (number): Unique identifier of the user to which the identification PIN belongs
    */
    async createPin(id, value, user_id) {
        try {
            const response = await axios.post('http://'+this.ip+'/create_objects.fcgi?session='+this.session,{
                "object": "pins",
                "values": [
                    {
                        "id": id,
                        "value": value,
                        "user_id": user_id
                    }
                ]
            });
            console.log("createPin success: ", response.data);
        } catch (error) {
            console.log("Error performing createPin: ", error.data);
        }
    }

    // Create a new biometric
    /*
        id (number): Unique identifier of a biometric template

        finger_position (number): Reserved field

        finger_type (number): Biometrics type common finger value 0 or panic finger value 1

        template (string): String in base 64 representing a biometric template
        
        user_id (number): Unique identifier of the user to whom this biometrics belongs
    */
    async createBiometric(id, finger_position, finger_type, template, user_id) {
        try {
            const response = await axios.post('http://'+this.ip+'/create_objects.fcgi?session='+this.session,{
                "object": "templates",
                "values": [
                    {
                        "id": id,
                        "finger_position": finger_position,
                        "finger_type": finger_type,
                        "template": template,
                        "user_id": user_id
                    }
                ]
            });
            console.log("createBiometric success: ", response.data);
        } catch (error) {
            console.log("Error performing createBiometric: ", error.data);
        }
    }

    // Hash password
    /*
        password (string): String to be hashed
    */
    async hashPassword(password) {
        try {
            const data = {
                "password": password,
            };
            const response = await axios.post(`http://${this.ip}/user_hash_password.fcgi?session=${this.session}`, data);
        
            return {
                password: response.data.password,
                salt: response.data.salt,
            };
        } catch (error) {
            console.error("Error performing hashPassword :", error.data);

        }
    }
    

    // Create a new ID + password access
    /*
        id (number): Unique identifier of a user
        name (string): Text containing the name of a user
        password (string): String that represents the user's password
     */
    async createIdPassword(id, name, password) {
        try {
            const passwordData = await this.hashPassword(password);
    
            const passwordHashed = passwordData.password;
            const salt = passwordData.salt;
            const response = await axios.post(`http://${this.ip}/create_objects.fcgi?session=${this.session}`, {
                "object": "users",
                "values": [
                    {
                        "id": id,
                        "name": name,
                        "password": passwordHashed,
                        "salt": salt,
                        "registration": ""
                    }
                ]
            });
    
            console.log("createIdPassword success: ", response.data);
        } catch (error) {
            console.error("Error performing createIdPassword: ", error.response ? error.response.data : error.message);
        }
    }
        

    // Create a new access rule
    /*
        id (number): Access rule identifier
        name (string): Descriptive name of the access rule
        type (number): Type of access rule: if it is 0, it is a blocking rule, and if it is 1, it is an allow rule
    */
    async createAccessRules(id, name, type) {
        try {
            const response = await axios.post('http://'+this.ip+'/create_objects.fcgi?session='+this.session,{
                "object": "access_rules",
                "values": [
                    {
                        "id": id,
                        "name": name,
                        "type": type,
                        "priority": 0
                    }
                ]
            });
            console.log("createAccessRules success: ", response.data);
        } catch (error) {
            console.log("Error performing createAccessRules: ", error.data);
        }
    }

    // Create a new user access rule
    /*
        user_id (number): User's unique identifier
        access_rule_id (number): Unique identifier of the access rule
    */
    async createUserAccessRules(user_id, access_rule_id) {
        try {
            const response = await axios.post('http://'+this.ip+'/create_objects.fcgi?session='+this.session,{
                "object": "user_access_rules",
                "values": [
                    {
                        "user_id": user_id,
                        "access_rule_id": access_rule_id
                    }
                ]
            });
            console.log("createUserAccessRules success: ", response.data);
        } catch (error) {
            console.log("Error performing createUserAccessRules: ", error.data);
        }
    }

    // Create a new portal access rule
    /*
        portal_id (number): Portal's unique identifier
        access_rule_id (number): Unique identifier of the access rule
    */
    async createPortalAccessRules(portal_id, access_rule_id) {
        try {
            const response = await axios.post('http://'+this.ip+'/create_objects.fcgi?session='+this.session,{
                "object": "portal_access_rules",
                "values": [
                    {
                        "portal_id": portal_id,
                        "access_rule_id": access_rule_id
                    }
                ]
            });
            console.log("reatePortalAccessRules success: ", response.data);
        } catch (error) {
            console.log("Error performing createPortalAccessRules: ", error.data);
        }
    }

}

module.exports = Device;