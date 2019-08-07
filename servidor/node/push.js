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

        return;
    }

    if (lastPathname === 'result') {
        const callback = (chunks) => {
            var textBody = Buffer.concat(chunks).toString();
            console.log('Response body content:\n' + JSON.stringify(JSON.parse(textBody), null, 2));

            //code

        }

        readBody(request, callback);

        return;
    }

}
