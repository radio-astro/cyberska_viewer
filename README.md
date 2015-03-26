
About
=====

Docker files for the browser based Cyber SKA FITS file viewer.


Creating the image
==================

- install docker
- run `$ make`


Using the image
===============

This container runs on 2 ports, 8080 and 80. 80 is the start page,
where you will sent POST requests to. This will then redirect you
to the actual FITS viewer.


environment variables
---------------------

**SERVER_NAME**. where can we find the actual FITS viewer.

default 127.0.0.1


license file
------------

You need to have a license file to use this container. You can
'mount' the license file into the container using:

`-v pureweb.lic:/opt/CSI/PureWeb/Server/conf/pureweb.lic`
