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
    mineField = [[MineField alloc] initWithWidth:numRows Height:numCols Mines:kBegginerNumMines];
}

-(IBAction)newGame:(id)sender{
    NSLog(@"newGame:");
    [self.mineFieldMatrix deselectAllCells];
    const int numRows = (int) [self.mineFieldMatrix numberOfRows];
    const int numCols = (int) [self.mineFieldMatrix numberOfColumns];
    for (int r = 0; r < numRows; r++) {
        for(int c = 0; c < numCols; c++){
            NSButtonCell *bcell = [self.mineFieldMatrix cellAtRow:r column:c];
            [bcell setTitle:@""];
            [bcell setEnabled:YES];
        }
    }
}

-(IBAction)changeLevel:(NSPopUpButton *)sender{
    const NSInteger index = [sender indexOfSelectedItem];
    NSLog(@"changeLevel: %d", (int) index);
    int w, h, m;
    switch (index){
        case 0: w = h = 10; m = 10; break;
        case 1: w = 20; h = 15; m=50; break;
        case 2: w = 25; h = 18; m = 90; break;
        case 3: w = 30; h = 20; m = 150; break;
    }
    CGRect oldMatrixFrame = [self.mineFieldMatrix frame];
    [self.mineFieldMatrix renewRows:h columns:w];
    [self.mineFieldMatrix sizeToCells];
    
    CGRect matrixFrame = [self.mineFieldMatrix frame];
    const CGFloat dx = matrixFrame.size.width-oldMatrixFrame.size.width;
    const CGFloat dy = matrixFrame.size.height-oldMatrixFrame.size.height;
    NSWindow *win = self.mineFieldMatrix.window;
    const CGRect oldWinFrame = win.frame;
    const CGRect newFrame = CGRectMake(oldWinFrame.origin.x, oldWinFrame.origin.y, oldWinFrame.size.width+dx, oldWinFrame.size.height+dy);
    [win setFrame:newFrame display:YES animate:NO];
    mineField = [[MineField alloc] initWithWidth:w Height:h Mines:m];
}

-(IBAction)mineFieldMatrix:(id)sender{
    long r = [sender selectedRow];
    long c = [sender selectedColumn];
    NSLog(@"mineFieldSelected: cell index = (%d, %d)",(int) r, (int) c);
    NSButtonCell *bcell = [sender selectedCell];
    NSLog(@"%@", bcell);
    [bcell setEnabled:NO];
}


@end
