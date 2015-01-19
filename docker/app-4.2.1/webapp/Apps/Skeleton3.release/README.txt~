There are two entries you may need to customize in this directory, both of
which can be symbolic links:

server : executable for the client/server, most likely pointing to
         wherever you actually build the application

html5 : directory suitable for the PureWeb environment

If you change the name of this directory (.):

1.) don't forget to adjust the <base href="..." /> tag inside the
serverIndex.html to take into account the actual name of this
directory. For example, if you name this directory XYZ, the tag should
probably look like this:

<base href="/Apps/XYZ/html5" />

2.) don't forget to adjust the respective ...plugin.xml inside the
conf/ directory so that it points to the appropriate html file
