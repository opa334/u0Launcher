TARGET := iphone:clang:latest:7.0
INSTALL_TARGET_PROCESSES = u0Launcher

include $(THEOS)/makefiles/common.mk

APPLICATION_NAME = u0Launcher

u0Launcher_FILES = main.m U0LAppDelegate.m U0LRootViewController.m
u0Launcher_FRAMEWORKS = UIKit CoreGraphics CoreServices
u0Launcher_CFLAGS = -fobjc-arc
u0Launcher_CODESIGN_FLAGS = -fobjc-arc
u0Launcher_CODESIGN_FLAGS = -Sentitlements.plist

include $(THEOS_MAKE_PATH)/application.mk
