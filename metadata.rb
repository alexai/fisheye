name		"fisheye"
maintainer       "demandforce"
maintainer_email "yai@dfengg.com"
license          "All rights reserved"
description      "Installs crucible"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.1"

supports "centos"
supports "ubuntu"
supports "redhat"

recipe "fisheye::default","Install fisheye server"

attribute "fisheye/version",
	:required => 'optional',
	:default => '2.10.4'

attribute "fisheye/url",
	:required => 'optional',
	:default => 'http://www.atlassian.com/software/crucible/downloads/binary'

attribute "fecru/bak/path",
	:required => 'optional',
	:default => 'http://172.16.2.20/fisheye/'

attribute "fecru/bak/zip",
	:required => 'optional',
	:default => 'fisheyeandcrucible_backup_2014_01_10.zip'
