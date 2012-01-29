//
//  BrowseViewController.h
//  CoqIDE
//
//  Created by mzp on 12/01/15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "coq.h"

@interface BrowseViewController : UIViewController
{
    NSString* definition;
    NSString* proof;
    @private Coq* coq;
    __weak IBOutlet UITextField *code;
    __weak IBOutlet UITextView *result;
}
- (IBAction)eval:(id)sender;


@end
