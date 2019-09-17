from flask import Blueprint, jsonify

event = Blueprint('event', __name__)

@event.route('/device_is_alive.fcgi')
def device_is_alive():
    return jsonify(
        access_logs=1
    )