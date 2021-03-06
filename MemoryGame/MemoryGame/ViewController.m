//
//  ViewController.m
//  MemoryGame
//
//  Created by Ravindar Katkuri on 16/10/15.
//  Copyright © 2015 Tilicho Labs. All rights reserved.
//

#import "ViewController.h"
#import "QuestionsEngine.h"
#import "TLGameOptions.h"
#import "ModeOptions.h"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *gridQuestionCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *arithmeticAnswersCollectionView;
@property (weak, nonatomic) IBOutlet UIButton *skipRoundButton;
@property (weak, nonatomic) IBOutlet UILabel *gameplayStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeRemainingLabel;

@property (nonatomic) ModeOptions *modeOptions;
@property (nonatomic) NSMutableArray *currentRoundScores;
@property (nonatomic) NSMutableArray *currentRoundTimeRemainingOffsets;
@property (nonatomic) QuestionsEngine *questionEngine;
@property (nonatomic) TLQuestion *currentQuestion;
@property (nonatomic) TLGameOutcomeHandler *outcomeHandler;

// In seconds
@property (nonatomic) NSInteger timeRemaining;

- (void)renderScoreLabel;
- (void)renderGameplayStatusLabelWith:(NSString *)text;

@end

@implementation ViewController

NSInteger SurvivalModeMaxTimeRemaining = 150;
int rounds = 0;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [_skipRoundButton addTarget:self
                         action:@selector(onClickSkipRoundButton:)
               forControlEvents:UIControlEventTouchUpInside];
    
    NumberRange nBackCategoryRange = {1, 4};
    NumberRange gridQuestionWidthRange = {3, 5};
    ModeOptions *modeOptions = [[ModeOptions alloc] init];
    [modeOptions setNBackCategoryRange:nBackCategoryRange];
    [modeOptions setGridQuestionLengthRange:gridQuestionWidthRange];
    [modeOptions setGameplayMode:@"SURVIVAL"];
    
    _modeOptions = modeOptions;
    [TLGameOptions persist:_modeOptions];
    
    _outcomeHandler = [[TLGameOutcomeHandler alloc] initWithModeOptions:modeOptions viewController:self callback:@selector(updateTimeRemainingLabel)];
    
    // TODO: Should this be moved to OutcomeHandler alike total score?
    _timeRemaining = 90;
    
    [self handleRound];
    
}

#pragma mark - Core methods

- (void)handleRound {
    
    if (rounds == 0) {
        
        [self renderGameplayStatusLabelWith:@"Remember highlighted grid position and arithmetic question..."];
        
    } else if (rounds == [TLGameOptions nBackCategory]) {
        
        [self renderGameplayStatusLabelWith:@"Tap on the previous rounds' highlighted grid and arithmetic question answer"];
        
    }
    
    [self renderScoreLabel];
    _currentQuestion = [[self questionEngine] getNextQuestion];
    [_outcomeHandler registerQuestion:_currentQuestion];
    
    [_gridQuestionCollectionView reloadData];
    [_arithmeticAnswersCollectionView reloadData];
    [_skipRoundButton setEnabled:[_outcomeHandler canStartNBackRound]];
    
    rounds++;
    
    if (![_outcomeHandler canStartNBackRound]) {
        
        // Show current round for 3 seconds and go to next round
        double delayInSeconds = 3.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            /* TODO: Fix this recursion */
            [self nextRound];
        });
        
    } else if (rounds == [TLGameOptions nBackCategory] + 1){
        
        [_outcomeHandler startGame];
        
    }
}

- (void)nextRound {
    
    if ([_outcomeHandler canGoToNextRound]) {
        
        // Check for next level eligibility first
        [self handleGameLevel];
        
        [self handleRound];
        
    }
}

- (QuestionsEngine *)questionEngine {
    
    if (_questionEngine == nil) {
        
        _questionEngine = [[QuestionsEngine alloc] initWithOutcomeHandler:[self outcomeHandler]];
        
    }
    
    return _questionEngine;
}

// Adds the event score to the total score and renders it
- (void)renderScoreLabel {
    
    NSString *scoreString = [NSString stringWithFormat:@"Score: %ld", [_outcomeHandler gameTotalScore]];
    [_scoreLabel setText:scoreString];
    [_scoreLabel setNeedsDisplay];
    
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (collectionView == _gridQuestionCollectionView) {
        
        Point gridSizeFromOptions = [TLGameOptions gridQuestionSize];
        return gridSizeFromOptions.h * gridSizeFromOptions.v;
        
    } else if (collectionView == _arithmeticAnswersCollectionView) {
        
        return _currentQuestion ? [[_currentQuestion arithmeticAnswerOptions] count] : 10;
        
    }
    
    return 0;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell;
    
    if (collectionView == _gridQuestionCollectionView) {
        
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GridQuestionCell" forIndexPath:indexPath];
        [cell.contentView.layer setBorderColor:[UIColorFromRGB(0xD783FF) CGColor]];
        [cell.contentView.layer setBorderWidth:0.0];
        
        UILabel *label = (UILabel *)[[cell contentView] viewWithTag:1];
        
        if (indexPath.row == _currentQuestion.gridAnswer) {
            
            cell.contentView.backgroundColor = UIColorFromRGB(0xFEFB00);
            
            NSString *arithmeticQuestion = [NSString stringWithFormat:@"%@=?", [[_currentQuestion arithmeticQuestion] questionString]];
            [label setText:arithmeticQuestion];
            [label setNeedsDisplay];
            
        } else {
            
            cell.contentView.backgroundColor = UIColorFromRGB(0x76D5FF);
            [label setText:@""];
            [label setNeedsDisplay];

        }

        
    } else if (collectionView == _arithmeticAnswersCollectionView) {
        
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ArithmeticAnswerCell" forIndexPath:indexPath];
        [cell.contentView.layer setBorderColor:[UIColorFromRGB(0xD783FF) CGColor]];
        [cell.contentView.layer setBorderWidth:0.0];
        
        // Round the cell corners
        UIView *roundedCornersView=[[UIView alloc]initWithFrame:cell.frame];
        roundedCornersView.backgroundColor=UIColorFromRGB(0xFFCC66);
        UIBezierPath *maskpath=[UIBezierPath bezierPathWithRoundedRect:roundedCornersView.bounds byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight|UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(10.0,10.0)];
        CAShapeLayer *maskLayer=[CAShapeLayer layer];
        maskLayer.frame=roundedCornersView.bounds;
        maskLayer.path=maskpath.CGPath;
        roundedCornersView.layer.mask=maskLayer;
        cell.backgroundView=roundedCornersView;
        [cell setBackgroundColor:[UIColor clearColor]];
        
        // Label cell with answer options
        UILabel *label = (UILabel *)[[cell contentView] viewWithTag:1];
        [label setText:[NSString stringWithFormat:@"%@", [_currentQuestion arithmeticAnswerOptions][indexPath.row]]];
        
    }

    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    // Listen to taps only when game is not paused or there is some remaining time
    if ([_outcomeHandler canStartNBackRound] && ![_outcomeHandler isPaused] && ![self isGameOver]) {
        
        UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];

        // Listen to tap on cell only if current grid question is not answered already
        if ((collectionView == _gridQuestionCollectionView) && ![_outcomeHandler isCurrentRoundGridQuestionAnswered]) {
            
            [cell.contentView.layer setBorderWidth:3.0];
            
            // Generate Score
            TLEventScore *eventScore = [_outcomeHandler getRoundScore:[TLEventInput forColorGridInputEvent:indexPath.row question:_currentQuestion]];
            
            [self currentRoundScores][0] = eventScore;
            
            if (![_outcomeHandler canGoToNextRound]) {
                
                [self renderGameplayStatusLabelWith:@"Answer arithmetic question now by tapping on one of answer cells"];
                
            }
            
            // Render status and score
            [self renderRoundScore];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self nextRound];
            });
            
            // Listen to tap on cell only if current grid question is not answered already
        } else if (collectionView == _arithmeticAnswersCollectionView && ![_outcomeHandler isCurrentRoundArithmeticQuestionAnswered]) {
            
            [cell.contentView.layer setBorderWidth:2];
            
            // Generate Score
            TLEventScore *eventScore = [_outcomeHandler getRoundScore:[TLEventInput forArithmeticInputEvent:indexPath.row question:_currentQuestion]];
            
            [self currentRoundScores][1] = eventScore;
            
            if (![_outcomeHandler canGoToNextRound]) {
                
                [self renderGameplayStatusLabelWith:@"Answer grid question now by tapping on the right grid cell"];
                
            }
            
            [self renderRoundScore];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self nextRound];
            });
        }
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout

// 1
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    Point gridSizeFromOptions = [TLGameOptions gridQuestionSize];
    NSInteger itemsPerRow = gridSizeFromOptions.h;
    CGFloat pagewidth = CGRectGetWidth(collectionView.bounds);
    
    if (collectionView == _gridQuestionCollectionView) {
        
        CGFloat availbleWidth = pagewidth - ((itemsPerRow - 1) * 2);
        return CGSizeMake(floor(availbleWidth/itemsPerRow), floor(availbleWidth/itemsPerRow));
        
    } else {
        
        return CGSizeMake(50, 50);
        
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 2.0;
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 2.0;
    
}

- (void)onClickSkipRoundButton:(UIButton *)sender {
    
    if (![_outcomeHandler isPaused] && ![self isGameOver]) {
        
        [_skipRoundButton setEnabled:NO];
        
        TLEventScore *eventScore = [_outcomeHandler getRoundScore:[TLEventInput forSkipInputEvent:0 question:_currentQuestion]];
        NSString *roundSkipString = [NSString stringWithFormat:@"Round skipped. Score down by %ld", labs([eventScore score])];
        
        // Update Score label
        [self renderGameplayStatusLabelWith:roundSkipString];
        [self updateTimeRemaining:[eventScore timeRemainingOffset]];
        [self renderScoreLabel];
        
        [self nextRound];
        
    } else {
        
        [_skipRoundButton setEnabled:NO];
        
    }

}

- (void)renderGameplayStatusLabelWith:(NSString *)text {
    
    [_gameplayStatusLabel setText:text];
    [_gameplayStatusLabel setNumberOfLines:0];
    [_gameplayStatusLabel setNeedsDisplay];
    
}

- (void) handleGameLevel {
    
    if ([_outcomeHandler isEligibleForNextLevel]) {
        
        [_outcomeHandler pauseGame];
        
        // TODO: This shouldn't decrease the time remaining
        [self updateTimeRemainingLabel];
//        NSLog([NSString stringWithFormat:@"Game is paused. Time remaining: %ld", _timeRemaining]);
        
        // Show popup for user's choice
        [self goToNextLevel];
        [self performSelector:@selector(handleRound) withObject:nil afterDelay:3];
        
    }
    
}

- (void) goToNextLevel {
    
    [_outcomeHandler goToNextLevel];
    
    [_gameplayStatusLabel setText:[NSString stringWithFormat:@"You're going to play %ld-back on %@ grid now!",
                                   (long)[TLGameOptions nBackCategory],
                                   [NSString stringWithFormat:@"%dX%d", [TLGameOptions gridQuestionSize].h, [TLGameOptions gridQuestionSize].h ]]];
    rounds = 0;
    
}

- (void) continuePlayingCurrentLevel {

    rounds = 0;
    
    [self renderGameplayStatusLabelWith:[NSString stringWithFormat:@"Note that you'll need to start memorizing the coming %ld rounds and start answering after that", [TLGameOptions nBackCategory]]];
    
    [_outcomeHandler continueCurrentLevel];
    
}

- (void) showNextLevelChoiceAlertActionDialog {
    
    UIAlertController * view=   [UIAlertController
                                 alertControllerWithTitle:@"Eligible for next level"
                                 message:@"You're now eligible for playing next level!"
                                 preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"Take me to next level"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [self goToNextLevel];
                             [self performSelector:@selector(handleRound) withObject:nil afterDelay:3];

                             [view dismissViewControllerAnimated:YES completion:^{
                             }];
                             
                         }];
    
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:@"Let me play current level"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 
                                 [self continuePlayingCurrentLevel];
                                 [self performSelector:@selector(handleRound) withObject:nil afterDelay:3];

                                 [view dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
    
    
    [view addAction:ok];
    [view addAction:cancel];
    [self presentViewController:view animated:YES completion:nil];
}

- (NSMutableArray *) currentRoundScores {
    
    if (_currentRoundScores == nil) {
        
        _currentRoundScores = [[NSMutableArray alloc] initWithCapacity:2];
        
    }
    
    return _currentRoundScores;
}

- (NSMutableArray *) currentRoundTimeRemainingOffsets {
    
    if (_currentRoundTimeRemainingOffsets == nil) {
        
        _currentRoundTimeRemainingOffsets = [[NSMutableArray alloc] initWithCapacity:2];
        
    }
    
    return _currentRoundTimeRemainingOffsets;
    
}

// TODO: Choose a sensible name (to accomodate score and time remaining)
- (void) renderRoundScore {
    
    if ([_outcomeHandler canGoToNextRound]) {
        
        NSString *roundScoreString = [NSString stringWithFormat:@"Score: %ld for Arithmetic, %ld for Grid", [_currentRoundScores[0] score], [_currentRoundScores[1] score]];
        
        [self updateTimeRemaining:([_currentRoundScores[0] timeRemainingOffset] + [_currentRoundScores[1] timeRemainingOffset])];
        
        [self renderGameplayStatusLabelWith:roundScoreString];
        [self renderScoreLabel];
    }
    
}

- (void) updateTimeRemainingLabel {
    
    if ([[_modeOptions gameplayMode] isEqualToString:@"SURVIVAL"]) {
        
        if ([_outcomeHandler isPaused]) {
            
            [_timeRemainingLabel setTextColor:[UIColor orangeColor]];
            
        } else {
            
            [_timeRemainingLabel setTextColor:[UIColor blackColor]];
            
        }
        
        NSString *timeRemainingString = [NSString stringWithFormat:@"%02d:%02ld", (int)floorf(_timeRemaining/60), _timeRemaining%60];
        [_timeRemainingLabel setText:timeRemainingString];
        [_timeRemainingLabel setNeedsDisplay];
        
//        NSLog([NSString stringWithFormat:@"Label Time remaining is updated to %@", timeRemainingString ]);
        
        _timeRemaining -= 1;
        
        if (_timeRemaining <= 0 ) {
            
            // TODO: Update UI for Game over here
            [self renderGameplayStatusLabelWith:@"Time limit exceeded. Game is over!"];
            [_timeRemainingLabel setText:@"00:00"];
            [_outcomeHandler stopGame];
        }
        
    }
    
}

- (void) updateTimeRemaining:(NSInteger)timeRemainingOffset {
    
    if ([[_modeOptions gameplayMode] isEqualToString:@"SURVIVAL"]) {
        
        if (_timeRemaining + timeRemainingOffset <= SurvivalModeMaxTimeRemaining) {
            
            _timeRemaining += timeRemainingOffset;
//            NSLog([NSString stringWithFormat:@"Time remaining updated to: %ld", _timeRemaining] );
            
        } else {
            
            _timeRemaining = SurvivalModeMaxTimeRemaining;
            
        }
        
    }
    
}

- (BOOL) isGameOver {
    
    return [[_modeOptions gameplayMode] isEqualToString:@"SURVIVAL"] && (_timeRemaining <= 0);
    
}

@end
