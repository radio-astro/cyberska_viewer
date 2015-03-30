import os


# Database information
# Using sqlite for testing purposes for now
SQLALCHEMY_DATABASE_URI = 'sqlite:////var/vizserv/vizserv.db'

# VisPoolMan credentials
VISPOOLMAN_CRED = 'only used for SSL'

REDIRECT_URI = os.environ.get('REDIRECT_URI', 'http://127.0.0.1:8080/pureweb/')

# Where to direct the session to?
ACCESS_URL_BASE = "%s/app?name=FitsViewer&client=html5&key=" % REDIRECT_URI

# Lifetime of visualization session tokens in seconds
DEFAULT_VIZSESSION_EXPIRY = 60

