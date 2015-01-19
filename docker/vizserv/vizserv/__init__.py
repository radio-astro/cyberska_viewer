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

__author__ = 'David Aikema'
__author_email__ = '<dhaikema@ucalgary.ca>'
__version__ = '0.1.0'
__name__ = 'vizserv'
__synopsis__ = """
This service manages session info for a service enabling
users to visualize astronomical images that are available
on the web using their web browser.
"""
__institution__ = 'Institute for Space Imaging Science'
__release__ = '2013-08-01T00:00:00Z'


from flask import Flask
from flask.ext.sqlalchemy import SQLAlchemy
import datetime
import platform
from vizserv import __name__

# Initialize flask
vizserv = Flask(__name__)
vizserv.config.from_object('vizserv.default_settings')

# Initialize logging
if not vizserv.debug and not vizserv.testing:
    import logging
    vizserv.logger.setLevel(logging.DEBUG)

# Initialize database
db = SQLAlchemy(vizserv)
from vizserv import model
db.create_all()

# Setup monitoring information
start_time = datetime.datetime.utcnow().isoformat().split('.')[0] + 'Z'
viz_sessions_created = 0

# Setup request handling
from vizserv import main
