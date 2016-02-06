//
//  GameViewController.m
//  Labb2
//
//  Created by ITHS-Ella on 2016-01-29.
//  Copyright © 2016 ITHS-Ella. All rights reserved.
//

#import "GameViewController.h"


@interface GameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *questionTitleLabel;
@property (weak, nonatomic) IBOutlet UITextView *questionText;
@property (weak, nonatomic) IBOutlet UILabel *questionFeedback;
@property (weak, nonatomic) IBOutlet UIButton *continueButton;

@property (weak, nonatomic) IBOutlet UIButton *answer1;
@property (weak, nonatomic) IBOutlet UIButton *answer2;
@property (weak, nonatomic) IBOutlet UIButton *answer3;
@property (weak, nonatomic) IBOutlet UIButton *answer4;

@property(strong, nonatomic) UIButton * chosenButton;                             //chosen button reference
@property(weak, nonatomic) UIColor * defaultButtonColor;
@property (strong, nonatomic) EAEGame * game;

-(void)prepareNewGame;
-(void) loadQuestionView;
-(void)resetButtons;
-(void)loadResultView;

@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.game = [[EAEGame alloc]init];
    [self prepareNewGame];
    self.defaultButtonColor = [UIColor groupTableViewBackgroundColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//Method prepareNewGame runs methods needed to start a new quiz game which is
//sending request for new game to Game EAEGame class and loading first question to
//view.
-(void)prepareNewGame{
    [self.game startNewGame];
    [self loadQuestionView];
    self.answer1.hidden=NO;
    self.answer2.hidden=NO;
    self.answer3.hidden=NO;
    self.answer4.hidden=NO;
    self.questionFeedback.hidden=NO;
}


//Method resetButtons reset view buttons and feedback labels to default values
//to be used in between every round in a quiz game.
-(void)resetButtons{

    NSString * questionNr = [NSString stringWithFormat:@"Question number: %@",
                             [self.game getActualQuestionNumber] ];
    
    [self.questionTitleLabel setText:questionNr];
    [self.questionFeedback setText:@"Choose one answer"];
    [self.continueButton setTitle:@"Continue" forState:UIControlStateNormal];
    self.continueButton.hidden =YES;
    [self.chosenButton setBackgroundColor:self.defaultButtonColor];
    self.chosenButton = nil;
    
}

//Method loadResultView displays result of finished game and hides unnecesary
//buttons and text that is used to display questions during active game
-(void)loadResultView{
    
    [self.continueButton setTitle:@"Replay" forState:UIControlStateNormal];
    self.questionFeedback.hidden=YES;
    self.answer1.hidden=YES;
    self.answer2.hidden=YES;
    self.answer3.hidden=YES;
    self.answer4.hidden=YES;
    
    [self.questionTitleLabel setText:@"Game finished"];
    NSString * result = [NSString stringWithFormat:@"Number correct answers: %d \nNumber incorrect answers: %d",
                        self.game.correctPoints, self.game.incorrectPoints ];
    [self.questionText setText:result];
    
}


//Method loadQuestionView loads the actual question data to the view assigning
//questions body and answers to textview and buttons.
-(void) loadQuestionView{
    if(!self.game.isFinished){
        [self resetButtons];
        
        NSString *description = [self.game getRoundQuestion].questionBody;
        NSArray *answers = [self.game getRoundQuestion].allAnswers;
        
        [self.answer1 setTitle:[answers objectAtIndex:0] forState:UIControlStateNormal];
        [self.answer2 setTitle:[answers objectAtIndex:1] forState:UIControlStateNormal];
        [self.answer3 setTitle:[answers objectAtIndex:2] forState:UIControlStateNormal];
        [self.answer4 setTitle:[answers objectAtIndex:3] forState:UIControlStateNormal];
        [self.questionText setText:description];
        
    }
}


//Method chooseAnswer runs when an answer button is clicked, this method runs the
//EAEGame object method to check the answer and displays feedback
- (IBAction)chooseAnswer:(UIButton *)sender {
    if(self.chosenButton == nil){
        
        self.chosenButton = sender;                                             //blocks rechoosing answer
        NSString * chosenAnswer = [self.chosenButton currentTitle];
        NSString * feedbackAnswer = [NSString stringWithFormat:@"Answer is: %@",
                                     [self.game getRoundQuestion].correctAnswer];
        
        [self.questionFeedback setText:feedbackAnswer];
        BOOL isCorrectAnswer = [self.game playRound:chosenAnswer];              //play question and get feedback if answer was correct
        if(isCorrectAnswer){
            [self.chosenButton setBackgroundColor:[UIColor greenColor]];
        } else {
            [self.chosenButton setBackgroundColor:[UIColor redColor]];
        }
        self.continueButton.hidden = NO;
    }
}


//Method chooseContinueButton is used when user clicks on continue button, then
//either new question is displayed or if game is finished a result feedback is
//shown
- (IBAction)chooseContinueButton:(UIButton *)sender {
    if([self.game isFinished] && ([[sender currentTitle] containsString:@"Replay"])){
        [self prepareNewGame];
    } else if ([self.game isFinished]){
        [self loadResultView];
    } else {
        [self loadQuestionView];
    }
}


@end
