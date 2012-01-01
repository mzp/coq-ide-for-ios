//
//  ViewController.h
//  CoqIDE
//
//  Created by mzp on 11/12/09.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Coq.h"
#import "EGOTextView.h"
@interface ViewController : UIViewController
{
    Coq* coq;
    int currentPos;
    __weak IBOutlet UINavigationItem *filenameItem;
    __weak IBOutlet UITextView *message;
    __weak IBOutlet EGOTextView *code;
    __weak IBOutlet UITextView *proof_tree;
    __weak IBOutlet UISegmentedControl *buttonSegment;
}
- (IBAction)eval:(id)sender;
- (IBAction)reset:(id)sender;
- (IBAction)undo:(id)sender;
- (IBAction)create:(id)sender;

@property (strong, nonatomic) UIStoryboardPopoverSegue* popSegue;
@end
