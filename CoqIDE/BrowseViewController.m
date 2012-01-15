//
//  BrowseViewController.m
//  CoqIDE
//
//  Created by mzp on 12/01/15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BrowseViewController.h"
#import "DefinitionViewController.h"
#import "ProofViewController.h"

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
    log = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (void)log:(NSString*) text
{
    [log setText: text];
}

- (id)getViewController: (NSString*)name
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:
                                @"MainStoryboard" bundle:[NSBundle mainBundle]];
    return [storyboard instantiateViewControllerWithIdentifier:name];
}

- (void)appendCode: (NSString*)text 
{
    [code setText: [[code text] stringByAppendingFormat:@"\n%@", text]];
}

- (void)eval:(NSString*) text
{
    if([coq eval: text info:0]) 
    {
        if([coq isProofMode]) 
        {
            ProofViewController* view = [self getViewController:@"proof"];
            view.modalPresentationStyle = UIModalPresentationPageSheet;
            view.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            view.delegate = self;
            view.theorem  = text;
            view.coq      = coq;
            [self presentModalViewController:view animated:YES];
        }
        else
        {
            [self appendCode: text];
        }
    }
    [self log: [coq message]];
}

- (void)onClose
{
    if(definition != nil){
        [self eval: definition];
        definition = nil;
    }
}

- (void)onProofClose
{
    if(proof != nil){
        [self appendCode: proof];
        proof = nil;
    }
}

- (void)setDefiniton:(NSString*) text {
    definition = text;
}

- (void)setProof:(NSString *)text
{
    proof = text;
}

- (IBAction)add:(id)sender 
{
    DefinitionViewController* view = [self getViewController:@"definition"];
    view.modalPresentationStyle = UIModalPresentationFormSheet;
    view.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    view.delegate = self;
    [self presentModalViewController:view animated:YES];
}
@end
