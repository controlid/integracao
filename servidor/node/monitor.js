const pathUtils = require('./path-utils');

const paths = [
    'dao',
    'template',
    'card',
    'catra_event',
    'operation_mode',
    'door',
    'secbox',
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

    if (lastPathname === 'dao') {
        const callback = (chunks) => {
            var textBody = Buffer.concat(chunks).toString();
            console.log('Body content:\n' + JSON.stringify(JSON.parse(textBody), null, 2));

            //code
        }

        readBody(request, callback);

        return;
    }

    if (lastPathname === 'template') {
        const callback = (chunks) => {
            var textBody = Buffer.concat(chunks).toString();
            console.log('Body content:\n' + JSON.stringify(JSON.parse(textBody), null, 2));

            //code

        }

        readBody(request, callback);

        return;
    }

    if (lastPathname === 'card') {
        const callback = (chunks) => {
            var textBody = Buffer.concat(chunks).toString();
            console.log('Body content:\n' + JSON.stringify(JSON.parse(textBody), null, 2));

            //code

        }

        readBody(request, callback);

        return;
    }

    if (lastPathname === 'catra_event') {
        const callback = (chunks) => {
            var textBody = Buffer.concat(chunks).toString();
            console.log('Body content:\n' + JSON.stringify(JSON.parse(textBody), null, 2));

            //code

        }

        readBody(request, callback);

        return;
    }

    if (lastPathname === 'operation_mode') {
        const callback = (chunks) => {
            var textBody = Buffer.concat(chunks).toString();
            console.log('Body content:\n' + JSON.stringify(JSON.parse(textBody), null, 2));

            //code

        }

        readBody(request, callback);

        return;
    }

    if (lastPathname === 'door') {
        const callback = (chunks) => {
            var textBody = Buffer.concat(chunks).toString();
            console.log('Body content:\n' + JSON.stringify(JSON.parse(textBody), null, 2));

            //code

        }

        readBody(request, callback);

        return;
    }

    if (lastPathname === 'secbox') {
        const callback = (chunks) => {
            var textBody = Buffer.concat(chunks).toString();
            console.log('Body content:\n' + JSON.stringify(JSON.parse(textBody), null, 2));

            //code

        }

        readBody(request, callback);

        return;
    }

}
