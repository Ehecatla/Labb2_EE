//
//  EAEQuestion.h
//  Labb2
//
//  Created by ITHS-Ella on 2016-01-30.
//  Copyright © 2016 ITHS-Ella. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EAEQuestion : NSObject

@property (strong, nonatomic) NSString *questionBody;
@property (strong, nonatomic) NSString *correctAnswer;
@property (strong, nonatomic) NSMutableArray *allAnswers;

//create question with description, correct answer and all the answers with the
//correct one added to them aswell
- (instancetype)initWithDescription:(NSString*)questionDescription
               andWithCorrectAnswer:(NSString*)correct
                andWithAllAnswers:(NSMutableArray*)allTheAnswers;
@end
