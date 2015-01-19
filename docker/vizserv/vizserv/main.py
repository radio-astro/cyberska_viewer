# -*- coding: utf-8 -*-

# Copyright 2013  University of Calgary
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

from flask import Flask
from flask import make_response
from flask import jsonify
from flask import request
from flask import url_for
from flask import redirect

from vizserv import db
from vizserv import model
from vizserv import util
from vizserv import vizserv
from vizserv import start_time
from vizserv import viz_sessions_created

from time import gmtime
from time import mktime

import os.path

def createVizSession():
    """Check for appropriate parameter values, """

    from sqlalchemy.exc import IntegrityError

    # Create viz session info based on either a GUID or a filename
    if 'guid' in request.form:
        guid = request.form['guid']
        (filename, timestamp) = util.getFileInfoFromGUID(guid)

        if filename is None or timestamp is None:
            return make_response(jsonify(invalid="Invalid guid or file not available in zone"), 403)
    elif 'filename' in request.form:
        guid = 1
        filename = request.form['filename']

        if os.path.isfile(filename):
            timestamp = int(os.path.getmtime(filename))
        else:
            return make_response(jsonify(missing="Specified file not found"), 404)
    else:
        return make_response(jsonify(missing="GUID or filename must be specified"), 418)

    if 'title' in request.form:
        title = request.form['title']
    else:
        title = "Untitled"

#     e.g. curl --cacert ca.crt -X POST https://viz2.dave.cyberska.org/v1/viz\
#          --data title=foo --data filename=/some/path/here

    # Create the DB object
    # remember to create funky session identifiers

    newVizSessionID = util.genVizSessionID()
    expiryTime = mktime(gmtime()) + (long(request.form['expiry'])
                                     if 'expiry' in request.form else
                                     vizserv.config['DEFAULT_VIZSESSION_EXPIRY'])

    while True:
        try:
            newVizSession = model.VizSessions(
                session_id=newVizSessionID,
                title=title,
                filename=filename,
                timestamp=int(timestamp),
                fileGUID=guid,
                expiry=int(expiryTime)
            )

            db.session.add(newVizSession)
            db.session.commit()
            break
        except IntegrityError:
            # Session_ID conflict.  Need to change id and update
            db.session.rollback()
            newVizSessionID = util.genVizSessionID()

    global viz_sessions_created
    viz_sessions_created += 1

    # Return session identifier
    #return redirect(url_for('getVizSessionInfo',
    #                        session_id=newVizSessionID, _external=True))
    return redirect("%s%s" % (vizserv.config['ACCESS_URL_BASE'], newVizSessionID))

@vizserv.route('/')
@vizserv.route('/index')
def index():
    # curl http://localhost:8000/service/stats

    return make_response("RPI API implementation\n")


@vizserv.route('/v1/viz', methods=['GET', 'POST'])
def viz():
    if request.method == 'GET':
        # Delete expired session tokens
        db.session.query(model.VizSessions).\
            filter(model.VizSessions.expiry < mktime(gmtime())).delete()
        db.session.commit()

        return make_response(
            jsonify({
                'Sessions': [row.serialize
                             for row in
                             db.session.query(model.VizSessions).all()]
            }), 501)

    elif request.method == 'POST':
        # curl -i http://localhost:8000/v1/viz -X POST --data title="somme title" --data filename="some filename" --data timestamp=123 --data fileGUID="foo:123"
        # (can use resulting URL to test retrieving session)
        return createVizSession()


@vizserv.route('/v1/viz/<session_id>', methods=['GET'])
def getVizSessionInfo(session_id):

    # Delete expired session tokens
    db.session.query(model.VizSessions).\
        filter(model.VizSessions.expiry < mktime(gmtime())).delete()
    db.session.commit()

    s = model.VizSessions.query.get(session_id)

    if s is None:
        return make_response(jsonify(error='No valid session found'), 404)
    else:
        return make_response(jsonify(s.serialize), 200)


@vizserv.route('/service/stats', methods=['GET'])
def getMonitoring():
    # curl http://localhost:8000/service/stats
    global start_time
    global viz_sessions_created

    return make_response(jsonify(lastReset=start_time, invocations=viz_sessions_created))
