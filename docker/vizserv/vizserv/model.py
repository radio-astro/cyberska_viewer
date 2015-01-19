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

from flask import url_for
from vizserv import vizserv
from vizserv import db


class VizSessions (db.Model):
    # Here's the session identifier
    session_id = db.Column(db.String(32), primary_key=True)

    # The information needed to actually run the visualization
    title = db.Column(db.String)
    filename = db.Column(db.String)
    timestamp = db.Column(db.Integer)
    fileGUID = db.Column(db.String)

    # optional lifetime (in seconds)
    expiry = db.Column(db.Integer)

    @property
    def serialize(self):
        return {
            'accessURL': "%s%s"
            % (vizserv.config['ACCESS_URL_BASE'], self.session_id),
            'managementURL': url_for('getVizSessionInfo',
                                     session_id=self.session_id,
                                     _external=True),
            'session_id': self.session_id,
            'title': self.title,
            'filename': self.filename,
            'timestamp': self.timestamp,
            'fileGUID': self.fileGUID,
            'expiry': self.expiry
        }
