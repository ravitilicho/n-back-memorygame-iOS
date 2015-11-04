//
//  ViewController.m
//  MemoryGame
//
//  Created by Ravindar Katkuri on 16/10/15.
//  Copyright © 2015 Tilicho Labs. All rights reserved.
//

#import "ViewController.h"
#import "TLArithmeticQuestionGenerator.h"
#import "TLGridQuestionGenerator.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    for (int i = 0; i < 20; i++) {
        TLArithmeticQuestion *question = [TLArithmeticQuestionGenerator generate];
        NSLog(@"Arithmetic Question: %@ Answer: %@", question.questionString, question.answerString);
    }
    
    for (int i = 0; i < 20; i++) {
        NSInteger gridToHighlight = [TLGridQuestionGenerator generate:16];
        NSLog(@"Color Question: %ld \n", (long)gridToHighlight);
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
