# Some set up for the application 

from flask import Flask, jsonify
from flaskext.mysql import MySQL

# create a MySQL object that we will use in other parts of the API
db = MySQL()

def create_app():
    app = Flask(__name__)
    
    # secret key that will be used for securely signing the session 
    # cookie and can be used for any other security related needs by 
    # extensions or your application
    app.config['SECRET_KEY'] = 'someCrazyS3cR3T!Key.!'

    # these are for the DB object to be able to connect to MySQL. 
    app.config['MYSQL_DATABASE_USER'] = 'webapp'
    app.config['MYSQL_DATABASE_PASSWORD'] = open('/secrets/db_password.txt').readline()
    app.config['MYSQL_DATABASE_HOST'] = 'db'
    app.config['MYSQL_DATABASE_PORT'] = 3306
    app.config['MYSQL_DATABASE_DB'] = 'captionista_db'  # Change this to your DB name

    # Initialize the database object with the settings above. 
    db.init_app(app)
    
    # Import the various routes
    from src.captions.captions import captions
    from src.creators.creators import creators
    from src.users.users import users

    # Register the routes that we just imported so they can be properly handled
    app.register_blueprint(captions, url_prefix='/')
    app.register_blueprint(creators, url_prefix='/')
    app.register_blueprint(users, url_prefix='/users')

    return app