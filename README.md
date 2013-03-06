![logo](https://github.com/joeldev/ADNKit/raw/master/Images/adnkit.png)

ADNKit is a brand new Objective-C framework for building App.net iOS and OS X applications. The guiding design principles are:
* Simple and easy to understand API
* As much heavylifting as possible is done for you
* 100% ADN API support
* No dependencies other than AFNetworking

It's also important to note that many parts of core architecture in this framework is based on [Matt Rubin](https://github.com/mattrubin)'s fantastic architectural work in his [AppDotNet](https://github.com/mattrubin/AppDotNet) project. My hat's off to him for designing a truly excellent framework architecture and open sourcing it!

# Current State
ADNKit is very much a work in progress right now, and 100% of the ADN API has not yet been reached. Here is a quick overview of what Resource API groups are supported.

| Resource  | Support|
| --------- | ------:|
| User      | ![check](https://github.com/joeldev/ADNKit/raw/master/Images/greencheck.png) Full |
| Post      | ![check](https://github.com/joeldev/ADNKit/raw/master/Images/greencheck.png) Full |
| Channel   | None   |
| Message   | None   |
| File      | ![check](https://github.com/joeldev/ADNKit/raw/master/Images/greencheck.png) Full |
| Stream    | None   |
| Filter    | None   |

# Getting Started
### Installation
ADNKit makes use of submodules for its dependencies. After cloning the repo, make sure to run `git submodule update --init --recursive` from the top level before trying to build the code. There is also a Releases folder containing stable binary releases.

**It's also important to note that AFNetworking is compiled in as part of the library and does not need to be added to your project.**

### Authentication

##### Setting a saved access token
```objc
[ADNClient sharedClient].accessToken = theAccessToken;
```

You should call this if the user has already authorized the application and you have an access token to use. Authentication only needs to be done when the token is no longer valid or the user has never authorized the app before.

##### Username/Password Authentication

App.net recommends that any app being submitted to the Mac or iOS App Store use username/password authentication instead of OAuth ([source](http://developers.app.net), see "Registering your app"). You can find out more about Password Authentication and how to apply for it [here](http://developers.app.net/docs/authentication/flows/password/).

Once you have been approved for username/password auth, **getting authenticated with ADNKit is a single method call:**

```objc
/* this assumes you have two text fields, usernameField and passwordField */

// ask for permission to see user information, fetch their streams, and send Posts
ADNAuthScope requestedScopes = ADNAuthScopeBasic | ADNAuthScopeStream | ADNAuthScopeWritePost;

// handler to call when finished authenticating
id handler = ^(BOOL success, NSError *error) {
	if (success) {
		NSLog(@"we are authenticated and ready to make API calls!");
	} else {
		NSLog(@"could not authenticate, error: %@", error);
	}
};

// authenticate, calling the handler block when complete
[[ADNClient sharedClient] authenticateUsername:usernameField.text
									  password:passwordField.text
									  clientID:@"xxxxxx"
						   passwordGrantSecret:@"zzzzzz"
						         	authScopes:requestedScopes
						     completionHandler:handler];
```

Once the completion block is called with a successful response, you are completely good to go and can start using the rest of the API calls. You don't even need to set the accessToken on the shared ADNClient, that happens automatically.

##### OAuth Authentication

While not being the preferred approach for native applications, ADNKit will also help you out with web OAuth authentication ([more info](http://developers.app.net/docs/authentication/flows/web/)) if that's the route you choose to take (it's sometimes faster to start with because it doesn't require explicit approval like username/password auth does).

For the redirectURI, you should use a URL scheme that your app is registered to handle ([Apple documentation](http://developer.apple.com/library/ios/#documentation/iphone/conceptual/iphoneosprogrammingguide/AdvancedAppTricks/AdvancedAppTricks.html#//apple_ref/doc/uid/TP40007072-CH7-SW50)).

Using the method below, you can generate an NSURLRequest that can be loaded in a webview to provide the user with a way to auth.
```objc
// ask for permission to see user information, fetch their streams, and send Posts
ADNAuthScope requestedScopes = ADNAuthScopeBasic | ADNAuthScopeStream | ADNAuthScopeWritePost;

// set the completion block to use when the whole process is completed (since it spans multiple requests)
[ADNClient sharedClient].webAuthCompletionHandler = ^(BOOL success, NSError *error) {
	if (success) {
		NSLog(@"we are authenticated and ready to make API calls!");
	} else {
		NSLog(@"could not authenticate, error: %@", error);
	}
};

// create a URLRequest to kick off the auth process...
NSURLRequest *request = [[ADNClient sharedClient] webAuthRequestForClientID:@"xxxxxx"
														        redirectURI:@"myapp://auth"
													             authScopes:requestedScopes
													                  state:nil
												          appStoreCompliant:YES];
// ...and load it to start things off
[myWebView loadRequest:request];
```

Once the user authorizes the application, your redirectURI will get called and passed an auth code. Using something like [JLRoutes](https://github.com/joeldev/JLRoutes) to register a route from within `applicationDidFinishLaunching` makes this very easy:

```objc
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  // ...
  [JLRoutes addRoute:@"/auth" handler:^BOOL(NSDictionary *parameters) {
    NSString *accessCode = parameters["code"];
    
	// now that we have the accessCode, we need to finish the process.
	[[ADNClient sharedClient] authenticateWebAuthAccessCode:accessCode forClientID:@"xxxxxx" clientSecret:@"ssssss"];

    return YES; // return YES to say we have handled the route
  }];
  // ...
  return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
  return [JLRoutes routeURL:url];
}

```

Once your web auth completion block is called (which was set up in the previous block code), you are ready to go. No need to set the accessToken, that is handled automatically.

# Dependencies
ADNKit uses the following dependencies:
* [AFNetworking](https://github.com/AFNetworking/AFNetworking)

The following built-in frameworks are used:
* CoreLocation.framework
* SystemConfiguration.framework
* MobileCoreServices.framework (iOS only)

# License
> (decide on BSD or MIT)