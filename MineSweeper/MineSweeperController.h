//
//  MineSweeperController.h
//  MineSweeper
//
//  Created by Adam Bennett on 3/26/13.
//  Copyright (c) 2013 WSU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MineField.h"

@interface MineSweeperController : NSObject

@property (weak) IBOutlet NSMatrix *mineFieldMatrix;
@property (weak) IBOutlet NSPopUpButton *changeLevel;
@property (weak) IBOutlet NSTextField *scoreTextField;
@property (unsafe_unretained) IBOutlet NSWindow *mainWindow;

-(IBAction)newGame:(id)sender;
-(IBAction)changeLevel:(id)sender;
-(IBAction)mineFieldMatrix:(id)sender;
-(void)clearView;

@end
