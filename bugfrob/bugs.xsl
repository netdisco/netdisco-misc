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
     assume that there's news, or force the caller to specify -->
<xsl:param name="grpid">
 <xsl:variable name="grpid" select="//field[@name='group_id']/@group_id"/>
 <xsl:if test="not($grpid)">
   <xsl:message terminate="yes">
     Cannot determine the SourceForge Group ID from this file.  Please
     supply the grpid parameter.
   </xsl:message>
 </xsl:if>
 <xsl:value-of select="$grpid"/>
</xsl:param>

  <!-- remove the xslt default template for outputting any text -->
  <xsl:template match="text()"/>

<xsl:template match="//artifacts">
<table border="1">
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
Priority
</th>
<th>
Summary
</th>
</tr>
<xsl:for-each select="artifact[field[@name='status']='Open']">
<xsl:sort select="field[@name='artifact_group_id']"/>
<xsl:sort select="field[@name='priority']" order="descending" data-type="number"/>
<xsl:sort select="field[@name='open_date']" data-type="number"/>
<tr>
<td>
[
<a>
<xsl:attribute name="href">
https://sourceforge.net/tracker/?func=detail&amp;group_id=<xsl:value-of select="$grpid"/>&amp;atid=<xsl:call-template name="atid"/>&amp;aid=<xsl:value-of select="field[@name='artifact_id']"/>
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
<xsl:value-of select="field[@name='priority']"/>
</td>
<td>
<xsl:value-of select="field[@name='summary']"/>
</td>
</tr>
</xsl:for-each>
</table>
</xsl:template>

<xsl:template name="atid">
  <xsl:variable name="atid" select="document('tracker-map.xml')/map/group[@id=$grpid]/tracker[@name=current()/field[@name='artifact_type']]/@atid"/>
  <xsl:if test="not($atid)">
    <xsl:message terminate="yes">
    Can't map group <xsl:value-of select="$grpid"/> and artifact type "<xsl:value-of select="field[@name='artifact_type']"/>"
    to an atid using tracker-map.xml .  Please ensure the proper
    mapping is present.
    </xsl:message>
  </xsl:if>
  <xsl:value-of select="$atid"/>
</xsl:template>

</xsl:stylesheet>
