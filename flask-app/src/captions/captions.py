from flask import Blueprint, request, jsonify, make_response
import json
from .. import db

captions = Blueprint('captions', __name__)

# Get all customers from the DB
@captions.route('/captions', methods=['GET'])
def get_captions():
    cur = db.get_db().cursor()
    cur.execute('select * from captions')
    row_headers = [x[0] for x in cur.description]
    json_data = []
    the_data = cur.fetchall()
    for row in the_data:
        json_data.append(dict(zip(row_headers, row)))
    return jsonify(json_data)

# Get customer detail for customer with particular userID
@captions.route('/captions/<captionID>', methods=['GET'])
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

@captions.route('/captions/upVote', methods=['POST'])
def upvote_caption():
    caption_ID = request.form['caption_ID']
    cursor = db.get_db().cursor()
    cursor.execute(f'SELECT points FROM captions WHERE captionID = {caption_ID}')

    points = cursor.fetchall()[0] + 1

    cursor.execute(f'UPDATE captions SET points = {points} WHERE captionID = {caption_ID}')
    return '', 200

@captions.route('/captions/uploadCaption', methods=['POST'])
def upload_caption():
    caption_text = request.form['caption_text']

    cursor = db.get_db().cursor()
    cursor.execute(f'INSERT INTO captions(datePosted, points, captionText, numSaves, creator) VALUES (CURDATE(), 0, "{caption_text}", 0, "kmaccracken9")')

    cursor.connection.commit()
    return '', 200

