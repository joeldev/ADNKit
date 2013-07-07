![logo](https://github.com/joeldev/ADNKit/raw/master/Images/adnkit.png)

ADNKit is a brand new Objective-C framework for building App.net iOS and OS X applications. The guiding design principles are:
* Simple and powerful API
* As much heavylifting as possible is done for you (aka, tons of convenience methods)
* 100% App.net API and features support
* No external dependencies other than AFNetworking
* Multi-user support

Note: the basic core structure of this framework is based off of [Matt Rubin](https://github.com/mattrubin)'s fantastic architectural work in his [AppDotNet](https://github.com/mattrubin/AppDotNet) project.

### Apps using ADNKit

* [Passport by App.net] (http://blog.app.net/2013/05/08/app-net-passport-for-ios-is-now-available/) (first-party application).
* [Climber] (http://climbr.co) by [@rrbrambley] (https://alpha.app.net/rrbrambley)
* [Sprinter] (http://sprintr.co) by [@rrbrambley] (https://alpha.app.net/rrbrambley)
* [Orbit] (http://orbitapp.net) by [@joeldev] (https://alpha.app.net/joeldev) and [@lavoy] (https://alpha.app.net/lavoy)
* [Twentysecs] (http://twentysecs.com) by [@ctarda] (https://alpha.app.net/ctarda)
* [Stream] (http://getstreamapp.net) by [@kolin] (https://alpha.app.net/kolin) and [@christian] (https://alpha.app.net/christian)
* *Multiple unannounced projects*

*Please file an issue to get your app added if you'd like to be on the list!*

# Getting Started
Please see [the wiki](https://github.com/joeldev/ADNKit/wiki) for full documentation.

### Installation
ADNKit makes use of submodules for its dependency. After cloning the repo, make sure to run `git submodule update --init --recursive` from the top level before trying to build the franework. There is also a Release folder containing the latest stable binary release (for both OS X and iOS) and headers.

ADNKit is also available via CocoaPods, thanks to [Ash Furrow] (https://alpha.app.net/ashfurrow).

##### iOS

For iOS apps, make sure that you have added the folder containing the ADNKit headers folder to your header search paths. This folder can either be copied from Release/ADNKit or you can point directly to that location if ADNKit is a submodule in your project (aka, path would be something like 'Vendor/ADNKit/Release/ADNKit'). Additionally, add the Release folder itself to both header and library search paths.

Also make sure to add the `-all_load` and `-ObjC` linker flags to Other Linker Flags. If ADNKit has been added as a submodule and you plan to use a binary build from the Release folder, you need to add the Release folder itself to your header search paths (as non-recursive). Doing so will allow the <ADNKit/header.h> format used by ADNKit.h to work in your project.

##### Deployment Requirements

ADNKit requires OS X 10.7+ or iOS 5.0+. OS version compatibility is ensured by using the wonderful [Deploymate](http://www.deploymateapp.com) tool.

### Hello, world!

##### Authentication

[Find more information about authentication with ADNKit](https://github.com/joeldev/ADNKit/wiki/Authentication-basics), including how to set up and implement both Username/Password and OAuth authentication.

If you are writing an iOS app, be sure to [check out the features ADNKit provides](https://github.com/joeldev/ADNKit/wiki/Easy-authentication-for-iOS-apps) to make auth easier on iOS.

```objc
/* this assumes you have two text fields, usernameField and passwordField */

// ask for permission to see user information and send new Posts
ANKAuthScope requestedScopes = ANKAuthScopeBasic | ANKAuthScopeWritePost;

// handler to call when finished authenticating
id handler = ^(BOOL success, NSError *error) {
	if (success) {
		NSLog(@"we are authenticated and ready to make API calls!");
	} else {
		NSLog(@"could not authenticate, error: %@", error);
	}
};

// authenticate, calling the handler block when complete
[[ANKClient sharedClient] authenticateUsername:usernameField.text
									  password:passwordField.text
									  clientID:@"xxxxxx"
						   passwordGrantSecret:@"zzzzzz"
						         	authScopes:requestedScopes
						     completionHandler:handler];
```

Once the completion block is called with a successful response, you are completely good to go and can start using the rest of the API calls immediately.

##### Creating a Post

Now that we are authenticated with App.net, let's make our inaugural Post:

```objc
[[ANKClient sharedClient] createPostWithText:@"Hello, world!" completion:^(ADNPost *post, NSError *error) {
    NSLog(@"post created! %@", post ?: error);
}];
```

It's just that easy! You should see a new post from yourself in your stream, and a Post object in your console!

You could have also achieved the same thing with:
```objc
ADNPost *post = [[ADNPost alloc] init];
post.text = @"Hello, world!";
[[ANKClient sharedClient] createPost:post completion:^(ADNPost *post, NSError *error) {
    NSLog(@"post created! %@", post ?: error);
}];
```
Using the model objects directly lets you set them up completely (such as setting post.annotations). There is not a convenience method for everything, so more advanced situations are intended to be handled by creating the model object, setting it up how you want it, and then handing it directly to an ANKClient method.

##### Supporting Multiple Logged-in User Accounts

Documentation and example code for how to support multiple user accounts can be found [here] (https://github.com/joeldev/ADNKit/wiki/Supporting-multiple-logged-in-Users). The summary is: don't use ANKClient's sharedClient, alloc/init your own client object (one per user).

# Documentation

There are many articles worth reading and documentation [on the wiki](https://github.com/joeldev/ADNKit/wiki).

# Dependencies
ADNKit uses the following dependencies:
* [AFNetworking](https://github.com/AFNetworking/AFNetworking)

# License
BSD 3-Clause License:
> Copyright (c) 2013, Joel Levin. All rights reserved.
 
> Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
>*  Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
* Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
* Neither the name of ADNKit nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

> THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
