//
//  TTTViewController.m
//  TicTacTroll
//
//  Created by Saulo Arruda Coelho on 6/27/12.
//  Copyright (c) 2012 Jera. All rights reserved.
//

#import "TTTViewController.h"
#import "TTTGameEngine.h"

NSInteger kTagIncrement = 5000;

@interface TTTViewController ()
{
    TTTGameEngine* _actualGame;
}

- (IBAction)buttonTapped:(UIButton *)sender;
- (IBAction)newGameButtonTapped:(id)sender;

@end

@implementation TTTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _actualGame = [[TTTGameEngine alloc] init];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)buttonTapped:(UIButton *)button
{
    UIImage* image = [UIImage imageNamed:@"bgForeverAlone"];
    [button setImage:image forState:UIControlStateNormal];
    [button setEnabled:NO];
    
    BOOL gameOver = [_actualGame turn:button.tag-kTagIncrement];
    
    //if (!gameOver) {
        // Show computer turn
        NSInteger computerButtonIndex = [_actualGame lastComputerTurn];
        UIButton* computerButton = (UIButton*)[self.view viewWithTag:kTagIncrement+computerButtonIndex];
        [computerButton setEnabled:NO];
        [computerButton setImage:[UIImage imageNamed:@"bgTrollFace"] forState:UIControlStateNormal];
   // } 

    if (gameOver) {
        NSString* winner = nil;
        switch ([_actualGame winner]) {
            case TTTGamePlayerForeverAlone:
                winner = @"Você venceu!";
                break;
            case TTTGamePlayerTrollFace:
                winner = @"Troll Venceu!";
                break;
            case TTTGamePlayerNone:
                winner = @"Deu velha!";
                break;
        }
        [[[UIAlertView alloc] initWithTitle:@"Game Over" message:winner delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
}

- (IBAction)newGameButtonTapped:(id)sender {
    _actualGame = [[TTTGameEngine alloc] init];
    
    for (int i=0; i<9; i++) {
        UIButton* button = (UIButton*)[self.view viewWithTag:kTagIncrement+i];
        [button setEnabled:YES];
        [button setImage:nil forState:UIControlStateNormal];
    }
}

@end
