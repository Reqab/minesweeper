//
//  Cell.m
//  mineproto
//
//  Created by Wayne Cochran on 4/21/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Cell.h"

@implementation Cell

@synthesize hasMine;
@synthesize exposed;
@synthesize marked;
@synthesize numSurroundingMines;

-(id)init {
    self = [super init];
    if (self != nil) {
        hasMine = exposed = NO;
        marked = numSurroundingMines = 0;
    }
    return self;
}

@end
