Invenio INSTALLATION
====================


Prerequisites
================


     a) Scelta del sistema operativo:

        Debian, Gentoo, Scientific Linux (aka RHEL),
        Ubuntu
        Per oAr è stato scelto:

        Ubuntu 14.04.3 LTS (GNU/Linux 3.13.0-62-generic x86_64)


        If you are using Debian GNU/Linux ``Lenny'' or later, then you
        can install most of the below-mentioned prerequisites and
        recommendations by running:

          $ sudo aptitude install python-dev apache2-mpm-prefork \
              mysql-server mysql-client python-mysqldb \
              python-4suite-xml python-simplejson python-xml \
              gnuplot poppler-utils \
              gs-common clisp gettext libapache2-mod-wsgi unzip \
              python-dateutil python-rdflib python-pyparsing \
              python-gnuplot python-magic pdftk html2text giflib-tools \
              pstotext netpbm python-pypdf python-chardet python-lxml \
              python-unidecode redis-server python-redis

        You may also want to install some of the following packages,
        if you have them available on your concrete architecture:

          $ sudo aptitude install sbcl cmucl pylint pychecker pyflakes \
              python-profiler python-epydoc libapache2-mod-xsendfile \
              openoffice.org python-utidylib python-beautifulsoup \
              libhdf5-dev

        (Note that if you use pip to manage your Python dependencies
        instead of operating system packages, please see the section
        (d) below on how to use pip instead of aptitude.)

        Moreover, you should install some Message Transfer Agent (MTA)
        such as Postfix so that Invenio can email notification
        alerts or registration information to the end users, contact
        moderators and reviewers of submitted documents, inform
        administrators about various runtime system information, etc:

          $ sudo aptitude install postfix

        *Attenzione verificare che il firewall e altre regole permettono
        l'invio di mail a tutti.*



     b) MySQL server (*may be on a remote machine*), and MySQL client
        (must be available locally too).  MySQL versions 4.1 or 5.0
        are supported.
        -  Please set the variable "max_allowed_packet"
        in your "my.cnf" init file to at least 4M.
        You may perhaps also want to run your MySQL server
        natively in UTF-8 mode by setting "default-character-set=utf8"
        in various parts of your "my.cnf" file, such as in the
        "[mysql]" part and elsewhere;
        but this is not really required.
        Maggiori Info: <http://mysql.com/>



     c) Redis server (may be on a remote machine) for user session
        management and caching purposes.  By default, Invenio would
        use Redis to store sessions, so it is highly recommended to
        install it.  However, if you do not want to use Redis, you can
        change CFG_WEBSESSION_STORAGE settings in invenio-local.conf
        and MySQL will be used for session management instead.
        <http://redis.io/>

        In OAR lo storage è settato su mysql
        Inserito in invenio-local.conf

        CFG_WEBSESSION_STORAGE = mysql


     d) Apache 2 server, with support for loading DSO modules, and
        optionally with SSL support for HTTPS-secure user
        authentication, and mod_xsendfile for off-loading file
        downloads away from Invenio processes to Apache.
          <http://httpd.apache.org/>
          <http://tn123.ath.cx/mod_xsendfile/>


     e) Python v2.6 or above:
          <http://python.org/>

         OAR : Python 2.7.6

        as well as the following Python modules:
          - (mandatory) MySQLdb (version >= 1.2.1_p2; see below)
             <http://sourceforge.net/projects/mysql-python>
          - (mandatory) Pyparsing, for document parsing
             <http://pyparsing.wikispaces.com/>
          - (mandatory) unidecode, for ASCII representation of Unicode text:
             <https://pypi.python.org/pypi/Unidecode>
          - (recommended) Redis connector:
             <https://pypi.python.org/pypi/redis/>
          - (recommended) Nydus, Redis consistent hashing connector:
             <https://github.com/disqus/nydus>
          - (recommended) python-dateutil, for complex date processing:
             <http://labix.org/python-dateutil>
          - (recommended) PyRXP, for very fast XML MARC processing:
             <http://www.reportlab.org/pyrxp.html>
          - (recommended) lxml, for XML/XLST processing:
             <http://lxml.de/>
          - (recommended) Gnuplot.Py, for producing graphs:
             <http://gnuplot-py.sourceforge.net/>
          - (recommended) Snowball Stemmer, for stemming:
             <http://snowball.tartarus.org/wrappers/PyStemmer-1.0.1.tar.gz>
          - (recommended) py-editdist, for record merging:
             <http://www.mindrot.org/projects/py-editdist/>
          - (recommended) numpy, for citerank methods:
             <http://numpy.scipy.org/>
          - (recommended) magic, for full-text file handling:
             <http://www.darwinsys.com/file/>
          - (recommended) cerberus, extensible validation for Python dictionaries.
             <http://cerberus.readthedocs.org/>
          - (optional) libxml2-python, for XML/XLST processing:
             <ftp://xmlsoft.org/libxml2/python/>
          - (optional) chardet, for character encoding detection:
             <http://chardet.feedparser.org/>
          - (optional) 4suite, slower alternative to PyRXP and
             libxml2-python:
             <http://4suite.org/>
          - (optional) feedparser, for web journal creation:
             <http://feedparser.org/>
          - (optional) RDFLib, to use RDF ontologies and thesauri:
             <http://rdflib.net/>
          - (optional) mechanize, to run regression web test suite:
             <http://wwwsearch.sourceforge.net/mechanize/>
          - (optional) python-mock, mocking library for the test suite:
             <http://www.voidspace.org.uk/python/mock/>
          - (optional) utidylib, for HTML washing:
             <http://utidylib.berlios.de/>
          - (optional) Beautiful Soup, for HTML washing:
             <http://www.crummy.com/software/BeautifulSoup/>
          - (optional) Python Twitter (and its dependencies) if you want
             to use the Twitter Fetcher bibtasklet:
             <http://code.google.com/p/python-twitter/>
          - (optional) Python OpenID if you want to enable OpenID support
             for authentication:
             <http://pypi.python.org/pypi/python-openid/>
          - (optional) Python Rauth if you want to enable OAuth 1.0/2.0
             support for authentication (depends on Python-2.6 or later):
             <http://packages.python.org/rauth/>
          - (optional) libhdf5-7, libhdf5-dev, python-h5py, in order to
             run author disambiguation.
             <https://code.google.com/p/h5py/>

        Note that if you are using pip to install and manage your
        Python dependencies, then you can run:

          $ sudo pip install -r requirements.txt
          $ sudo pip install -r requirements-extras.txt

        to install all manadatory, recommended, and optional packages
        mentioned above.

     f) mod_wsgi Apache module.  Versions 3.x and above are
        recommended.
          <http://code.google.com/p/modwsgi/>

     g) If you want to be able to extract references from PDF fulltext
        files, then you need to install pdftotext version 3 at least.
          <http://poppler.freedesktop.org/>
          <http://www.foolabs.com/xpdf/home.html>

     h) If you want to be able to search for words in the fulltext
        files (i.e. to have fulltext indexing) or to stamp submitted
        files, then you need as well to install some of the following
        tools:
          - for Microsoft Office/OpenOffice.org document conversion:
                OpenOffice.org
              <http://www.openoffice.org/>
          - for PDF file stamping: pdftk, pdf2ps
              <http://www.accesspdf.com/pdftk/>
              <http://www.cs.wisc.edu/~ghost/doc/AFPL/>
          - for PDF files: pdftotext or pstotext
              <http://poppler.freedesktop.org/>
              <http://www.foolabs.com/xpdf/home.html>
              <http://www.cs.wisc.edu/~ghost/doc/AFPL/>
          - for PostScript files: pstotext or ps2ascii
              <http://www.cs.wisc.edu/~ghost/doc/AFPL/>
          - for DjVu creation, elaboration: DjVuLibre
              <http://djvu.sourceforge.net>
          - to perform OCR: OCRopus (tested only with release 0.3.1)
              <http://code.google.com/p/ocropus/>
          - to perform different image elaborations: ImageMagick
              <http://www.imagemagick.org/>
          - to generate PDF after OCR: netpbm, ReportLab and pyPdf or pyPdf2
              <http://netpbm.sourceforge.net/>
              <http://www.reportlab.org/rl_toolkit.html>
              <http://pybrary.net/pyPdf/>
              <http://knowah.github.io/PyPDF2/>

     i) If you have chosen to install fast XML MARC Python processors
        in the step d) above, then you have to install the parsers
        themselves:
          - (optional) 4suite:
             <http://4suite.org/>

     j) (recommended) Gnuplot, the command-line driven interactive
        plotting program.  It is used to display download and citation
        history graphs on the Detailed record pages on the web
        interface.  Note that Gnuplot must be compiled with PNG output
        support, that is, with the GD library.  Note also that Gnuplot
        is not required, only recommended.
          <http://www.gnuplot.info/>

     k) (recommended) A Common Lisp implementation, such as CLISP,
        SBCL or CMUCL.  It is used for the web server log analysing
        tool and the metadata checking program.  Note that any of the
        three implementations CLISP, SBCL, or CMUCL will do.  CMUCL
        produces fastest machine code, but it does not support UTF-8
        yet.  Pick up CLISP if you don't know what to do.  Note that a
        Common Lisp implementation is not required, only recommended.
          <http://clisp.cons.org/>
          <http://www.cons.org/cmucl/>
          <http://sbcl.sourceforge.net/>

     l) GNU gettext, a set of tools that makes it possible to
        translate the application in multiple languages.
           <http://www.gnu.org/software/gettext/>
        This is available by default on many systems.

     m) (recommended) xlwt 0.7.2, Library to create spreadsheet files
        compatible with MS Excel 97/2000/XP/2003 XLS files, on any
        platform, with Python 2.3 to 2.6
           <http://pypi.python.org/pypi/xlwt>

     n) (recommended) matplotlib 1.0.0 is a python 2D plotting library
             which produces publication quality figures in a variety of
        hardcopy formats and interactive environments across
        platforms. matplotlib can be used in python scripts, the
        python and ipython  shell (ala MATLAB®        or Mathematica®),
        web application servers, and six graphical user        interface
        toolkits. It is used to generate pie graphs in the custom
        summary query (WebStat)
           <http://matplotlib.sourceforge.net>

     o) PER VIDEO - INSTALLARE - FFmpeg -
         an open-source tools an libraries collection
        to convert video and audio files. It makes use of both internal
        as well as external libraries to generate videos for the web, such
        as Theora, WebM and H.264 out of almost any thinkable video input.
        FFmpeg is needed to run video related modules and submission workflows
        in Invenio. The minimal configuration of ffmpeg for the Invenio demo site
        requires a number of external libraries. It is highly recommended
        to remove all installed versions and packages that are comming with
        various Linux distributions and install the latest versions from
        sources. Additionally, you will need the Mediainfo Library for multimedia
        metadata handling.
        - the ffmpeg multimedia encoder tools
          <http://ffmpeg.org/>
        - a library for jpeg images needed for thumbnail extraction
          <http://www.openjpeg.org/>
        - a library for the ogg container format, needed for Vorbis and Theora
          <http://www.xiph.org/ogg/>
        - the OGG Vorbis audi codec library
          <http://www.vorbis.com/>
        - the OGG Theora video codec library
          <http://www.theora.org/>
        - the WebM video codec library
          <http://www.webmproject.org/>
        - the mediainfo library for multimedia metadata
          <http://mediainfo.sourceforge.net/>
        *Recommended* for H.264 video (!be aware of licensing issues!):
        - a library for H.264 video encoding
          <http://www.videolan.org/developers/x264.html>
        - a library for Advanced Audi Coding
          <http://www.audiocoding.com/faac.html>
        - a library for MP3 encoding
          <http://lame.sourceforge.net/>


Installation
----------------

    The Invenio uses standard GNU autoconf method to build and
    install its files.  This means that you proceed as follows:

      $ cd $HOME/src/

       Per OAR cd /opt

          - Change to a directory where we will build the Invenio
          sources.


      $ wget http://invenio-software.org/download/invenio-1.2.1.tar.gz
      $ wget http://invenio-software.org/download/invenio-1.2.1.tar.gz.md5
      $ wget http://invenio-software.org/download/invenio-1.2.1.tar.gz.sig

          Fetch Invenio source tarball from the distribution server,
          together with MD5 checksum and GnuPG cryptographic signature
          files useful for verifying the integrity of the tarball.

      $ md5sum -c invenio-1.2.1.tar.gz.md5

          Verify MD5 checksum.

      $ gpg --verify invenio-1.2.1.tar.gz.sig invenio-1.2.1.tar.gz

          Verify GnuPG cryptographic signature.  Note that you may
          first have to import my public key into your keyring, if you
          haven't done that already:
            $ gpg --keyserver pool.sks-keyservers.net --recv-key 0xBA5A2B67
          The output of the gpg --verify command should then read:
            Good signature from "Tibor Simko <tibor@simko.info>"
          You can safely ignore any trusted signature certification
          warning that may follow after the signature has been
          successfully verified.

      $ tar xvfz invenio-1.2.1.tar.gz

          Untar the distribution tarball.

      $ cd invenio-1.2.1

          Go to the source directory.

      $ ./configure

       Per OAR lanciato senza altri parametri.

        ______________________________
          Configure Invenio software for building on this specific
          platform.  You can use the following optional parameters:
         Nel Dettaglio :
              --prefix=/opt/invenio

                 Optionally, specify the Invenio general
                 installation directory (default is /opt/invenio).
                 It will contain command-line binaries and program
                 libraries containing the core Invenio
                 functionality, but also store web pages, runtime log
                 and cache information, document data files, etc.
                 Several subdirs like `bin', `etc', `lib', or `var'
                 will be created inside the prefix directory to this
                 effect.  Note that the prefix directory should be
                 chosen outside of the Apache htdocs tree, since only
                 one its subdirectory (prefix/var/www) is to be
                 accessible directly via the Web (see below).

                 Note that Invenio won't install to any other
                 directory but to the prefix mentioned in this
                 configuration line.

              --with-python=/opt/python/bin/python2.7

                 Optionally, specify a path to some specific Python
                 binary.  This is useful if you have more than one
                 Python installation on your system.  If you don't set
                 this option, then the first Python that will be found
                 in your PATH will be chosen for running Invenio.

              --with-mysql=/opt/mysql/bin/mysql

                 Optionally, specify a path to some specific MySQL
                 client binary.  This is useful if you have more than
                 one MySQL installation on your system.  If you don't
                 set this option, then the first MySQL client
                 executable that will be found in your PATH will be
                 chosen for running Invenio.

              --with-clisp=/opt/clisp/bin/clisp

                 Optionally, specify a path to CLISP executable.  This
                 is useful if you have more than one CLISP
                 installation on your system.  If you don't set this
                 option, then the first executable that will be found
                 in your PATH will be chosen for running Invenio.

              --with-cmucl=/opt/cmucl/bin/lisp

                 Optionally, specify a path to CMUCL executable.  This
                 is useful if you have more than one CMUCL
                 installation on your system.  If you don't set this
                 option, then the first executable that will be found
                 in your PATH will be chosen for running Invenio.

              --with-sbcl=/opt/sbcl/bin/sbcl

                 Optionally, specify a path to SBCL executable.  This
                 is useful if you have more than one SBCL
                 installation on your system.  If you don't set this
                 option, then the first executable that will be found
                 in your PATH will be chosen for running Invenio.

              --with-openoffice-python

                 Optionally, specify the path to the Python interpreter
                 embedded with OpenOffice.org. This is normally not
                 contained in the normal path. If you don't specify this
                 it won't be possible to use OpenOffice.org to convert from and
                 to Microsoft Office and OpenOffice.org documents.
            ______________________________________________

          This configuration step is mandatory.  Usually, you do this
          step only once.

          (Note that if you are building Invenio not from a
          released tarball, but from the Git sources, then you have to
          generate the configure file via autotools:

              $ sudo aptitude install automake1.9 autoconf
              $ aclocal-1.9
              $ automake-1.9 -a
              $ autoconf

          after which you proceed with the usual configure command.)

      $ make

          Launch the Invenio build.  Since many messages are printed
          during the build process, you may want to run it in a
          fast-scrolling terminal such as rxvt or in a detached screen
          session.

          During this step all the pages and scripts will be
          pre-created and customized based on the config you have
          edited in the previous step.

          Note that on systems such as FreeBSD or Mac OS X you have to
          use GNU make ("gmake") instead of "make".

      $ make install

          Install the web pages, scripts, utilities and everything
          needed for Invenio runtime into respective installation
          directories, as specified earlier by the configure command.

          Note that if you are installing Invenio for the first
          time, you will be asked to create symbolic link(s) from
          Python's site-packages system-wide directory(ies) to the
          installation location.  This is in order to instruct Python
          where to find Invenio's Python files.  You will be
          hinted as to the exact command to use based on the
          parameters you have used in the configure command.

      $ make install-mathjax-plugin

          This will automatically download and install in the proper
          place MathJax, a JavaScript library to render LaTeX formulas
          in the client browser.

          Note that in order to enable the rendering you will have to
          set the variable CFG_WEBSEARCH_USE_MATHJAX_FOR_FORMATS in
          invenio-local.conf to a suitable list of output format
          codes. For example:
          CFG_WEBSEARCH_USE_MATHJAX_FOR_FORMATS = hd,hb

      $ make install-jquery-plugins

          This will automatically download and install in the proper
          place jQuery and related plugins.  They are used for AJAX
          applications such as the record editor.

          Note that `unzip' is needed when installing jquery plugins.

      $ make install-ckeditor-plugin

          This will automatically download and install in the proper
          place CKeditor, a WYSIWYG Javascript-based editor (e.g. for
          the WebComment module).

          Note that in order to enable the editor you have to set the
          CFG_WEBCOMMENT_USE_RICH_EDITOR to True.

      $ make install-pdfa-helper-files ## optional

          This will automatically download and install in the proper
          place the helper files needed to create PDF/A files out of
          existing PDF files.

      $ make install-mediaelement

          This will automatically download and install the MediaElementJS
          HTML5 video player that is needed for videos on the DEMO site.

      $ make install-solrutils

          This will automatically download and install a Solr instance
          which can be used for full-text searching.  See CFG_SOLR_URL
          variable in the invenio.conf.  Note that the admin later has
          to take care of running init.d scripts which would start the
          Solr instance automatically.

      $ make install-js-test-driver  ## optional

          This will automatically download and install JsTestDriver
          which is needed to run JS unit tests. Recommended for developers.

Configuration
-----------------

    Once the basic software installation is done, we proceed to
    configuring your Invenio system.

      $ sudo chown -R www-data.www-data /opt/invenio

          For the sake of simplicity, let us assume that your Invenio
          installation will run under the `www-data' user process
          identity.  The above command changes ownership of installed
          files to www-data, so that we shall run everything under
          this user identity from now on.

          For production purposes, you would typically enable Apache
          server to read all files from the installation place but to
          write only to the `var' subdirectory of your installation
          place.  You could achieve this by configuring Unix directory
          group permissions, for example.

      $ sudo -u www-data vim /opt/invenio/etc/invenio-local.conf

          Customize your Invenio installation.  Please read the
          'invenio.conf' file located in the same directory that
          contains the vanilla default configuration parameters of
          your Invenio installation.  If you want to customize some of
          these parameters, you should create a file named
          'invenio-local.conf' in the same directory where
          'invenio.conf' lives and you should write there only the
          customizations that you want to be different from the
          vanilla defaults.

          Here is a realistic, minimalist, yet production-ready
          example of what you would typically put there:

             $ cat /opt/invenio/etc/invenio-local.conf

		[Invenio]
		CFG_SITE_URL = http://oar.sci-gaia.eu
		CFG_SITE_SECURE_URL = http://oar.sci-gaia.eu
		CFG_DATABASE_NAME = OARInvenio
		CFG_DATABASE_USER = invenio
		CFG_DATABASE_PASS = oarinvenio
		CFG_SITE_ADMIN_EMAIL =  admin@sci-gaia.eu
		CFG_SITE_SUPPORT_EMAIL = admin@sci-gaia.eu
		CFG_WEBALERT_ALERT_ENGINE_EMAIL = admin@sci-gaia.eu
		CFG_WEBCOMMENT_ALERT_ENGINE_EMAIL = opendata_log@ct.infn.it
		CFG_WEBCOMMENT_DEFAULT_MODERATOR = admin@sci-gaia.eu
		CFG_BIBAUTHORID_AUTHOR_TICKET_ADMIN_EMAIL = admin@sci-gaia.eu
		CFG_SITE_NAME = Open Access Repository
		CFG_SITE_LANG = en
		CFG_SITE_LANGS = en,fr
		CFG_SITE_NAME_INTL_en = Open Access Repository
		CFG_SITE_NAME_INTL_fr = Open Access Repository
		CFG_BIBCATALOG_SYSTEM_EMAIL_ADDRESS = admin@sci-gaia.eu
		CFG_MISCUTIL_SMTP_HOST = mbox.ct.infn.it
		CFG_BIBSCHED_PROCESS_USER = www-data
		CFG_WEBSESSION_STORAGE = mysql
		CFG_PATH_FFMPEG = /usr/local/bin/ffmpeg
		CFG_PATH_FFPROBE = /usr/local/bin/ffprobe
		CFG_PATH_MEDIAINFO = /usr/bin/mediainfo
		CFG_WEBCOMMENT_USE_RICH_EDITOR = true
		CFG_WEBSEARCH_USE_MATHJAX_FOR_FORMATS = hd,hb
		CFG_WEBCOMMENT_USE_MATHJAX_IN_COMMENTS = 1
		CFG_WEBSUBMIT_USE_MATHJAX = 1
		CFG_MATHJAX_HOSTING = local
		CFG_BIBINDEX_REMOVE_HTML_MARKUP = 1
		CFG_MATHJAX_RENDERS_MATHML = 0
		CFG_WEBSEARCH_USE_JSMATH_FOR_FORMATS = hd,hb
		CFG_BIBEDIT_KB_INSTITUTIONS = InstitutionsCollection
		CFG_BIBEDIT_AUTOCOMPLETE_INSTITUTIONS_FIELDS = 100__u,700__u,701__u,502__c
		CFG_OAI_ID_PREFIX = oar.sci-gaia.eu
		CFG_OAI_SAMPLE_IDENTIFIER = oai:oar.sci-gaia.eu:890
		CFG_OAI_IDENTIFY_DESCRIPTION = <description>
  			<eprints xmlns="http://www.openarchives.org/OAI/1.1/eprints"
           		xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
           		xsi:schemaLocation="http://www.openarchives.org/OAI/1.1/eprints
                               http://www.openarchives.org/OAI/1.1/eprints.xsd">
      			<content>
       			<URL>http://oar.sci-gaia.eu/</URL>
      			</content>
      			<metadataPolicy>
       			<text>Free and unlimited use by anybody with obligation to refer to original record</text>
      			</metadataPolicy>
      			<dataPolicy>
       			<text>1. Access to some or all full items is controlled.the content is not changed in any way3. Full items must not be harvested by robots except transiently for full-text indexing or citation analysis4. Full items must not be sold commercially in any format or medium without formal permission of the copyright holders.5. This repository is not the publisher; it is merely the online archive.</text>
      			</dataPolicy>
      			<submissionPolicy>
       			<text>Submission restricted. Submitted documents are subject of approval by OAI repository admins.</text>
      			</submissionPolicy>
  			</eprints>
 			</description>



          You should override at least the parameters mentioned above
          in order to define some very essential runtime parameters
          such as the name of your document server (CFG_SITE_NAME and
          CFG_SITE_NAME_INTL_*), the visible URL of your document
          server (CFG_SITE_URL and CFG_SITE_SECURE_URL), the email
          address of the local Invenio administrator, comment
          moderator, and alert engine (CFG_SITE_SUPPORT_EMAIL,
          CFG_SITE_ADMIN_EMAIL, etc), and last but not least your
          database credentials (CFG_DATABASE_*).

          If this is a first installation of Invenio it is recommended
          you set the CFG_BIBDOCFILE_ENABLE_BIBDOCFSINFO_CACHE
          variable to 1. If this is instead an upgrade from an existing
          installation don't add it until you have run:
          $ bibdocfile --fix-bibdocfsinfo-cache .

          The Invenio system will then read both the default
          invenio.conf file and your customized invenio-local.conf
          file and it will override any default options with the ones
          you have specifield in your local file.  This cascading of
          configuration parameters will ease your future upgrades.


      $ sudo -u www-data /opt/invenio/bin/inveniocfg --update-all

          Make the rest of the Invenio system aware of your
          invenio-local.conf changes.  This step is mandatory each
          time you edit your conf files.

      $ sudo -u www-data /opt/invenio/bin/inveniocfg --create-tables

          If you are installing Invenio for the first time, you
          have to create database tables.

          Note that this step checks for potential problems such as
          the database connection rights and may ask you to perform
          some more administrative steps in case it detects a problem.
          Notably, it may ask you to set up database access
          permissions, based on your configure values.

          If you are installing Invenio for the first time, you
          have to create a dedicated database on your MySQL server
          that the Invenio can use for its purposes.  Please
          contact your MySQL administrator and ask him to execute the
          commands this step proposes you.

          At this point you should now have successfully completed the
          "make install" process.  We continue by setting up the
          Apache web server.

      $ sudo -u www-data /opt/invenio/bin/inveniocfg --load-bibfield-conf

          Load the configuration file of the BibField module.  It will
          create `bibfield_config.py' file.  (FIXME: When BibField
          becomes essential part of Invenio, this step should be later
          automatised so that people do not have to run it manually.)

      $ sudo -u www-data /opt/invenio/bin/inveniocfg --load-webstat-conf

          Load the configuration file of webstat module. It will create
          the tables in the database for register customevents, such as
          basket hits.

      $ sudo -u www-data /opt/invenio/bin/inveniocfg --create-apache-conf

          Running this command will generate Apache virtual host
          configurations matching your installation.  You will be
          instructed to check created files (usually they are located
          under /opt/invenio/etc/apache/) and edit your httpd.conf
          to activate Invenio virtual hosts.

__________________________________
         Questa parte ancora su oar non è stata fatta. Aspettiamo Fargetta.

          If you are using Debian GNU/Linux ``Lenny'' or later, then
          you can do the following to create your SSL certificate and
          to activate your Invenio vhosts:

              ## make SSL certificate:
              $ sudo aptitude install ssl-cert
              $ sudo mkdir /etc/apache2/ssl
              $ sudo /usr/sbin/make-ssl-cert /usr/share/ssl-cert/ssleay.cnf \
                     /etc/apache2/ssl/apache.pem

              ## add Invenio web sites:
              $ sudo ln -s /opt/invenio/etc/apache/invenio-apache-vhost.conf \
                           /etc/apache2/sites-available/invenio
              $ sudo ln -s /opt/invenio/etc/apache/invenio-apache-vhost-ssl.conf \
                           /etc/apache2/sites-available/invenio-ssl
_______________________________________

              ## disable Debian's default web site:
              $ sudo /usr/sbin/a2dissite default

              ## enable Invenio web sites:
              $ sudo /usr/sbin/a2ensite invenio


              ##$ sudo /usr/sbin/a2ensite invenio-ssl

              ## enable SSL module:
              ##$ sudo /usr/sbin/a2enmod ssl

              ## if you are using xsendfile module, enable it too:
              $ sudo /usr/sbin/a2enmod xsendfile

          If you are using another operating system, you should do the
          equivalent, for example edit your system-wide httpd.conf and
          put the following include statements:

             Include /opt/invenio/etc/apache/invenio-apache-vhost.conf
             Include /opt/invenio/etc/apache/invenio-apache-vhost-ssl.conf

          Note that you may need to adapt generated vhost file
          snippets to match your concrete operating system specifics.
          For example, the generated configuration snippet will
          preload Invenio WSGI daemon application upon Apache start up
          for faster site response.  The generated configuration
          assumes that you are using mod_wsgi version 3 or later.  If
          you are using the old legacy mod_wsgi version 2, then you
          would need to comment out the WSGIImportScript directive
          from the generated snippet, or else move the WSGI daemon
          setup to the top level, outside of the VirtualHost section.

          Note also that you may want to tweak the generated Apache
          vhost snippet for performance reasons, especially with
          respect to WSGIDaemonProcess parameters.  For example, you
          can increase the number of processes from the default value
          `processes=5' if you have lots of RAM and if many concurrent
          users may access your site in parallel.  However, note that
          you must use `threads=1' there, because Invenio WSGI daemon
          processes are not fully thread safe yet.  This may change in
          the future.

      $ sudo /etc/init.d/apache2 restart

          Please ask your webserver administrator to restart the
          Apache server after the above "httpd.conf" changes.

      $ sudo -u www-data /opt/invenio/bin/inveniocfg --check-openoffice

          If you plan to support MS Office or Open Document Format
          files in your installation, you should check whether
          LibreOffice or OpenOffice.org is well integrated with
          Invenio by running the above command.  You may be asked to
          create a temporary directory for converting office files
          with special ownership (typically as user nobody) and
          permissions.  Note that you can do this step later.

      $ sudo -u www-data /opt/invenio/bin/inveniocfg --create-demo-site
        Qui non l'ho testato ma possiamo fargli caricare il nostro demo site.

          This step is recommended to test your local Invenio
          installation.  It should give you our "Atlantis Institute of
          Science" demo installation, exactly as you see it at
          <http://demo.invenio-software.org/>.


      $ sudo -u www-data /opt/invenio/bin/inveniocfg --load-demo-records
           Qui non l'ho testato ma possiamo fargli caricare i nostri dati di  esempio.
          Optionally, load some demo records to be able to test
          indexing and searching of your local Invenio demo
          installation.

      $ sudo -u www-data /opt/invenio/bin/inveniocfg --run-unit-tests

          Optionally, you can run the unit test suite to verify the
          unit behaviour of your local Invenio installation.  Note
          that this command should be run only after you have
          installed the whole system via `make install'.

      $ sudo -u www-data /opt/invenio/bin/inveniocfg --run-regression-tests

           Optionally, you can run the full regression test suite to
           verify the functional behaviour of your local Invenio
           installation.  Note that this command requires to have
           created the demo site and loaded the demo records.  Note
           also that running the regression test suite may alter the
           database content with junk data, so that rebuilding the
           demo site is strongly recommended afterwards.

      $ sudo -u www-data /opt/invenio/bin/inveniocfg --run-web-tests

           Optionally, you can run additional automated web tests
           running in a real browser.  This requires to have Firefox
           with the Selenium IDE extension installed.
           <http://en.www.mozilla.com/en/firefox/>
           <http://selenium-ide.openqa.org/>

      $ sudo -u www-data /opt/invenio/bin/inveniocfg --remove-demo-records

          Optionally, remove the demo records loaded in the previous
          step, but keeping otherwise the demo collection, submission,
          format, and other configurations that you may reuse and
          modify for your own production purposes.

       ----------------------------------
        Comando da non eseguire -
      $ sudo -u www-data /opt/invenio/bin/inveniocfg --drop-demo-sitei

          Optionally, drop also all the demo configuration so that
          you'll end up with a completely blank Invenio system.
          However, you may want to find it more practical not to drop
          the demo site configuration but to start customizing from
          there.
      ---------------------
      $ firefox http://your.site.com/help/admin/howto-run

          In order to start using your Invenio installation, you
          can start indexing, formatting and other daemons as
          indicated in the "HOWTO Run" guide on the above URL.  You
          can also use the Admin Area web interfaces to perform
          further runtime configurations such as the definition of
          data collections, document types, document formats, word
          indexes, etc.

      $ sudo ln -s /opt/invenio/etc/bash_completion.d/inveniocfg \
                   /etc/bash_completion.d/inveniocfg

           Optionally, if you are using Bash shell completion, then
           you may want to create the above symlink in order to
           configure completion for the inveniocfg command.

--------------------------------------------------------------------------------
Configurazione EXTRA

work in progress
