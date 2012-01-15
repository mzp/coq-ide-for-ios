//
//  BrowseViewController.h
//  CoqIDE
//
//  Created by mzp on 12/01/15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DefinitionViewController.h"
#import "ProofViewController.h"
#import "coq.h"

@interface BrowseViewController : UIViewController <DefinitionDelegator,ProofDelegator>
{
    NSString* definition;
    NSString* proof;
    @private Coq* coq;
    __weak IBOutlet UITextView *code;
    __weak IBOutlet UITextView *log;
}

- (IBAction)add:(id)sender;

@end
