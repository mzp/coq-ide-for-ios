//
//  ViewController.h
//  CoqIDE
//
//  Created by mzp on 11/12/09.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Coq.h"
@interface ViewController : UIViewController
{
    Coq* coq;
    IBOutlet UITextView *message;
    IBOutlet UITextView *code;
}
- (IBAction)eval:(id)sender;
@end
