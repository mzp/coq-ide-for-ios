//
//  FileSelectView.h
//  CoqIDE
//
//  Created by mzp on 11/12/24.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FileSelectView : UIViewController <UITableViewDataSource>{
    NSArray* files;
    id delegate;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

@property (retain) id delegate;
@end
