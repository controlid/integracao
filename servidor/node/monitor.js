const url = require('url');

const init = function(request, response) {
    const urlParsed = url.parse(request.url, true);

    if (!urlParsed.pathname.startsWith('/api/notifications')) {
        return;
    }

    const readBody = (request, callback) => {
        let chunks = [];

        request.on('data', (chunk) => {
            chunks.push(chunk);
        }).on('end', () => callback(chunks));
    };

    if (urlParsed.pathname.startsWith('/api/notifications/dao')) {
        const callback = async (chunks) => {
            var textBody = Buffer.concat(chunks).toString();
            console.log('Monitor dao -> ' + textBody);

            //code

            response.end();
        }

        readBody(request, callback);

        return;
    }

    if (urlParsed.pathname.startsWith('/api/notifications/template')) {
        const callback = async (chunks) => {
            var textBody = Buffer.concat(chunks).toString();
            console.log('Monitor template -> ' + textBody);

            //code

            response.end();
        }

        readBody(request, callback);

        return;
    }

    if (urlParsed.pathname.startsWith('/api/notifications/card')) {
        const callback = async (chunks) => {
            var textBody = Buffer.concat(chunks).toString();
            console.log('Monitor card -> ' + textBody);

            //code

            response.end();
        }

        readBody(request, callback);

        return;
    }

    if (urlParsed.pathname.startsWith('/api/notifications/catra_event')) {
        const callback = async (chunks) => {
            var textBody = Buffer.concat(chunks).toString();
            console.log('Monitor catra event -> ' + textBody);

            //code

            response.end();
        }

        readBody(request, callback);

        return;
    }

    if (urlParsed.pathname.startsWith('/api/notifications/operation_mode')) {
        const callback = async (chunks) => {
            var textBody = Buffer.concat(chunks).toString();
            console.log('Monitor operation mode -> ' + textBody);

            //code

            response.end();
        }

        readBody(request, callback);

        return;
    }

    if (urlParsed.pathname.startsWith('/api/notifications/door')) {
        const callback = async (chunks) => {
            var textBody = Buffer.concat(chunks).toString();
            console.log('Monitor door -> ' + textBody);

            //code

            response.end();
        }

        readBody(request, callback);

        return;
    }

    if (urlParsed.pathname.startsWith('/api/notifications/secbox')) {
        const callback = async (chunks) => {
            var textBody = Buffer.concat(chunks).toString();
            console.log('Monitor secbox -> ' + textBody);

            //code

            response.end();
        }

        readBody(request, callback);

        return;
    }

}

module.exports = { init };