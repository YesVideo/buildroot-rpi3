################################################################################
#
# ufo
#
################################################################################

UFO_VERSION = $(shell git ls-remote git@github.com:YesVideo/ufo.js.git | grep HEAD | cut -f 1,1)
UFO_SITE_METHOD = git
UFO_SITE = git@github.com:YesVideo/ufo.js.git
UFO_LICENSE = UNLICENSED

UFO_INSTALL_STAGING = YES
UFO_DEPENDENCIES = nodejs

define UFO_INSTALL_TARGET_CMDS
	cd $(@D) && $(NPM) install -g
endef

$(eval $(generic-package))
