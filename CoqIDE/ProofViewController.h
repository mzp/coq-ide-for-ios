//
//  ProofViewController.h
//  CoqIDE
//
//  Created by mzp on 12/01/15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "coq.h"

@protocol ProofDelegator <NSObject>
- (void)setProof: (NSString*) text;
- (void)onProofClose;
@end

@interface ProofViewController : UIViewController
{
    __weak IBOutlet UITextView *command;    
    __weak IBOutlet UITextView *goal;
}

@property (strong, nonatomic) id<ProofDelegator> delegate;
@property (strong, nonatomic) Coq* coq;
@property (strong, nonatomic) NSString* theorem;
- (IBAction)command:(id)sender;
@end
