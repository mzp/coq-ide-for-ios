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
    int currentPos;
    IBOutlet UITextView *message;
    IBOutlet UITextView *code;
    IBOutlet UITextView *proof_tree;
    IBOutlet UILabel *currentLineLabel;
}
- (IBAction)eval:(id)sender;
- (IBAction)reset:(id)sender;
- (IBAction)undo:(id)sender;
- (IBAction)save:(id)sender;

@property (strong, nonatomic) UIStoryboardPopoverSegue* popSegue;
@end
