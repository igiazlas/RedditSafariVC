include $(THEOS)/makefiles/common.mk

TWEAK_NAME = RedditSafariVC
RedditSafariVC_FILES = Tweak.xm RDLinkHandler.m

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 Reddit"
