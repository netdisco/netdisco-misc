<?xml version="1.0"?>
<!--

  Transform the Sourceforge XML artifacts format to HTML in a
  different way than Sourceforge does.

  $Id$

-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">
  <xsl:output method="html" />

<!-- grpid is not in the artifacts, but is in the news.
     assume that there's news. -->
<xsl:param name="grpid" select="//field[@name='group_id']/@group_id"
/>

  <!-- remove the xslt default template for outputting any text -->
  <xsl:template match="text()"/>

<xsl:template match="//artifacts">
<table>
<tr>
<th>Bug #</th>
<th>
Type
</th>
<th>
Category
</th>
<th>
Target
</th>
<th>
Summary
</th>
</tr>
<xsl:for-each select="artifact[field[@name='status']='Open']">
<xsl:sort select="field[@name='artifact_group_id']"/>
<tr>
<td>
[
<a>
<xsl:attribute name="href">
https://sourceforge.net/tracker/?func=detail&amp;group_id=<xsl:value-of select="$grpid"/>&amp;atid=<xsl:value-of select="document('tracker-map.xml')/map/group[@id=$grpid]/tracker[@name=current()/field[@name='artifact_type']]/@atid"/>&amp;aid=<xsl:value-of select="field[@name='artifact_id']"/>
</xsl:attribute>
<xsl:value-of select="field[@name='artifact_id']"/>
</a>
]
</td>
<td>
<xsl:value-of select="field[@name='artifact_type']"/>
</td>
<td>
<xsl:value-of select="field[@name='category']"/>
</td>
<td>
<xsl:value-of select="field[@name='artifact_group_id']"/>
</td>
<td>
<xsl:value-of select="field[@name='summary']"/>
</td>
</tr>
</xsl:for-each>
</table>
</xsl:template>

</xsl:stylesheet>
