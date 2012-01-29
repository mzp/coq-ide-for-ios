//
//  BrowseViewController.m
//  CoqIDE
//
//  Created by mzp on 12/01/15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BrowseViewController.h"

@implementation BrowseViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

- (void)viewDidLoad
{
    [super viewDidLoad];
    coq = [[Coq alloc] init];
}

- (void)viewDidUnload
{
    code = nil;
    result = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (void)append:(NSString*) s {
    [result setText: [s stringByAppendingFormat:@"\n%@", [result text]]];
}

- (IBAction)eval:(id)sender {
    NSString* text = [NSString stringWithFormat: @"> %@\n", [code text]];
    
    if([coq eval: [code text] info:0]) {
        if(![[coq message] isEqualToString: @""]) {
            text = [text stringByAppendingFormat:@"%@\n", [coq message]];
        }
        if([coq isProofMode]) {
            text = [text stringByAppendingFormat:@"%@\n", [coq goal]];
        }
        [self append:text];
        [code setText:@""];
    } else {
        [self append: @"syntax error"];
    }

//    [coq eval: [code text]];
    

}

@end
