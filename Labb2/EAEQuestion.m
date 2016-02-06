//
//  EAEQuestion.m
//  Labb2
//
//  Created by ITHS-Ella on 2016-01-30.
//  Copyright © 2016 ITHS-Ella. All rights reserved.
//

#import "EAEQuestion.h"

@implementation EAEQuestion


- (instancetype)initWithDescription:(NSString*)questionDescription
               andWithCorrectAnswer:(NSString*)correct
                andWithAllAnswers:(NSMutableArray*)allTheAnswers;
{
    self = [super init];
    if (self) {
        self.questionBody = questionDescription;
        self.correctAnswer = correct;
        self.allAnswers =[[NSMutableArray alloc]init];
        self.allAnswers = allTheAnswers;
    }
    return self;
}

@end
