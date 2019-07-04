const paths = [
    '/push',
    '/result',
];

module.exports = (url, request, response) => {

    if (!paths.includes(url.pathname)) {
        return;
    }

    const readBody = (request, callback) => {
        let chunks = [];

        request.on('data', (chunk) => {
            chunks.push(chunk);
        }).on('end', () => callback(chunks));
    };

    if (url.pathname === '/push') {
        const params = { deviceId, uuid } = url.query;

        console.log('Push -> ' + JSON.stringify(params));

        //code

        return;
    }

    if (url.pathname === '/result') {
        const params = { deviceId, uuid, endpoint } = url.query;

        console.log('Result query -> ' + JSON.stringify(params));

        const callback = (chunks) => {
            var textBody = Buffer.concat(chunks).toString();

            console.log('Result body -> ' + textBody);
        }

        readBody(request, callback);

        return;
    }

}
