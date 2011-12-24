//
//  ViewController.m
//  CoqIDE
//
//  Created by mzp on 11/12/09.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

@synthesize popSegue;

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
        return [rest substringWithRange: NSMakeRange(0,range.location+range.length)];
    }
}

- (void)updateDisplay {
    [currentLineLabel setText:[NSString stringWithFormat:@"%d", currentPos]];
    [message setText:[coq message]];
    if([coq isProofMode]) {
        [proof_tree setText:[coq goal]];
    } else {
        [proof_tree setText:@""];
    }
}

- (IBAction)eval:(id)sender 
{
    NSString* text = [self nextCommand];
    if(text != nil) {
        NSLog(@"next command: %@", text);
        BOOL b = [coq eval: text info: currentPos];
        if(b) { currentPos += text.length; }
        [self updateDisplay];
    } else {
        [message setText:@"No more command"];
    }
}

- (IBAction)reset:(id)sender {
    [coq reset];
    currentPos = 0;
    [self updateDisplay];
}

- (IBAction)undo:(id)sender {
    int pos = [coq undo];
    currentPos = pos;
    [self updateDisplay];
}

- (IBAction)save:(id)sender {
    NSString* document = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString* path = [NSString stringWithFormat:@"%@/proof.v" , document];
    NSLog(@"write to %@", path);
    NSData* data = [[code text] dataUsingEncoding:NSUTF8StringEncoding];
    [data writeToFile:path atomically:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    self.popSegue = (UIStoryboardPopoverSegue*)segue;
    [[segue destinationViewController] setDelegate:self];
}

- (void)select:(NSString*)name
{
    if ([self.popSegue.popoverController isPopoverVisible])
    {
        [self.popSegue.popoverController dismissPopoverAnimated:YES];
    }

    NSFileManager *fileManager = [NSFileManager defaultManager];
	NSString *filePath = [NSString stringWithFormat:@"%@/%@" ,
                          [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"],
                          name];
	if([fileManager fileExistsAtPath:filePath]) {
		NSData *data = [NSData dataWithContentsOfFile:filePath];
		NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        [code setText:str];
    }
}

@end
