const url = require('url');

const init = function(request, response) {
    const urlParsed = url.parse(request.url, true);

    if (!urlParsed.pathname.startsWith('/push')) {
        return;
    }

    const params = {
        deviceId: urlParsed.query.deviceId,
        uuid: urlParsed.query.uuid
    }

    console.log('Push -> ' + JSON.stringify(params));

    //code

    response.end();

}

module.exports = { init };