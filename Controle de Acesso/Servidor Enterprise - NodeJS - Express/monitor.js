const pathUtils = require('./path-utils');

const paths = [
    'dao',
    'template',
    'card',
    'catra_event',
    'operation_mode',
    'door',
    'secbox'
];

module.exports = (request, response) => {

    const lastPathname = pathUtils.extractLastPathname(request.path);

    if (pathUtils.notHasPath(lastPathname, paths)) {
        return;
    }

    console.log('Body content:\n' + JSON.stringify(request.body, null, 2));

    if (lastPathname === 'dao') {
        //code

        return;
    }

    if (lastPathname === 'template') {
        //code

        return;
    }

    if (lastPathname === 'card') {
        //code

        return;
    }

    if (lastPathname === 'catra_event') {
        //code

        return;
    }

    if (lastPathname === 'operation_mode') {
        //code

        return;
    }

    if (lastPathname === 'door') {
        //code

        return;
    }

    if (lastPathname === 'secbox') {
        //code

        return;
    }

}
