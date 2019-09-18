from flask import Blueprint, jsonify, request

event = Blueprint('event', __name__)

@event.route('/device_is_alive.fcgi', methods=['POST'])
def device_is_alive():
    print('event.device_is_alive')
    print(request.get_json())
    print(request.args)

    return jsonify(
        access_logs=request.get_json()['access_logs']
    )