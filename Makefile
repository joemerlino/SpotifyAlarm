include $(THEOS)/makefiles/common.mk

TWEAK_NAME = SpotifyAlarm
SpotifyAlarm_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += saprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
