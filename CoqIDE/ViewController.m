//
//  ViewController.m
//  CoqIDE
//
//  Created by mzp on 11/12/09.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

#include "ocamlrun/byterun/alloc.h"
#include "ocamlrun/byterun/mlvalues.h"
#include "ocamlrun/byterun/callback.h"
#undef alloc

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
}

- (void)viewDidUnload
{
    code = nil;
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

- (IBAction)eval:(id)sender 
{
    const char* s = [[code text] UTF8String];
    caml_callback(*caml_named_value("eval"),caml_copy_string(s));
}
@end
