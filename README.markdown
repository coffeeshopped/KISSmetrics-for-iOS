# KISSmetrics-for-iOS

KISSmetrics-for-iOS enables interaction with the KISSmetrics API within native iPhone/iPad apps, using your KISSmetrics API key.

## Usage Example

An example of registering a "Launched App" event whenever a user launches your app:

    #include "KissMetrics.h"

    - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    	KissMetrics *km = [[KissMetrics alloc] initWithKey:@"your-API-key-here"];
	
    	// the identify: method should be called before making any other API calls except alias:
    	// here we use the UDID of the device as an example of an identifier
    	[km identify:[UIDevice currentDevice].uniqueIdentifier];
	
    	// include some info about the type of device, operating system, and version of your app
    	NSDictionary *info = [NSDictionary dictionaryWithObjectsAndKeys:
    												[UIDevice currentDevice].model, @"Model",
    												[UIDevice currentDevice].systemName, @"System Name",
    												[UIDevice currentDevice].systemVersion, @"System Version",
    												[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"], @"My App Version",
    												nil];
    	[km record:@"Launched App" properties:info];
    }
    

## Notes

* Calling the identify: method is what sets the identity of the user for later calls to record: or set: in your app.  So, identify: should be called first
* Currently, KISSmetrics-for-iOS won't complain if you don't call identify: first.  It's up to you to make sure you do so
* As KISSmetrics never returns an error response, no callbacks are currently available in KISSmetrics-for-iOS to see what happened after you make an API call.  Maybe later I'll add a callback for whether there are internet connectivity problems, but for now the approach is just to make the API call and move on.
