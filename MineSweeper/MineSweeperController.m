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

#define kBegginerNumMines 10

-(void)awakeFromNib{
    const int numRows = (int) [self.mineFieldMatrix numberOfRows];
    const int numCols = (int) [self.mineFieldMatrix numberOfColumns];
    mineField = [[MineField alloc] initWithWidth:numRows Height:numCols Mines:kBegginerNumMines];
    [self.scoreTextField setIntegerValue:[mineField unexposedCells]];
}

-(void)clearView{
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
    [mineField reset];
    [self.scoreTextField setIntegerValue:[mineField unexposedCells]];
}

-(IBAction)newGame:(id)sender{
    NSLog(@"newGame:");
    [self clearView];
}

-(IBAction)changeLevel:(NSPopUpButton *)sender{
    const NSInteger index = [sender indexOfSelectedItem];
    NSLog(@"changeLevel: %d", (int) index);
    int w, h, m;
    switch (index){
        case 0: w = h = 10; m = kBegginerNumMines; break;
        case 1: w = 20; h = 15; m = 50; break;
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
    [self clearView];
}

-(IBAction)mineFieldMatrix:(id)sender{
    int r = (int) [sender selectedRow];
    int c = (int) [sender selectedColumn];
    int mr = (int) [self.mineFieldMatrix numberOfRows];
    int mc = (int) [self.mineFieldMatrix numberOfColumns];
    NSButtonCell *bcell = [sender selectedCell];
    Cell* cell = [mineField cellAtRow:r Col:c];

    BOOL shiftKeyDown = ([[NSApp currentEvent] modifierFlags] & (NSShiftKeyMask | NSAlphaShiftKeyMask)) != 0;
    if (shiftKeyDown){
        cell.marked = !cell.marked;
        [bcell setTitle: cell.marked ? @"F" : @""];
        [self.mineFieldMatrix deselectSelectedCell];
    }
    else{
        int clicked = [mineField exposeCellAtRow:r Col:c];
        [bcell setEnabled:NO];
        if(clicked == -1){//bomb hit reveal all cells
            [self.scoreTextField setStringValue:@"BOOM!!!"];
            for(int i = 0; i < mc; i++){
                for(int j = 0; j < mr; j++){
                    bcell = [self.mineFieldMatrix cellAtRow:j column:i];
                    cell  = [mineField cellAtRow:j Col:i];
                    if(cell.hasMine){
                        [bcell setTitle:@"B"];
                    }
                    [bcell setEnabled:NO];
                }
            }
        }
        else if(clicked == 0){
            [self.scoreTextField setIntegerValue:[mineField unexposedCells]];
            for(int i = 0; i < mc; i++){
                for(int j = 0; j < mr; j++){
                    cell = [mineField cellAtRow:j Col:i];
                    if(cell.exposed){
                        bcell = [self.mineFieldMatrix cellAtRow:j column:i];
                        clicked = [mineField exposeCellAtRow:j Col:i];
                        [bcell setTitle:[NSString stringWithFormat:@"%d", cell.numSurroundingMines]];
                        [bcell setEnabled:NO];
                        [bcell setState:1];
                    }
                }
            }
        }
        else{
            [self.scoreTextField setIntegerValue:[mineField unexposedCells]];
            [bcell setTitle:[NSString stringWithFormat:@"%d", clicked]];
        }
    }
    if([mineField unexposedCells] == 0){
        [self.scoreTextField setStringValue:@"Victory!!!"];
        for(int i = 0; i < mc; i++){
            for(int j = 0; j < mr; j++){
                bcell = [self.mineFieldMatrix cellAtRow:j column:i];
                [bcell setEnabled:NO];
            }
        }
    }
}


@end
