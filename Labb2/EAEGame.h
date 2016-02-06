//
//  EAEGame.h
//  Labb2
//
//  Created by ITHS-Ella on 2016-02-01.
//  Copyright © 2016 ITHS-Ella. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EAEQuestion.h"


@interface EAEGame : NSObject

@property (readonly,nonatomic) BOOL isFinished;

@property(readonly,nonatomic) int correctPoints;
@property(readonly,nonatomic) int incorrectPoints;

-(void)startNewGame;
-(EAEQuestion*)getRoundQuestion;
-(NSString*)getActualQuestionNumber;
-(BOOL)playRound:(NSString *)answer;


@end