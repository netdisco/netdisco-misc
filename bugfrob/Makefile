# Magic Makefile to download XML data from sourceforge using
# adocman project and xsltproc it into a different presentation.
#
# $Id$
.SUFFIXES:	.html .xml

PROJECTS=	netdisco snmp-info

all:	${PROJECTS:=-summary.html}

clean:
	rm -f ${PROJECTS:=-summary.html}

realclean:	clean
	rm -f ${PROJECTS:=.xml}

%-summary.html:	%.xml bugs.xsl tracker-map.xml
	xsltproc bugs.xsl $< > $@

%.xml:	%.grpid check-cookies
	xml_export --group=`cat $*.grpid` > $@

check-cookies:
	@cookie=$${HOME}/.sfadocmancookies; \
	 if [ -f $$cookie ]; then \
		now=`date +%Y%m%d`; \
		bad=`awk '\
			BEGIN { FS=": " } \
			/expires=/ { \
				split($$2, a, " *; *"); \
				for (cook in a) { \
					e = a[cook]; \
					if (match(e, /^expires=/)) { \
						bq = index(e, "\""); \
						dt = substr(e, bq + 1, 4) substr(e, bq + 6, 2) substr(e, bq + 9, 2); \
						if (dt < now) print "Your sourceforge cookie looks expired." \
					} \
				} \
			}' now=$$now $$cookie`; \
	 else \
		bad="No cookie file."; \
	 fi; \
	 if [ ! -z "$$bad" ]; then \
		echo $$bad; \
		echo "Run adocman --login --username=(sf username) --interactive"; \
		echo "And enter your sourceforge password."; \
		false; \
	 fi
