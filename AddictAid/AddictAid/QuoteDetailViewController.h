//
//  QuoteDetailViewController.h
//  AddictAid
//
//  Created by Justin Rowe on 8/28/14.
//  Copyright (c) 2014 Justin Rowe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuoteDetailViewController : UIViewController

@property (nonatomic, strong) NSString *detailQuote;
@property (strong, nonatomic) UITextView *detailQuoteTextView;

@end
