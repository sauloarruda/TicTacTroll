//
//  TTTGameEngine.h
//  TicTacTroll
//
//  Created by Saulo Arruda Coelho on 6/27/12.
//  Copyright (c) 2012 Jera. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    TTTGamePlayerForeverAlone = 1,
    TTTGamePlayerTrollFace = 2,
    TTTGamePlayerNone = 3
} TTTGamePlayer;

@interface TTTGameEngine : NSObject

// Return YES if we have a game over
- (BOOL)turn:(NSInteger)buttonIndex;

- (NSInteger)lastComputerTurn;

- (TTTGamePlayer)winner;

@end
