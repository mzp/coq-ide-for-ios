//
//  DefinitionViewController.h
//  CoqIDE
//
//  Created by mzp on 12/01/15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DefinitionDelegator <NSObject>
- (void)onClose;
- (void)setDefiniton:(NSString*)text;
@end

@interface DefinitionViewController : UIViewController 
@property (weak, nonatomic) IBOutlet UITextView *definition;
- (IBAction)close:(id)sender;
- (IBAction)ok:(id)sender;
@property (strong, nonatomic) id<DefinitionDelegator> delegate;
@end
