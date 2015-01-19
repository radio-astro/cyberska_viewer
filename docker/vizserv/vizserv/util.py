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

from flask import request
from vizserv import vizserv
import subprocess
import os

def getPureWebStats():
    """
    Retrieve information about PureWeb system activity.
    """
    return False


def genVizSessionID():
    """
    Generate a random identifer for a visualization session.
    """
    import random
    import string

    lst = [random.choice(string.ascii_letters + string.digits)
           for n in xrange(32)]
    return ("".join(lst))


def check_authorized():
    """
    Report if the user is authorized.  Here that means that the request
    originates from localhost or the VisPoolMan defined in the configuration
    """
    if (request.remote_addr == '127.0.0.1'):
        return True
    elif ('SSL_CLIENT_S_DN' in request.environ
          and request.environ.get('SSL_CLIENT_S_DN')
          == vizserv.config['VISPOOLMAN_CRED']
          and 'SSL_CLIENT_VERIFY' in request.environ
          and request.environ.get('SSL_CLIENT_VERIFY') == 'SUCCESS'
          and 'SSL_CLIENT_V_REMAIN' in request.environ
          and float(request.environ.get('SSL_CLIENT_V_REMAIN')) > 0
          ):
        return True
    else:
        return False


def getFileInfoFromGUID(guid):
    """
    Retrieve file pathname and timestamp for a particular GUID.
    
    Returns a tuple (filepath, timestamp) or (None, None) if the file cannot be found.
    """
    
    if 'IQUEST_CMD' in vizserv.config:
    	try:
    	    query = "select COLL_NAME, DATA_NAME, DATA_MODIFY_TIME where META_DATA_ATTR_NAME = 'GUID' and META_DATA_ATTR_VALUE = '{0:d}'".format(int(guid))
            results = subprocess.check_output([vizserv.config['IQUEST_CMD'], query], stderr=None)
            
            kdict = {}
            
            for l in results.split("\n"):
                try:
                    k,v = l.split('=')
                    kdict[k.strip()] = v.strip()
                except:
                    pass

            if 'COLL_NAME' in kdict and 'DATA_NAME' in kdict and 'DATA_MODIFY_TIME' in kdict:
                return (
                    "{0}{1}{2}".format(kdict['COLL_NAME'], os.sep, kdict['DATA_NAME']),
                    int(kdict['DATA_MODIFY_TIME'].lstrip("0"))
                    )
        except Exception:
            return (None, None)
    
    
    return (None, None)

