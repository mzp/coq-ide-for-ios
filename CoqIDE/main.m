//
//  main.m
//  CoqIDE
//
//  Created by mzp on 11/12/09.
//

#include <sys/param.h>
#import <UIKit/UIKit.h>
#include <unistd.h>
#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#include "ocamlrun/byterun/glue.h"
#include "ocamlrun/byterun/callback.h"
#include "util.h"

char *pwd = 0;
char *pwd2 = 0;
NSBundle                *myloadingBundle = nil;

char *fullp(NSString *relPath) {
    char realp[MAXPATHLEN];
    NSString *fullpath = nil;
    @autoreleasepool {
        if( ! [relPath isAbsolutePath] ) {
            NSMutableArray *imagePathComponents = [NSMutableArray arrayWithArray:[relPath pathComponents]];
            NSString *file = [imagePathComponents lastObject];

            [imagePathComponents removeLastObject];
            NSString *imageDirectory = [NSString pathWithComponents:imagePathComponents];

            fullpath = [myloadingBundle pathForResource:file ofType:nil inDirectory:imageDirectory];
            const char* bundle_String = [fullpath UTF8String];
            realpath(bundle_String, realp);
            return strdup(realp);
        } else {
            char *rel = strdup([relPath UTF8String]);
            return rel;
        }
    }
}

int main(int argc, char *argv[])
{
    @autoreleasepool {
        myloadingBundle = [NSBundle mainBundle];
        pwd2 = fullp(@"Icon.png");
        char *rslash = strrchr(pwd2, '/');
        if (rslash)
        {
            rslash[1] = 0;
            pwd = strdup(pwd2);
            *rslash = 0;
            rslash = strrchr(pwd2, '/');
            if (rslash) rslash[1] = 0;
        }
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
