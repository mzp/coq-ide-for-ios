//
//  Coq.m
//  CoqIDE
//
//  Created by mzp on 11/12/15.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "Coq.h"
#include "util.h"
#include "ocamlrun/byterun/glue.h"

@implementation Coq
- (id)init {
    self = [super init];
    if (self) {
        const char* include = fullp(@"ocaml-3.12.0");
        const char* prog    = fullp(@"ocamlprog");
        const char* coqlib  = fullp(@"coq-8.2pl2");
        const char* argv[] = {
            "ocamlrun",
            "-I",
            include,
            prog,
            "-coqlib",
            coqlib,
            NULL
        };
        caml_main((char**)argv);
        free((char*)include);
        free((char*)prog);
        free((char*)coqlib);
    }
    return self;
}
@end
