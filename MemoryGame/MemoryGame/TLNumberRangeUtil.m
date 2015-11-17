//
//  TLNumberRangeUtil.m
//  MemoryGame
//
//  Created by Ravindar Katkuri on 17/11/15.
//  Copyright © 2015 Tilicho Labs. All rights reserved.
//

#import "TLNumberRangeUtil.h"

@interface TLNumberRangeUtil ()

@property (nonatomic) NumberRange range;

@end

@implementation TLNumberRangeUtil

+ (BOOL) isMaxInRange:(NSInteger)item range:(NumberRange)numberRange {
    
    return item >= numberRange.right;
    
}
+ (BOOL) isMinInRange:(NSInteger)item range:(NumberRange)numberRange {

    return item <= numberRange.left;
    
}

+ (NSInteger) nextItem:(NSInteger)item range:(NumberRange)numberRange {

    if ([self isMaxInRange:item range:numberRange]) {
        
        return [self maxItem:numberRange];
        
    } else {
        
        return item + 1;
        
    }
    
}

+ (NSInteger) minItem:(NumberRange)numberRange {
    
    return numberRange.left;
    
}

+ (NSInteger) maxItem:(NumberRange)numberRange {

    return numberRange.right;
    
}


@end
