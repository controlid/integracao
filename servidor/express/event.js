const pathUtils = require('./path-utils');

const paths = [
    'new_biometric_image.fcgi',
    'new_biometric_template.fcgi',
    'new_card.fcgi',
    'new_user_id_and_password.fcgi',
    'new_user_identified.fcgi',
    'user_get_image.fcgi',
    'device_is_alive.fcgi',
    'template_create.fcgi',
    'fingerprint_create.fcgi',
    'card_create.fcgi',
    'new_rex_log.fcgi',
    'master_password.fcgi'
];

module.exports = (request, response) => {

    const lastPathname = pathUtils.extractLastPathname(request.path);

    if (pathUtils.notHasPath(lastPathname, paths)) {
        return;
    }

    var contentType = request.get('content-type');

    if (['application/json', 'application/x-www-form-urlencoded'].includes(contentType)) {
        console.log('Body content:\n' + JSON.stringify(request.body, null, 2));
    }

    if ('application/octet-stream' === contentType) {
        let bytes = [];
        let uploadProgress = 0;

        request.on('data', (byte) => {
            uploadProgress += byte.length;

            process.stdout.clearLine();
            process.stdout.cursorTo(0);
            process.stdout.write("Loading -> " + uploadProgress);

            bytes.push(byte);
        });

        request.on('end', () => console.log('\nLoaded!'));
    }

    if (lastPathname === 'new_user_identified.fcgi') {
        //code

        return;
    }

    if (lastPathname === 'device_is_alive.fcgi') {
        //code

        response.sendStatus(200);
        return;
    }

}
