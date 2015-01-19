# Database information
# Using sqlite for testing purposes for now
SQLALCHEMY_DATABASE_URI = 'sqlite:////var/www/vizserv/vizserv.db'

# VisPoolMan credentials
VISPOOLMAN_CRED = '/CN=VisPoolMan/emailAddress=vispoolman@foo/O=U of C/OU=Dept. Physics/C=CA/ST=Alberta/L=Calgary'

# Where to direct the session to?
from socket import gethostname
ACCESS_URL_BASE = "http://" + gethostname() + ":8080/pureweb/app?name=FitsViewer&client=html5&key="

# Lifetime of visualization session tokens in seconds
DEFAULT_VIZSESSION_EXPIRY = 60

# Location of the iquest command if planning to retrieve file information using GUIDs
IQUEST_CMD = "/home/calsci/iRods3.1/iRODS/clients/icommands/bin/iquest"

## PureWeb status page location
#PUREWEB_STATUS_PAGE = "http://localhost:8080/app/status"
