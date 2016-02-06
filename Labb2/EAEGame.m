//
//  EAEGame.m
//  Labb2
//
//  Created by ITHS-Ella on 2016-02-01.
//  Copyright © 2016 ITHS-Ella. All rights reserved.
//

#import "EAEGame.h"


@interface EAEGame ()

@property (strong, nonatomic) NSMutableArray * questionList;
@property (strong, nonatomic) NSMutableArray * gameQuestions;

@property(readwrite,nonatomic) int correctPoints;
@property(readwrite,nonatomic) int incorrectPoints;

@property (readwrite,nonatomic) BOOL isFinished;
@property (nonatomic) int actualQuestionNumber;

-(void)generateRandomGameQuestions;
-(NSMutableArray *)generateQuestionSource;

@end

@implementation EAEGame

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.actualQuestionNumber = 0;
        self.isFinished = NO;
        self.questionList = [[NSMutableArray alloc]init];
        self.questionList = [self generateQuestionSource ];
        self.gameQuestions= [[NSMutableArray alloc]init];
        
    }
    return self;
}


//method starts new game for the object by generating new chosen list of game
//questions, reseting points, marking game unsfinished and reseting actualQNr
-(void)startNewGame{
    [self generateRandomGameQuestions];
    self.correctPoints = 0;
    self.incorrectPoints=0;
    self.isFinished= NO;
    self.actualQuestionNumber =0;
}


//method returns the actual question of the game based on Index
-(EAEQuestion*)getRoundQuestion{
    EAEQuestion *actualQuestion = [self.gameQuestions objectAtIndex:self.actualQuestionNumber];
    return actualQuestion;
}


//method playRound checks the given string answer if its correct for the actual
//question and moves game to next round. method returns YES if given answer was
//correct, otherwise it returns NO
-(BOOL)playRound:(NSString *)answer{
    BOOL isCorrectAnswer =NO;
    NSString *actualQuestionAnswer = [[self.gameQuestions objectAtIndex:self.actualQuestionNumber] correctAnswer];
    if([answer isEqualToString:actualQuestionAnswer]) {
        self.correctPoints ++;
        isCorrectAnswer=YES;
    } else{
        self.incorrectPoints ++;
    }
    // move to next question if not last
    self.actualQuestionNumber ++;
    if(self.actualQuestionNumber >= [self.gameQuestions count]){
        self.isFinished = YES;
    }
    return isCorrectAnswer;
}


//method that gets random, distinc question list containing 5 questions
//it even shuffles answers!
-(void)generateRandomGameQuestions{

    int maxNumber = [self.questionList count];
    NSMutableArray * randomList = [[NSMutableArray alloc]init];
    for (int i=0; i <5; i++) {
        
        BOOL continueSearch = YES;
        do {
            EAEQuestion * randomQuestion = self.questionList[arc4random() % maxNumber];
            
            if([randomList count] > 0){
                if(![randomList containsObject:randomQuestion]){
                    [randomList addObject:randomQuestion ];
                    continueSearch = NO;
                }
            } else {
                [randomList addObject:randomQuestion ];
                continueSearch = NO;
            }
        } while(continueSearch);
    }
   self.gameQuestions = randomList;
}


//returns actual question number starting counting from 1
-(NSString*)getActualQuestionNumber{
    int number = self.actualQuestionNumber +1;
    NSString * nr = [NSString stringWithFormat:@"%d", number];
    return nr;
}


//method generates an arraylist of questions to be used in game!
-(NSMutableArray*)generateQuestionSource{
    
    //Question 1
    NSString * q1Body = @"How much is: 5*5 - 5 +2 /2 ?";
    NSString * q1Correct = @"21";
    NSMutableArray * q1Answers = [[NSMutableArray alloc]init];
    q1Answers = [@[@"11", @"0", @"3", q1Correct]mutableCopy];
    EAEQuestion *q1 = [[EAEQuestion alloc]initWithDescription:q1Body
                                         andWithCorrectAnswer:q1Correct
                                          andWithAllAnswers:q1Answers ];
    
    //Question 2
 
    NSString * q2Body = @"How much is: 100/10 ?";
    NSString * q2Correct = @"10";
    NSMutableArray * q2Answers = [[NSMutableArray alloc]init];
    q2Answers = [@[@"1", @"0", @"001", q2Correct]mutableCopy];
    EAEQuestion *q2 = [[EAEQuestion alloc]initWithDescription:q2Body
                                         andWithCorrectAnswer:q2Correct
                                            andWithAllAnswers:q2Answers ];
    
    //Question 3
    
    NSString * q3Body = @"How much is: 10/0?";
    NSString * q3Correct = @"Undefined division";
    NSMutableArray * q3Answers = [[NSMutableArray alloc]init];
    q3Answers = [@[@"0", @"10", @"0,1", q3Correct]mutableCopy];
    EAEQuestion *q3 = [[EAEQuestion alloc]initWithDescription:q3Body
                                         andWithCorrectAnswer:q3Correct
                                            andWithAllAnswers:q3Answers ];
    
    //Question 4
    
    NSString * q4Body = @"How much is: 4^2 + 2^4 ?";
    NSString * q4Correct = @"32";
    NSMutableArray * q4Answers = [[NSMutableArray alloc]init];
    q4Answers = [@[@"16", @"64", @"20", q4Correct]mutableCopy];
    EAEQuestion *q4 = [[EAEQuestion alloc]initWithDescription:q4Body
                                         andWithCorrectAnswer:q4Correct
                                          andWithAllAnswers:q4Answers ];
    
    //Question 5
    
    NSString * q5Body = @"Which one is prime number?";
    NSString * q5Correct = @"17";
    NSMutableArray * q5Answers = [[NSMutableArray alloc]init];
    q5Answers = [@[@"27", @"33", @"None above", q5Correct]mutableCopy];
    EAEQuestion *q5 = [[EAEQuestion alloc]initWithDescription:q5Body
                                         andWithCorrectAnswer:q5Correct
                                          andWithAllAnswers:q5Answers ];
    
    //Question 6
    
    NSString * q6Body = @"How much is: (2+2)^2 ?";
    NSString * q6Correct = @"16";
    NSMutableArray * q6Answers = [[NSMutableArray alloc]init];
    q6Answers = [@[@"12", @"6", @"8", q6Correct]mutableCopy];
    EAEQuestion *q6 = [[EAEQuestion alloc]initWithDescription:q6Body
                                         andWithCorrectAnswer:q6Correct
                                          andWithAllAnswers:q6Answers ];
    
    //Question 7
    
    NSString * q7Body = @"How much is: 5 * 0,5 ?";
    NSString * q7Correct = @"2,5";
    NSMutableArray * q7Answers = [[NSMutableArray alloc]init];
    q7Answers = [@[@"25", @"2", @"0,25", q7Correct]mutableCopy];
    EAEQuestion *q7 = [[EAEQuestion alloc]initWithDescription:q7Body
                                         andWithCorrectAnswer:q7Correct
                                          andWithAllAnswers:q7Answers ];
    
    //Question 8
    
    NSString * q8Body = @"How much is: 3*297 ?";
    NSString * q8Correct = @"891";
    NSMutableArray * q8Answers = [[NSMutableArray alloc]init];
    q8Answers = [@[@"921", @"887", @"896", q8Correct]mutableCopy];
    EAEQuestion *q8 = [[EAEQuestion alloc]initWithDescription:q8Body
                                         andWithCorrectAnswer:q8Correct
                                          andWithAllAnswers:q8Answers ];
    
    //Question 9
    
    NSString * q9Body = @"How much is: 150/3 ?";
    NSString * q9Correct = @"50";
    NSMutableArray * q9Answers = [[NSMutableArray alloc]init];
    q9Answers = [@[@"33", @"75", @"0,50", q9Correct]mutableCopy];
    EAEQuestion *q9 = [[EAEQuestion alloc]initWithDescription:q9Body
                                         andWithCorrectAnswer:q9Correct
                                          andWithAllAnswers:q9Answers ];
    
    //Question 10
    
    NSString * q10Body = @"How much is: 1200/0,12 ?";
    NSString * q10Correct = @"10 000";
    NSMutableArray * q10Answers = [[NSMutableArray alloc]init];
    q10Answers = [@[@"120", @"12", @"1000", q10Correct]mutableCopy];
    EAEQuestion *q10 = [[EAEQuestion alloc]initWithDescription:q10Body
                                          andWithCorrectAnswer:q10Correct
                                           andWithAllAnswers:q10Answers ];
    
    NSMutableArray *questions = [@[q1,q2,q3,q4,q5,q6,q7,q8,q9,q10]mutableCopy];
    return questions;
}

@end
