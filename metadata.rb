name             "fisheye"
maintainer       "SecondMarket Labs, LLC"
maintainer_email "systems@secondmarket.com"
license          "All rights reserved"
description      "Installs/Configures Atlassian Fisheye"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.1"

supports "centos"

depends "java"
depends "postgresql"
depends "database"

recipe "fisheye::default", "empty"
recipe "fisheye::server", "Install fisheye server"
recipe "fisheye::local_database", "Install postgresql"

attribute "fisheye/version",
    :required => 'optional',
    :default => '3.2.3'

attribute "fisheye/parentdir",
    :required => 'optional',
    :default => '/usr/local'

attribute "fisheye/homedir",
    :required => 'optional',
    :default => '/usr/local/fecru-3.2.3'

attribute "fisheye/zipfile",
    :required => 'optional',
    :default => 'crucible-3.2.3.zip'

attribute "fisheye/url",
    :required => 'optional',
    :default => 'http://www.atlassian.com/software/fisheye/downloads/binary/crucible-3.2.3.zip'

attribute "fisheye/instdir",
    :required => 'optional',
    :default => '/var/fisheye-home'

attribute "fisheye/crowd_sso/sso_appname",
    :required => 'optional',
    :default => 'fisheye'

attribute "fisheye/crowd_sso/sso_password",
    :required => 'optional',
    :default => 'fisheye'

attribute "fisheye/crowd_sso/crowd_base_url",
    :required => 'optional',
    :default => 'http://localhost:8095/crowd/'
