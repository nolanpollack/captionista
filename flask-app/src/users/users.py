from flask import Blueprint, request, jsonify, make_response
import json
from .. import db

users = Blueprint('users', __name__)

# Get all customers from the DB
@users.route('/', methods=['GET'])
def get_users():
    cur = db.get_db().cursor()
    cur.execute('select * from endUsers')
    row_headers = [x[0] for x in cur.description]
    json_data = []
    the_data = cur.fetchall()
    for row in the_data:
        json_data.append(dict(zip(row_headers, row)))
    return jsonify(json_data)

@users.route('/<username>', methods = ['GET'])
def get_user(username):
    cursor = db.get_db().cursor()
    cursor.execute('select * from endUsers where username = "{0}"'.format(username))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response