//
//  Coq.h
//  CoqIDE
//
//  Created by mzp on 11/12/15.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Coq : NSObject
-(id)init;
-(id)eval: (NSString*)code;
@end

