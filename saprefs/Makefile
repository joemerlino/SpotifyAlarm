include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = SAPrefs
SAPrefs_FILES = SAPRootListController.m
SAPrefs_INSTALL_PATH = /Library/PreferenceBundles
SAPrefs_FRAMEWORKS = UIKit
SAPrefs_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/SAPrefs.plist$(ECHO_END)
