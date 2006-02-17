# Magic Makefile to download XML data from sourceforge using
# adocman project and xsltproc it into a different presentation.
#
# $Id$
.SUFFIXES:	.html .xml

PROJECTS=	netdisco snmp-info

all:	${PROJECTS:=-summary.html}

clean:
	rm -f ${PROJECTS:=.html}

%-summary.html:	%.xml bugs.xsl tracker-map.xml
	xsltproc bugs.xsl $< > $@

%.xml:	%.grpid
	xml_export --group=`cat $*.grpid` > $@
