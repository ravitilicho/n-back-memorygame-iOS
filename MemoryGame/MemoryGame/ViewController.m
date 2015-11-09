//
//  ViewController.m
//  MemoryGame
//
//  Created by Ravindar Katkuri on 16/10/15.
//  Copyright © 2015 Tilicho Labs. All rights reserved.
//

#import "ViewController.h"
#import "QuestionsEngine.h"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UILabel *arithmeticQuestionLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *gridQuestionCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *arithmeticAnswersCollectionView;
@property (weak, nonatomic) IBOutlet UIButton *skipRoundButton;
@property (weak, nonatomic) IBOutlet UILabel *gameplayStatusLabel;

@property (nonatomic) QuestionsEngine *questionEngine;
@property (nonatomic) TLQuestion *currentQuestion;
@property (nonatomic) TLGameOutcomeHandler *outcomeHandler;
@property (nonatomic) NSInteger totalScore;

- (void)renderScoreLabel:(NSInteger)score;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_skipRoundButton addTarget:self
                         action:@selector(onClickSkipRoundButton:)
       forControlEvents:UIControlEventTouchUpInside];
    
    _outcomeHandler = [[self questionEngine] outcomeHandler];
    [self handleRound];
}

#pragma mark - Core methods

- (void)handleRound {
    
    _currentQuestion = [[self questionEngine] getNextQuestion];
    [_outcomeHandler registerQuestion:_currentQuestion];
    
//    [self renderArithmeticQuestionLabel];
    [self renderScoreLabel:0];
    [_gridQuestionCollectionView reloadData];
    [_arithmeticAnswersCollectionView reloadData];
    [_skipRoundButton setEnabled:[_outcomeHandler canStartNBackRound]];
    
    if (![_outcomeHandler canStartNBackRound]) {
        // Wait for 3 seconds and go to next round
        double delayInSeconds = 3.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            /* TODO: Fix this recursion */
            [self nextRound];
        });
    }
}

- (void)nextRound {
    if ([_outcomeHandler canGoToNextRound]) {
        [self handleRound];
    }
}

- (QuestionsEngine *)questionEngine {
    if (_questionEngine == nil) {
        _questionEngine = [QuestionsEngine new];
    }
    return _questionEngine;
}

- (void)renderArithmeticQuestionLabel {
    NSString *arithmeticQuestion = [NSString stringWithFormat:@"%@ = ?", [[_currentQuestion arithmeticQuestion] questionString]];
    [_arithmeticQuestionLabel setText:arithmeticQuestion];
    [_arithmeticQuestionLabel setNeedsDisplay];
}

// Adds the event score to the total score and renders it
- (void)renderScoreLabel:(NSInteger)score {
    _totalScore += score;
    
    NSString *scoreString = [NSString stringWithFormat:@"Score: %ld", (long)_totalScore];
    [_scoreLabel setText:scoreString];
    [_scoreLabel setNeedsDisplay];
}


#pragma mark - UICollectionViewDataSource methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (collectionView == _gridQuestionCollectionView) {
        return 9;
    } else if (collectionView == _arithmeticAnswersCollectionView) {
        return _currentQuestion ? [[_currentQuestion arithmeticAnswerOptions] count] : 10;
    }
    
    return 0;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell;
    
    if (collectionView == _gridQuestionCollectionView) {
        
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GridQuestionCell" forIndexPath:indexPath];
        UILabel *label = (UILabel *)[[cell contentView] viewWithTag:1];
        
        if (indexPath.row == _currentQuestion.gridAnswer) {
            
            cell.contentView.backgroundColor = UIColorFromRGB(0xFEFB00);
            NSString *arithmeticQuestion = [NSString stringWithFormat:@"%@ = ?", [[_currentQuestion arithmeticQuestion] questionString]];
            [label setText:arithmeticQuestion];
            [label setNeedsDisplay];
            
        } else {
            
            cell.contentView.backgroundColor = UIColorFromRGB(0x76D5FF);
            [label setText:@""];
            [label setNeedsDisplay];

        }

        
    } else { // if (collectionView == _arithmeticAnswersCollectionView)
        
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ArithmeticAnswerCell" forIndexPath:indexPath];
        UILabel *label = (UILabel *)[[cell contentView] viewWithTag:1];
        [label setText:[NSString stringWithFormat:@"%@", [_currentQuestion arithmeticAnswerOptions][indexPath.row]]];
        
    }

    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([_outcomeHandler canStartNBackRound]) {
        
        UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];

        // Listen to tap on cell only if current grid question is not answered already
        if ((collectionView == _gridQuestionCollectionView) && ![_outcomeHandler isCurrentRoundGridQuestionAnswered]) {
            
            // Change Background color
            // TODO: Doesn't work, fix it! Animate later
            [cell setBackgroundColor:UIColorFromRGB(0xD783FF)];
            
            // Generate Score
            TLEventScore *eventScore = [_outcomeHandler getRoundScore:[TLEventInput forColorGridInputEvent:indexPath.row question:_currentQuestion]];
            
            if ([eventScore outcome] == COLOR_GRID_CORRECT) {
                NSLog([NSString stringWithFormat:@"Incrementing score by %ld", (long)[eventScore score]]);
                [self renderScoreLabel:[eventScore score]];
                
            } else {
                NSLog([NSString stringWithFormat:@"Decrementing score by %ld", (long)[eventScore score]]);
                [self renderScoreLabel:[eventScore score]];
            }
            
            // Revert background color
            double delayInSeconds = 0.5;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [self nextRound];
            });
            
            [cell setBackgroundColor:UIColorFromRGB(0x76D5FF)];
            
            // Listen to tap on cell only if current grid question is not answered already
        } else if (collectionView == _arithmeticAnswersCollectionView && ![_outcomeHandler isCurrentRoundArithmeticQuestionAnswered]) {
            
            // Generate Score
            TLEventScore *eventScore = [_outcomeHandler getRoundScore:[TLEventInput forArithmeticInputEvent:indexPath.row question:_currentQuestion]];
            
            // Update Score label
            if ([eventScore outcome] == ARITHMETIC_CORRECT) {
                NSLog([NSString stringWithFormat:@"Incrementing score by %ld", (long)[eventScore score]]);
                [self renderScoreLabel:[eventScore score]];
                
            } else {
                NSLog([NSString stringWithFormat:@"Decrementing score by %ld", (long)[eventScore score]]);
                [self renderScoreLabel:[eventScore score]];
            }
            
            double delayInSeconds = 0.5;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [self nextRound];
            });
            
        }
    }
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: Deselect item
}

#pragma mark – UICollectionViewDelegateFlowLayout

// 1
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (collectionView == _gridQuestionCollectionView) {
        
        return CGSizeMake(94, 94);
        
    } else { // if (collectionView == _arithmeticAnswersCollectionView)
        
        return CGSizeMake(50, 50);
    }
}

#pragma mark - 

- (void)onClickSkipRoundButton:(UIButton *)sender {
    
    [_skipRoundButton setEnabled:NO];
    
    TLEventScore *eventScore = [_outcomeHandler getRoundScore:[TLEventInput forSkipInputEvent:0 question:_currentQuestion]];
    
    // Update Score label
    NSLog([NSString stringWithFormat:@"Decrementing score by %ld", (long)[eventScore score]]);
    [self renderScoreLabel:[eventScore score]];
    
    double delayInSeconds = 0.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self nextRound];
    });
    
    [_skipRoundButton setEnabled:[_outcomeHandler canStartNBackRound]];

}

@end
