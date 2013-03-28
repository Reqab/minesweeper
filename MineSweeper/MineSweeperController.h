//
//  MineSweeperController.h
//  MineSweeper
//
//  Created by Adam Bennett on 3/26/13.
//  Copyright (c) 2013 WSU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MineSweeperController : NSObject

@property (weak) IBOutlet NSMatrix *mineFieldMatrix;

@property (weak) IBOutlet NSPopUpButton *changeLevel;

@property (weak) IBOutlet NSTextField *scoreTextField;

@end
