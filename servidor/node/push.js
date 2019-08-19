const pathUtils = require('./path-utils');

const paths = [
    'push',
    'result',
];

module.exports = (url, request, response) => {

    const lastPathname = pathUtils.extractLastPathname(url);

    if (pathUtils.notHasPath(lastPathname, paths)) {
        return;
    }

    const readBody = (request, callback) => {
        let chunks = [];

        request.on('data', (chunk) => {
            chunks.push(chunk);
        }).on('end', () => callback(chunks));
    };

    if (lastPathname === 'push') {

        //code

        response.end(JSON.stringify({endpoint:'system_information'}));

        return;
    }

    if (lastPathname === 'result') {
        const callback = (chunks) => {
            var textBody = Buffer.concat(chunks).toString();
            var requestBody = {
                response: JSON.parse(JSON.parse(textBody).response)
            }

            console.log('Response body content:\n' + JSON.stringify(requestBody, null, 2));

            //code

        }

        readBody(request, callback);

        return;
    }

}
