static NSString* songLink;
static BOOL enabled, fired;

%hook SBClockDataProvider
- (_Bool)_isAlarmNotification:(id)arg1{
	if(fired){
		fired = NO;
		NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/private/var/mobile/Library/Preferences/com.joemerlino.spotifyalarm.plist"];
		songLink = [prefs objectForKey:@"link"];
		enabled = ([prefs objectForKey:@"enabled"] ? [[prefs objectForKey:@"enabled"] boolValue] : YES);
		NSLog(@"[SpotifyAlarm] %d %@", enabled, songLink);	
		if(enabled && [songLink length] != 0)
			[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"spotify://spotify:track:" stringByAppendingString:[songLink substringFromIndex:31]]]];
	}
	return %orig;
}
%end

static void alarmFired(CFNotificationCenterRef center, 
								 void *observer, 
								 CFStringRef name, 
								 const void *object, 
								 CFDictionaryRef userInfo)
{
	NSLog(@"[SpotifyAlarm] FIRED");
   	fired = YES;
}

static void PreferencesCallback(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo)
{
	CFPreferencesAppSynchronize(CFSTR("com.joemerlino.spotifyalarm"));
}

%ctor
{
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, PreferencesCallback, CFSTR("com.joemerlino.spotifyalarm.preferencechanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);
	NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/private/var/mobile/Library/Preferences/com.joemerlino.spotifyalarm.plist"];
	enabled = ([prefs objectForKey:@"enabled"] ? [[prefs objectForKey:@"enabled"] boolValue] : YES);
	songLink = [prefs objectForKey:@"link"];
	NSLog(@"[SpotifyAlarm] %d %@", enabled, songLink);
	%init();
  	/* subscribe to alarm notifications */
	CFNotificationCenterAddObserver(CFNotificationCenterGetLocalCenter(), //center
                                    NULL, // observer
                                    alarmFired, // callback
                                    CFSTR("SBClockAlarmsDidFireNotification"), // event name
                                    NULL, // object
                                    CFNotificationSuspensionBehaviorDeliverImmediately);
}