//
//  TTTGameEngine.m
//  TicTacTroll
//
//  Created by Saulo Arruda Coelho on 6/27/12.
//  Copyright (c) 2012 Jera. All rights reserved.
//

#import "TTTGameEngine.h"

@interface TTTGameEngine () {
    NSMutableArray* _turns;
    NSInteger _lastComputerTurn;
    TTTGamePlayer _winner;
}

@end

@implementation TTTGameEngine

- (id)init
{
    self = [super init];
    if (self) {
        _turns = [[NSMutableArray alloc] initWithCapacity:9];
        for (int i=0; i<9; i++) 
            [_turns insertObject:[NSNumber numberWithInt:TTTGamePlayerNone] atIndex:i];
    }
    return self;
}

- (BOOL)gameOver
{
    BOOL gameOver = NO;
    NSLog(@"turns=%@", _turns);
    if ([self checkTurnOnIndex:0]) {
        gameOver = [self checkVertical:0] || [self checkHorizontal:0] || [self checkDiagonal:0];
    } 
    
    if (!gameOver && [self checkTurnOnIndex:1]) {
        gameOver = [self checkVertical:1];
    } 
    
    if (!gameOver && [self checkTurnOnIndex:2]) {
        gameOver = [self checkVertical:2] || [self checkDiagonal:2];
    }
    
    if (!gameOver && [self checkTurnOnIndex:3]) {
        gameOver = [self checkHorizontal:3];
    } 
    
    if (!gameOver && [self checkTurnOnIndex:6]) {
        gameOver = [self checkHorizontal:6];
    }
    
    if (!gameOver) {
        // Check "véia"
        NSInteger turns = 0;
        for (int i=0; i<[_turns count]; i++) {
            if ([[_turns objectAtIndex:i] intValue] == TTTGamePlayerNone) 
                turns++;
        }
        if (turns == 0) {
            _winner = TTTGamePlayerNone;
            return YES;
        }
        return NO;
    }
    
    return gameOver;
}

- (TTTGamePlayer)winner
{
    return _winner;
}

- (BOOL)checkTurnOnIndex:(NSInteger)index
{
    return [[_turns objectAtIndex:index] intValue] != TTTGamePlayerNone; 
}

- (BOOL)checkDiagonal:(NSInteger)index
{
    NSNumber* value = [_turns objectAtIndex:index];
    if (index == 0) 
        return [[_turns objectAtIndex:4] isEqualToNumber:value] && [[_turns objectAtIndex:8] isEqualToNumber:value];
    else
        return [[_turns objectAtIndex:4] isEqualToNumber:value] && [[_turns objectAtIndex:6] isEqualToNumber:value];
}

- (BOOL)checkVertical:(NSInteger)index {
    NSNumber* value = [_turns objectAtIndex:index];
    return [[_turns objectAtIndex:index+3] isEqualToNumber:value]
        && [[_turns objectAtIndex:index+6] isEqualToNumber:value];
}

- (BOOL)checkHorizontal:(NSInteger)index {
    NSNumber* value = [_turns objectAtIndex:index]; 
    return [[_turns objectAtIndex:index+1] isEqualToNumber:value]
    && [[_turns objectAtIndex:index+2] isEqualToNumber:value];
}


- (BOOL)turn:(NSInteger)buttonIndex
{
    NSLog(@"Player: %d", buttonIndex);
    [_turns replaceObjectAtIndex:buttonIndex withObject:[NSNumber numberWithInt:TTTGamePlayerForeverAlone]];
    
    if (![self gameOver]) {
        [self computerPlay];
        BOOL gameOver = [self gameOver];
        if (gameOver && _winner != TTTGamePlayerNone) 
            _winner = TTTGamePlayerTrollFace;
        return gameOver;
    } else {
        if (_winner != TTTGamePlayerNone)
            _winner = TTTGamePlayerForeverAlone;
    }
    return YES;    
}

- (NSInteger)lastComputerTurn
{
    return _lastComputerTurn;
}

- (void)computerPlay
{
    NSMutableArray* freeIndexes = [[NSMutableArray alloc] initWithCapacity:8];
    for (int i=0; i<[_turns count]; i++) {
        if ([[_turns objectAtIndex:i] intValue] == TTTGamePlayerNone) {
            [freeIndexes addObject:[NSNumber numberWithInt:i]];
        }
    }
    
    NSInteger randomPosition = arc4random_uniform([freeIndexes count]);
    _lastComputerTurn = [[freeIndexes objectAtIndex:randomPosition] intValue];
    [_turns replaceObjectAtIndex:_lastComputerTurn withObject:[NSNumber numberWithInt:TTTGamePlayerTrollFace]];
}

@end
