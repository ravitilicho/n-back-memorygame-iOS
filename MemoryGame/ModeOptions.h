//
//  ModeOptions.h
//  MemoryGame
//
//  Created by Ravindar Katkuri on 16/11/15.
//  Copyright © 2015 Tilicho Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Enums.h"

@interface ModeOptions : NSObject

- (instancetype) initWithGameplayMode:(NSString *)gameplayMode gridRange:(NumberRange)gridRange nBackRange:(NumberRange)nBackRange;

@property (nonatomic) NSString *gameplayMode;
@property (nonatomic) NumberRange gridQuestionLengthRange;
@property (nonatomic) NumberRange nBackCategoryRange;

@end
