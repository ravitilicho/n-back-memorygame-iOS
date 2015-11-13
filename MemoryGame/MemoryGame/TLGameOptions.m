//
//  GameOptions.m
//  MemoryGame
//
//  Created by Ravindar Katkuri on 10/11/15.
//  Copyright © 2015 Tilicho Labs. All rights reserved.
//

#import "TLGameOptions.h"

@interface TLGameOptions ()

@property (nonatomic) NSSet *gameplayModes;

- (BOOL) savedOptionsExist;

@end

@implementation TLGameOptions

static TLGameOptions *gameOptions;

NSString *nBackCategory = @"nBackCategory";
NSString *gridQuestionSize = @"gridQuestionSize";
NSString *gameplayMode = @"gameplayMode";
NSString *optionsInitializationStatus = @"defaultOptionsInitialized";

NSInteger MIN_GRID_LENGTH = 3;
NSInteger MAX_GRID_LENGTH = 6;
NSInteger MIN_NBACK_CATEGORY = 1;
NSInteger MAX_NBACK_CATEGORY = 6;

- (instancetype) initWithOptions {
    
    self = [TLGameOptions new];
    
    // TODO: Comment out after Options UI screen is in
    if (![self savedOptionsExist]) {
    
        Point defaultGridSize = {3, 3};
        
        [self setNBackCategory:1];
        [self setGridQuestionSize:defaultGridSize];
        [self setGameplayMode:@"ENDLESS"];
        
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:optionsInitializationStatus];
        
    }
    
    return self;
}

- (NSInteger) nBackCategory {
    
    NSInteger category = [[[self options] objectForKey:nBackCategory] integerValue];
    return category;
    
}

- (NSInteger) minNBackCategory {
    
    return MIN_NBACK_CATEGORY;
    
}

- (BOOL) isMaxNBackCategory:(NSInteger)category {
    
    return category >= MAX_NBACK_CATEGORY;
    
}

- (BOOL) isMaxGridQuestionSize:(Point)size {
    
    if (size.h == size.v) {
        
        return size.h >= MAX_GRID_LENGTH;
        
    }
    
    return NO;
    
}

- (Point) minGridQuestionSize {
    
    Point point = {MIN_GRID_LENGTH, MIN_GRID_LENGTH};
    
    return point;
    
}

- (NSUserDefaults *) options {
    
    return [NSUserDefaults standardUserDefaults];
    
}

- (void) persist {
    
    [[self options] synchronize];
    
}

- (void) setNBackCategory:(NSInteger)category {
    
    NSInteger nbackCategory = 0;
    
    if (category > MAX_NBACK_CATEGORY) {
        
        nbackCategory = MAX_NBACK_CATEGORY;
        
    } else if (category < MIN_NBACK_CATEGORY) {
        
        nbackCategory = MIN_NBACK_CATEGORY;
        
    } else {
        
        nbackCategory = category;
        
    }
    
    [[self options] setObject:[NSNumber numberWithLong:nbackCategory] forKey:nBackCategory];
    [self persist];
}

- (Point) gridQuestionSize {
    
    NSInteger gridLength = [[[self options] objectForKey:gridQuestionSize] integerValue];
    
    Point gridSize = {gridLength, gridLength};
    
    return gridSize;
    
}

- (void) setGridQuestionSize:(Point)size {
    
    NSInteger gridLength = 0;
    
    if (size.h == size.v) {
        
        if (size.h > MAX_GRID_LENGTH) {
            
            gridLength = MAX_GRID_LENGTH;
            
        } else if (size.h < MIN_GRID_LENGTH) {
            
            gridLength = MIN_GRID_LENGTH;
            
        } else {
            
            gridLength = size.h;
            
        }
        
        [[self options] setObject:[NSNumber numberWithLong:gridLength] forKey:gridQuestionSize];
        [self persist];
        
    }
    
}

- (NSSet *)gameplayModes {
    
    if (_gameplayModes == nil) {
        
        _gameplayModes = [NSSet setWithObjects:@"ENDLESS", @"SURVIVAL", nil];
        
    }
    
    return _gameplayModes;
}

- (NSString *) gameplayMode {
    
    NSString *mode = [[self options] objectForKey:gameplayMode];
    
    return mode;

}

- (void) setGameplayMode:(NSString *)mode {
    
    if ([[self gameplayModes] containsObject:mode]) {
        
        [[self options] setObject:mode forKey:gameplayMode];
        [self persist];
        
    }
}

- (BOOL) savedOptionsExist {
    
    NSString *optionsSaved = [[NSUserDefaults standardUserDefaults] objectForKey:optionsInitializationStatus];
    return [optionsSaved isEqualToString:@"YES"];
    
}

@end
