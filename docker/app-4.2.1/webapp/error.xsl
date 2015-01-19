<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/HttpError">

<html>

<head>
<link rel="stylesheet" type="text/css" href='/themes/pureweb/pureweb.css'/>
<title><xsl:value-of select="StatusCode"/>&#160;<xsl:value-of select="StatusDescription"/></title>
</head>

<body>
<img src='/themes/pureweb/pureweb_serverpagelogo.png'/>
<div class="content">

<h1><xsl:value-of select="StatusCode"/>&#160;<xsl:value-of select="StatusDescription"/></h1>

<xsl:value-of select="Reason"/>
</div>
</body>

</html>

</xsl:template>
</xsl:stylesheet>
