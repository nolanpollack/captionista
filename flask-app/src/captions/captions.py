from flask import Blueprint, request, jsonify, make_response
import json
from .. import db


captions_blueprint = Blueprint('captions', __name__)

# Get all customers from the DB
@captions_blueprint.route('/captions', methods=['GET'])
def get_captions():
    cur = db.get_db().cursor()
    cur.execute('select captionText, creator, datePosted, points from captions')
    row_headers = [x[0] for x in cur.description]
    json_data = []
    the_data = cur.fetchall()
    for row in the_data:
        json_data.append(dict(zip(row_headers, row)))
    return jsonify(json_data)

# Get customer detail for customer with particular userID
@captions_blueprint.route('/captions/<captionID>', methods=['GET'])
def get_caption(captionID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from captions where captionID = {0}'.format(captionID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

@captions_blueprint.route('/captions/<captionID>/upVote', methods=['POST'])
def upvote_caption(captionID):
    cursor = db.get_db().cursor()
    cursor.execute('UPDATE captionId SET ')