The service manages session tokens for visualization sessions
run on this machine.

It uses X.509 client authentication.  Apache 2.1 or greater is required for this to
function properly (+StdEnvVars).  Connections originating from localhost are also
accepted.

It's necessary to setup certificates for the server and client.  The VizPoolMan
certificate distinguished name (from which connections are permitted) is specified
in vizserv/default_settings.py as VISPOOLMAN_CRED)

Minimal config files for Apache (from Ubuntu 12.04.2LTS):
(which currently doesn't check a certificate revocation list)
---
# Only define this once globally
WSGIDaemonProcess vizserv threads=5

<VirtualHost 127.0.0.1:80>
        WSGIScriptAlias / /var/vizserv/vizserv.wsgi
        WSGIScriptReloading on

        <Directory /var/vizserv>
                WSGIProcessGroup vizserv
                WSGIApplicationGroup %{GLOBAL}

                Order deny,allow
                allow from all
        </Directory>
</VirtualHost>
<IfModule mod_ssl.c>
<VirtualHost _default_:443>
        WSGIScriptAlias / /var/vizserv/vizserv.wsgi
        WSGIScriptReloading on

        <Directory /var/vizserv>
                WSGIProcessGroup vizserv
                WSGIApplicationGroup %{GLOBAL}

                Order deny,allow
                allow from all
        </Directory>
        SSLEngine on
        SSLCertificateFile    /etc/ssl/certs/insert_your_cert_here
        SSLCertificateKeyFile /etc/ssl/private/insert_your_key_here

        SSLCACertificatePath /etc/ssl/certs/
        #SSLCACertificateFile /etc/apache2/ssl.crt/ca-bundle.crt
        SSLVerifyClient optional
        SSLVerifyDepth  10
        SSLOptions +StdEnvVars
</VirtualHost>
</IfModule>
---
