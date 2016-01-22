#include "SAPRootListController.h"

@implementation SAPRootListController

	- (NSArray *)specifiers {
		if (!_specifiers) {
			_specifiers = [[self loadSpecifiersFromPlistName:@"Root" target:self] retain];
		}

		return _specifiers;
	}
	-(void)twitter {
		if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter://user?screen_name=joe_merlino"]]) {
			[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"twitter://user?screen_name=joe_merlino"]];
		} else {
			[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/joe_merlino"]];
		}
	}

	-(void)my_site {
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://joemerlino.github.io/"]];
	}

	-(void)donate {
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.paypal.me/joemerlino/"]];
	}
	-(void) sendEmail{
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto:merlino.giuseppe1@gmail.com?subject=SpotifyAlarm"]];
	}
	-(void) respring{
		system("killall -9 SpringBoard");
	}
@end
