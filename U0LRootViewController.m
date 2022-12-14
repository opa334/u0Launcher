#import "U0LRootViewController.h"
#import <mach-o/dyld.h>

@interface LSApplicationWorkspace : NSObject
+ (instancetype)defaultWorkspace;
- (BOOL)openApplicationWithBundleID:(NSString*)appId;
@end

BOOL isAlreadyJailbroken(void)
{
	for (uint32_t i = 0; i < _dyld_image_count(); i++)
	{
		const char *pathC = _dyld_get_image_name(i);
		NSString* path = [NSString stringWithUTF8String:pathC];

		if([path isEqualToString:@"/usr/lib/substitute-inserter.dylib"])
		{
			return YES;
		}
	}

	return NO;
}

@implementation U0LRootViewController

- (void)showErrorMessage:(NSString*)errorMessage
{
	UIAlertController* errorAlertController = [UIAlertController alertControllerWithTitle:@"Error" message:errorMessage preferredStyle:UIAlertControllerStyleAlert];
	
	UIAlertAction* closeAction = [UIAlertAction actionWithTitle:@"Close" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		exit(0);
	}];
	
	[errorAlertController addAction:closeAction];
	
	[self presentViewController:errorAlertController animated:YES completion:nil];
}

- (void)viewDidLoad
{
	[super viewDidLoad];

	if(isAlreadyJailbroken())
	{
		exit(0);
		return;
	}

	// Ping amfid, which makes it launch (which unc0ver needs)
	xpc_connection_t xpcConnection = xpc_connection_create_mach_service("com.apple.MobileFileIntegrity", 0, XPC_CONNECTION_MACH_SERVICE_PRIVILEGED);
	xpc_connection_set_event_handler(xpcConnection, ^(xpc_object_t object){});
	xpc_connection_resume(xpcConnection);
	xpc_object_t wakeupMessage = xpc_dictionary_create(NULL,NULL,0);
	xpc_connection_send_message_with_reply(xpcConnection, wakeupMessage, dispatch_get_main_queue(), ^(xpc_object_t reply)
	{
		BOOL launchWorked = [[LSApplicationWorkspace defaultWorkspace] openApplicationWithBundleID:@"science.xnu.undecimus"];
		if(!launchWorked)
		{
			[self showErrorMessage:@"Failed to launch unc0ver, make sure you have installed the unc0ver IPA via TrollStore."];
			return;
		}

		exit(1);
	});	
}

@end
