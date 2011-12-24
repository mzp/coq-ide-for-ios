//
//  FileSelectView.m
//  CoqIDE
//
//  Created by mzp on 11/12/24.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "FileSelectView.h"

@implementation FileSelectView

@synthesize delegate;

#pragma mark - View lifecycle

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [[UITableViewCell alloc] init];
    [cell.textLabel setText: [files objectAtIndex: indexPath.row]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString* path=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
	files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
    return [files count];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [delegate select:[files objectAtIndex: indexPath.row]];
}

@end
