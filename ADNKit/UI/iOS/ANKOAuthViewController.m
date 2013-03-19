/*
 Copyright (c) 2013, Joel Levin
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
 Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 Neither the name of ADNKit nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#ifdef __IPHONE_OS_VERSION_MIN_REQUIRED

#import "ANKOAuthViewController.h"


@interface ANKOAuthViewController ()

@property (strong) UIWebView *webView;
@property (strong) NSURLRequest *request;
@property (strong) ANKClient *client;
@property (copy) void (^authDidFinishHandler)(ANKClient *authedClient, NSError *error, ANKOAuthViewController *controller);

@end


@implementation ANKOAuthViewController

- (id)initWithWebAuthRequest:(NSURLRequest *)request client:(ANKClient *)client completion:(void (^)(ANKClient *authedClient, NSError *error, ANKOAuthViewController *controller))completionHander {
	if ((self = [super init])) {
		self.authDidFinishHandler = completionHander;
		self.request = request;
		self.client = client;
		self.title = @"Log in to App.net";
	}
	return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
	self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
	[self.view addSubview:self.webView];
	
	__weak ANKOAuthViewController *weakSelf = self;
	self.client.webAuthCompletionHandler = ^(BOOL succeeded, NSError *error) {
		if (succeeded) {
			weakSelf.authDidFinishHandler(weakSelf.client, nil, weakSelf);
		} else {
			weakSelf.authDidFinishHandler(nil, error, weakSelf);
		}
	};
}


- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	[self.webView loadRequest:self.request];
}


- (void)cancel {
	[self dismissViewControllerAnimated:YES completion:nil];
}


- (void)authenticateWebAuthAccessCode:(NSString *)accessCode forClientID:(NSString *)clientID clientSecret:(NSString *)clientSecret {
	[self.client authenticateWebAuthAccessCode:accessCode forClientID:clientID clientSecret:clientSecret];
}


@end

#endif
