//
//  Cell.h
//  mineproto
//
//  Created by Wayne Cochran on 4/21/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface Cell : NSObject

@property(assign, readwrite) BOOL hasMine; // cell has a mine
@property(assign, readwrite) BOOL exposed; // cell has been exposed (may or may not have mine)
@property(assign, readwrite) BOOL marked;  // cell marked as having a mine (perhaps incorrectly)
@property(assign, readwrite) char numSurroundingMines; // number of mines in 8 neighbors

-(id)init;

@end
