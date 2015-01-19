import sys

path = '/var/vizserv'
if path not in sys.path:
    sys.path.insert(1, '/var/vizserv')

from vizserv import vizserv as application
