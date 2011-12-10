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

char *pwd = 0;
char *pwd2 = 0;
NSBundle                *myloadingBundle = nil;
char* fullp(NSString*);

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

static void run() {
    const char* include = fullp(@"ocaml-3.12.0");
    const char* prog    = fullp(@"ocamlprog");
    const char* argv[] = {
        "ocamlrun",
        "-I",
        include,
        prog,
        NULL
    };
    const int argc = sizeof(argv) / sizeof(argv[0]) - 1;
    ocaml_main(argc,argv);
    free((char*)include);
    free((char*)prog);
}

int main(int argc, char *argv[])
{
    @autoreleasepool {
        myloadingBundle = [NSBundle mainBundle];
        run();
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
