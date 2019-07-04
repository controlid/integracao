const paths = [
    '/new_biometric_image.fcgi',
    '/new_biometric_template.fcgi',
    '/new_card.fcgi',
    '/new_user_id_and_password.fcgi',
    '/new_user_identified.fcgi',
    '/user_get_image.fcgi',
    '/device_is_alive.fcgi',
    '/template_create.fcgi',
    '/card_create.fcgi',
];

module.exports = (url, request, response) => {

    if (!paths.includes(url.pathname)) {
        return;
    }

    console.log('Event pathname -> ' + url.pathname);
    console.log('Event query -> ' + JSON.stringify(url.query));

}
