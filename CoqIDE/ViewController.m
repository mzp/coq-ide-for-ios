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
    
    buttonSegment.selectedSegmentIndex = UISegmentedControlNoSegment;
	// Do any additional setup after loading the view, typically from a nib.
    coq = [[Coq alloc] init];

    code.inputDelegate = self;
    [self create:nil];
}

- (void)selectionWillChange:(id <UITextInput>)textInput {}
- (void)selectionDidChange:(id <UITextInput>)textInput {}
- (void)textWillChange:(id <UITextInput>)textInput {}
- (void)textDidChange:(id <UITextInput>)textInput {
    NSString* document = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString* path = [NSString stringWithFormat:@"%@/%@" , document, [filenameItem title]];
    NSLog(@"write to %@", path);
    NSData* data = [[code text] dataUsingEncoding:NSUTF8StringEncoding];
    [data writeToFile:path atomically:YES];
}

- (void)viewDidUnload
{
    code = nil;
    message = nil;
    proof_tree = nil;
    filenameItem = nil;
    buttonSegment = nil;
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
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
    return NO;
}

- (NSString*)nextCommand {
    NSString* all = [code text];
    NSString* rest = [all substringWithRange: NSMakeRange(currentPos, [all length] - currentPos)];
    NSRange r1 = [rest rangeOfString:@"."];
    NSRange r2 = [rest rangeOfString:@"..."];

    if(r1.location == NSNotFound && r2.location == NSNotFound){
        return nil;
    } else {
        if(r1.location < r2.location){
            return [rest substringWithRange:NSMakeRange(0, r1.location + r1.length)];
        }else{
            return [rest substringWithRange:NSMakeRange(0, r2.location + r2.length)];
        }
    }
}

- (void)updateDisplay {
    NSMutableAttributedString *string = [code.attributedString mutableCopy];
    [string addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)[UIColor redColor].CGColor range:NSMakeRange(0,currentPos)];

    [string removeAttribute:(NSString*)kCTForegroundColorAttributeName range:NSMakeRange(currentPos, [string length] - currentPos)];
    code.attributedString = string;
    code.editLock = currentPos + 1;

    [message setText:[coq message]];
    if([coq isProofMode]) {
        [proof_tree setText:[coq goal]];
    } else {
        [proof_tree setText:@""];
    }
}

- (IBAction)next:(id)sender
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
    [message setText:@""];
    [proof_tree setText:@""];
    currentPos = 0;
    [self updateDisplay];
}

- (IBAction)back:(id)sender {
    int pos = [coq undo];
    currentPos = pos;
    [self updateDisplay];
}

- (IBAction)create:(id)sender {
    NSDate *now = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMdd_HHmmss.'v'"];
    [filenameItem setTitle:[formatter stringFromDate:now]];
    [code setText:@"(* demo file *)\nCheck 42."];
    [self reset:sender];
}

- (IBAction)pushButton:(id)sender {
    switch([buttonSegment selectedSegmentIndex]){
        case 0:
            [self reset: sender];
            break;
        case 1:
            [self back: sender];
            break;
        case 2:
            [self next: sender];
            break;
        case 3:
            [self create: sender];
            break;
    }
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
        [self reset:self];

        [filenameItem setTitle:name];
		NSData *data = [NSData dataWithContentsOfFile:filePath];
		NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        [code setText:str];
    }
}

//キーボードが表示された場合
- (void)keyboardWillShow:(NSNotification *)aNotification {
    NSDictionary *info = [aNotification userInfo];
    CGRect beginrect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect endrect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect cbeginrect = [[self.view superview] convertRect:beginrect toView:nil];
    CGRect cendrect = [[self.view superview] convertRect:endrect toView:nil];
    CGRect frame = [self.view frame];
    if (cbeginrect.size.height == cendrect.size.height) {
        frame.size.height -= cbeginrect.size.height;
    }
    else {
        frame.size.height -= (cendrect.size.height - cbeginrect.size.height);
    }
    [self.view setFrame:frame];
}

//キーボードが非表示にされた場合（keyboardWillShowと同じことを高さを+してやっているだけ）
- (void)keyboardWillHide:(NSNotification *)aNotification {
    NSDictionary *info = [aNotification userInfo];
    CGRect beginrect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect cbeginrect = [[self.view superview] convertRect:beginrect toView:nil];
    CGRect frame = [self.view frame];
    frame.size.height += cbeginrect.size.height;
    [self.view setFrame:frame];
}

@end
