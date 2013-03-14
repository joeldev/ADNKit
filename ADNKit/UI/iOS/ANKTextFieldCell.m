//
//  ANKTextFieldCell.m
//  ADNKit
//
//  Created by Levin, Joel A on 3/13/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ANKTextFieldCell.h"


@implementation ANKTextFieldCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
		self.textField = [[UITextField alloc] initWithFrame:CGRectZero];
		self.textField.backgroundColor = [UIColor clearColor];
		self.textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
		self.textField.autocorrectionType = UITextAutocorrectionTypeNo;
		self.textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
		[self.contentView addSubview:self.textField];
    }
    return self;
}


- (void)layoutSubviews {
	[super layoutSubviews];
	self.textField.frame = CGRectInset(self.contentView.bounds, 10.0, 0.0);
}


@end
