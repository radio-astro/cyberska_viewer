import os


# Database information
# Using sqlite for testing purposes for now
SQLALCHEMY_DATABASE_URI = 'sqlite:////var/vizserv/vizserv.db'

# VisPoolMan credentials
VISPOOLMAN_CRED = 'only used for SSL'

SERVER_NAME = os.environ.get('SERVER_NAME', '127.0.0.1')

# Where to direct the session to?
ACCESS_URL_BASE = "http://%s:8080/pureweb/app?name=FitsViewer&client=html5&key=" % SERVER_NAME

# Lifetime of visualization session tokens in seconds
DEFAULT_VIZSESSION_EXPIRY = 60

