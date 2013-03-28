//
//  MineSweeperController.m
//  MineSweeper
//
//  Created by Adam Bennett on 3/26/13.
//  Copyright (c) 2013 WSU. All rights reserved.
//

#import "MineSweeperController.h"

@implementation MineSweeperController{
    MineField *mineField;
}

#define kBegginerNumMines 20

-(void)awakeFromNib{
    const int numRows = (int) [self.mineFieldMatrix numberOfRows];
    const int numCols = (int) [self.mineFieldMatrix numberOfColumns];
}

-(IBAction)newGame:(id)sender{
    NSLog(@"newGame:");
    [self.mineFieldMatrix deselectAllCells];
    const int numRows = (int) [self.mineFieldMatrix numberOfRows];
    const int numCols = (int) [self.mineFieldMatrix numberOfColumns];
    for (int r = 0; r < numRows; r++) {
        for(int c = 0; c < numCols; c++){
            NSButtonCell *bcell = [self.mineFieldMatrix cellAtRow:r column:c]
            [bcell setTitle:@""];
            [bcell setEnabled:YES];
        }
    }
}

@end
