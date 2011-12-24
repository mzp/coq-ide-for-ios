//
//  Coq.m
//  CoqIDE
//
//  Created by mzp on 11/12/15.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "Coq.h"
#include "util.h"
#include "ocamlrun/byterun/alloc.h"
#include "ocamlrun/byterun/mlvalues.h"
#include "ocamlrun/byterun/callback.h"
#undef alloc
#include "ocamlrun/byterun/glue.h"

static NSMutableString* buffer = nil;

int bas_write(int fd, char *buf, int len) {
    if (fd == fileno(stdout)) {
        buf[len] = '\0';
        [buffer appendFormat:@"%s", buf];
    }
    return write(fd, buf, len);
}

@implementation Coq
- (id)init {
    self = [super init];
    if (self) {
        buffer = [[NSMutableString alloc] init];

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

-(BOOL)eval: (NSString*)code {
    const char* s = [code UTF8String];
    [buffer setString: @""];
    value ret = caml_callback(*caml_named_value("eval"),caml_copy_string(s));
    return Bool_val(ret);
}

-(NSString*)message {
    return buffer;
}

-(BOOL)isProofMode {
    value b = caml_callback(*caml_named_value("is_proof_mode"), Val_unit);
    return (Bool_val(b) != 0);
}

-(NSString*)goal {
    value s = caml_callback(*caml_named_value("get_goal"), Val_unit);
    const char* chr = String_val(s);
    return [NSString stringWithUTF8String: chr];
}

-(void)reset {
    caml_callback(*caml_named_value("reset"), Val_unit);
}
@end
