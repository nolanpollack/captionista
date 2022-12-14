from flask import Blueprint, request, jsonify, make_response
import json
from .. import db

creators = Blueprint('creators', __name__)

# Get all customers from the DB
@creators.route('/creators', methods=['GET'])
def get_creators():
    cur = db.get_db().cursor()
    cur.execute('select * from creators')
    row_headers = [x[0] for x in cur.description]
    json_data = []
    the_data = cur.fetchall()
    for row in the_data:
        json_data.append(dict(zip(row_headers, row)))
    return jsonify(json_data)

@creators.route('creator/<username>', methods = ['GET'])
def get_creator(username):
    cursor = db.get_db().cursor()
    cursor.execute('select * from captions where creator = "{0}"'.format(username))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

@creators.route('/login', methods =['GET'])
def login():
    username = request.form['username']
    password = request.form['password']

    cur = db.get_db().cursor()
    cur.execute(f'select * from creators WHERE password = "{password}" AND username = "{username}"')

    var = cur.rowcount

    if var != 1:
        return jsonify(cur.fetchall()),404
    else:
        return jsonify(cur.fetchall()), 200

@creators.route('/signUp', methods =['POST'])
def sign_up():
    username = request.form['username']
    email = request.form['email']
    first_name = request.form['first_name']
    last_name = request.form['last_name']
    password = request.form['password']

    cur = db.get_db().cursor()

    cur.execute(f'select * from creators WHERE username = "{username}"')

    var = cur.rowcount

    if var > 0:
        return "This Username Already Exists", 303
    else:
        cur.execute(f'INSERT INTO creators(username, emailAddress, joinDate, firstName, lastName, password, biography)'
                    f' VALUES ("{username}", "{email}", CURDATE(), "{first_name}", "{last_name}", "{password}", "")')
        cur.connection.commit()
        return '', 200
