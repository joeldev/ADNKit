//
//  ANKOAuthViewController.m
//  ADNKit
//
//  Created by Joel Levin on 3/8/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

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
