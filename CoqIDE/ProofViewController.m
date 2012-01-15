//
//  ProofViewController.m
//  CoqIDE
//
//  Created by mzp on 12/01/15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ProofViewController.h"

@implementation ProofViewController
@synthesize coq;
@synthesize delegate;
@synthesize theorem;

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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    [goal setText: [coq goal]];
}


- (void)viewDidUnload
{
    command = nil;
    goal = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [delegate onProofClose];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (NSString*)strip:(NSString*)str
{
    NSInteger len = [str length];
    return [str substringWithRange:NSMakeRange(0, len -1)];
}

- (IBAction)command:(id)sender {
    [coq eval:@"Show Script." info:-1];
    NSString* proof = [[coq message] copy];
    
    if([coq eval:[command text] info:0]) {
        [command setText:@""];
        
        if([coq isProofMode]) 
        {
            [goal setText: [coq goal]];
        }
        else
        {
            [delegate setProof:[NSString stringWithFormat:@"%@\nProof.\n%@Qed.", 
                                theorem,
                                [self strip: proof]]];
            [self dismissModalViewControllerAnimated:TRUE];
        }
    }
    
}
@end
