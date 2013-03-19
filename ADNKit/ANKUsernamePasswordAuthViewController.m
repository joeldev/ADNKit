/*
 Copyright (c) 2013, Joel Levin
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
 Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 Neither the name of ADNKit nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "ANKUsernamePasswordAuthViewController.h"
#import "ANKTextFieldCell.h"


typedef NS_ENUM(NSInteger, ANKCellType) {
	ANKCellTypeUsername = 0,
	ANKCellTypePassword,
	ANKTotalCellsCount
};


@interface ANKUsernamePasswordAuthViewController ()

@property (strong) ANKClient *client;
@property (strong) NSString *clientID;
@property (strong) NSString *passwordGrantSecret;
@property (assign) ANKAuthScope authScopes;
@property (copy) void (^authDidFinishHandler)(ANKClient *authedClient, NSError *error, ANKUsernamePasswordAuthViewController *controller);
@property (weak) UIButton *authButton;

- (void)tryAuth:(id)sender;

@end


@implementation ANKUsernamePasswordAuthViewController

- (id)initWithClient:(ANKClient *)client clientID:(NSString *)clientID passwordGrantSecret:(NSString *)passwordGrantSecret authScopes:(ANKAuthScope)authScopes completion:(void (^)(ANKClient *authedClient, NSError *error, ANKUsernamePasswordAuthViewController *controller))completionHandler {
	if ((self = [super initWithStyle:UITableViewStyleGrouped])) {
		self.authDidFinishHandler = completionHandler;
		self.client = client;
		self.title = @"Log in to App.net";
		
		self.clientID = clientID;
		self.passwordGrantSecret = passwordGrantSecret;
		self.authScopes = authScopes;
	}
	return self;
}


- (void)viewDidLoad {
	[super viewDidLoad];
	
	UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, 54.0)];
	self.authButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[self.authButton setTitle:@"Log in" forState:UIControlStateNormal];
	[self.authButton sizeToFit];
	self.authButton.frame = CGRectMake(10.0, 0.0, self.view.frame.size.width - 20.0, self.authButton.frame.size.height);
	[self.authButton addTarget:self action:@selector(tryAuth:) forControlEvents:UIControlEventTouchUpInside];
	[footerView addSubview:self.authButton];
	
	self.tableView.tableFooterView = footerView;
}


- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	ANKTextFieldCell *usernameField = (ANKTextFieldCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
	[usernameField.textField becomeFirstResponder];
}


- (void)tryAuth:(id)sender {
	ANKTextFieldCell *usernameField = (ANKTextFieldCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
	ANKTextFieldCell *passwordField = (ANKTextFieldCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
	self.authButton.enabled = NO;
	usernameField.textField.enabled = NO;
	passwordField.textField.enabled = NO;
	
	if (self.authRequestDidBegin) {
		self.authRequestDidBegin();
	}
	
	[self.client authenticateUsername:usernameField.textField.text password:passwordField.textField.text clientID:self.clientID passwordGrantSecret:self.passwordGrantSecret authScopes:self.authScopes completionHandler:^(BOOL success, NSError *error) {
		if (success) {
			self.authDidFinishHandler(self.client, nil, self);
		} else {
			self.authDidFinishHandler(nil, error, self);
			self.authButton.enabled = YES;
			usernameField.textField.enabled = YES;
			passwordField.textField.enabled = YES;
		}
		
		if (self.authRequestDidFinish) {
			self.authRequestDidFinish();
		}
	}];
}


- (void)cancel {
	[self dismissViewControllerAnimated:YES completion:nil];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return ANKTotalCellsCount;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *const cellIdentifier = @"Cell";
	ANKTextFieldCell *cell = (ANKTextFieldCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	if (!cell) {
		cell = [[ANKTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
		cell.textField.delegate = self;
	}
	
	if (indexPath.row == ANKCellTypeUsername) {
		cell.textField.placeholder = @"Username";
		cell.textField.returnKeyType = UIReturnKeyNext;
	} else if (indexPath.row == ANKCellTypePassword) {
		cell.textField.placeholder = @"Password";
		cell.textField.secureTextEntry = YES;
		cell.textField.returnKeyType = UIReturnKeyGo;
	}
	
	return cell;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	ANKTextFieldCell *usernameField = (ANKTextFieldCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:ANKCellTypeUsername inSection:0]];
	ANKTextFieldCell *passwordField = (ANKTextFieldCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:ANKCellTypePassword inSection:0]];
	
	if (textField == usernameField.textField) {
		[passwordField.textField becomeFirstResponder];
	} else if (textField == passwordField.textField) {
		[self tryAuth:nil];
	}
	
	return NO;
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
	BOOL shouldChange = textField.isSecureTextEntry;
	
	if (!shouldChange) {
		NSMutableString *mutableString = [textField.text mutableCopy];
		[mutableString replaceCharactersInRange:range withString:string];
		shouldChange = ![mutableString hasPrefix:@"@"] && ([mutableString rangeOfString:@" "].location == NSNotFound);
	}
	
	return shouldChange;
}


@end
