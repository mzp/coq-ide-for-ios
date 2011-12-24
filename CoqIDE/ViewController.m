//
//  ViewController.m
//  CoqIDE
//
//  Created by mzp on 11/12/09.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];    
	// Do any additional setup after loading the view, typically from a nib.
    coq = [[Coq alloc] init];
    currentPos = 0;
}

- (void)viewDidUnload
{
    code = nil;
    message = nil;
    proof_tree = nil;
    currentLineLabel = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

- (NSString*)nextCommand {
    NSString* all = [code text];
    NSString* rest = [all substringWithRange: NSMakeRange(currentPos, [all length] - currentPos)];
    NSRange range = [rest rangeOfString:@"."];
    if(range.location == NSNotFound){
        return nil;
    } else {
        currentPos += range.location + range.length;
        return [rest substringWithRange: NSMakeRange(0,range.location+range.length)];
    }
}

- (IBAction)eval:(id)sender 
{
    NSString* text = [self nextCommand];
    if(text != nil) {
        NSLog(@"next command: %@", text);
        [coq eval: text];
        [currentLineLabel setText:[NSString stringWithFormat:@"%d", currentPos]];
        [message setText:[coq message]];
        if([coq isProofMode]){
            [proof_tree setText:[coq goal]];
        }
    } else {
        [message setText:@"No more command"];
    }
}
@end
