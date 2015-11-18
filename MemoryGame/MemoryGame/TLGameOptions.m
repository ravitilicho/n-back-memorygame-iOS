//
//  GameOptions.m
//  MemoryGame
//
//  Created by Ravindar Katkuri on 10/11/15.
//  Copyright © 2015 Tilicho Labs. All rights reserved.
//

#import "TLGameOptions.h"

@interface TLGameOptions ()

- (BOOL) savedOptionsExist;
+ (NSDictionary *) modes;

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
        
        [TLGameOptions setNBackCategory:1];
        [TLGameOptions setGridQuestionSize:defaultGridSize];
        [TLGameOptions setGameplayMode:@"ENDLESS"];
        
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:optionsInitializationStatus];
        
    }
    
    return self;
}

+ (NumberRange) supportedNBackCategoryRange {
    
    NumberRange range = {MIN_NBACK_CATEGORY, MAX_NBACK_CATEGORY};
    return range;
    
}

+ (NumberRange) supportedGridQuestionSizeRange {
    
    NumberRange range = {MIN_GRID_LENGTH, MAX_GRID_LENGTH};
    return range;
    
}

+ (NSInteger) nBackCategory {
    
    NSInteger category = [[[self options] objectForKey:nBackCategory] integerValue];
    return category;
    
}

+ (NSInteger) minNBackCategory {
    
    return MIN_NBACK_CATEGORY;
    
}

+ (NSInteger) maxNBackCategory  {
    
    return MAX_NBACK_CATEGORY;
    
}

+ (BOOL) isMaxNBackCategory:(NSInteger)category {
    
    return category >= MAX_NBACK_CATEGORY;
    
}

+ (BOOL) isMaxGridQuestionSize:(Point)size {
    
    if (size.h == size.v) {
        
        return size.h >= MAX_GRID_LENGTH;
        
    }
    
    return NO;
    
}

+ (Point) minGridQuestionSize {
    
    Point point = {MIN_GRID_LENGTH, MIN_GRID_LENGTH};
    
    return point;
    
}

+ (NSUserDefaults *) options {
    
    return [NSUserDefaults standardUserDefaults];
    
}

+ (void) persist {
    
    [[self options] synchronize];
    
}

+ (void) setNBackCategory:(NSInteger)category {
    
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

+ (Point) gridQuestionSize {
    
    NSInteger gridLength = [[[self options] objectForKey:gridQuestionSize] integerValue];
    
    Point gridSize = {gridLength, gridLength};
    
    return gridSize;
    
}

+ (void) setGridQuestionSize:(Point)size {
    
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

+ (NSSet *)gameplayModes {
    
    return [NSSet setWithObjects:@"ENDLESS", @"SURVIVAL", nil];
    
}

+ (NSString *) gameplayMode {
    
    NSString *mode = [[self options] objectForKey:gameplayMode];
    
    return mode;

}

+ (void) setGameplayMode:(NSString *)mode {
    
    if ([[self gameplayModes] containsObject:mode]) {
        
        [[self options] setObject:mode forKey:gameplayMode];
        [self persist];
        
    }
}

+ (BOOL) savedOptionsExist {
    
    NSString *optionsSaved = [[NSUserDefaults standardUserDefaults] objectForKey:optionsInitializationStatus];
    return [optionsSaved isEqualToString:@"YES"];
    
}

+ (void) persist:(ModeOptions *)modeOptions {
    
    NSMutableDictionary *modes = [[self modes] mutableCopy];
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                              [modeOptions gameplayMode], @"gameplayMode",
                          [self number:[modeOptions nBackCategoryRange].left], @"nBackCategoryRangeLeft",
                          [self number:[modeOptions nBackCategoryRange].right], @"nBackCategoryRangeRight",
                          [self number:[modeOptions gridQuestionLengthRange].left], @"gridQuestionLengthRangeLeft",
                           [self number:[modeOptions gridQuestionLengthRange].right], @"gridQuestionLengthRangeRight",
                              nil];

    [modes setValue:dict forKey:[modeOptions gameplayMode]];
    [self persistModes:modes];
    
    [[self options] setObject:[modeOptions gameplayMode] forKey:gameplayMode];
    [[self options] setObject:[self number:[modeOptions nBackCategoryRange].left]
                                              forKey:nBackCategory];
    [[self options] setObject:[self number:[modeOptions gridQuestionLengthRange].left]
                                              forKey:gridQuestionSize];
    [[self options] synchronize];
    
}

+ (ModeOptions *) modeOptions:(NSString *)gameplayMode {
    
    NSDictionary *modes = [self modes];
    
    if (modes == nil) {
        
        return nil;
        
    } else {
        
        NSDictionary *mode = [modes objectForKey:gameplayMode];
        
        if (mode == nil) {
            
            // TODO: Return defaults
            
            return nil;
            
        } else {
            
            NumberRange nBackRange = {[(NSNumber *)modes[@"nBackCategoryRangeLeft"] integerValue], [(NSNumber *)modes[@"nBackCategoryRangeRight"] integerValue]};
            NumberRange gridRange = {[(NSNumber *)modes[@"gridQuestionLengthRangeLeft"] integerValue], [(NSNumber *)modes[@"gridQuestionLengthRangeRight"] integerValue]};
            
            ModeOptions *modeOptions = [[ModeOptions alloc] initWithGameplayMode:mode[@"gameplayMode"]
                                                                       gridRange:gridRange
                                                                      nBackRange:nBackRange];
            
            return modeOptions;
            
        }
        
    }
    
}

+ (NSDictionary *) modes {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *modes = (NSDictionary *)[defaults objectForKey:@"modes"];
    
    if (modes == nil) {
        
        modes = [NSDictionary new];
        
        [defaults setObject:modes forKey:@"modes"];
        [defaults synchronize];
        
    }
    
    return modes;
    
}

+ (NSNumber *)number:(NSInteger)integer {
    
    return [NSNumber numberWithLong:integer];
    
}

+ (void) persistModes:(NSDictionary *)modes {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:modes forKey:@"modes"];
    [defaults synchronize];
    
}

@end
