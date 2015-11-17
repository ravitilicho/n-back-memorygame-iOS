//
//  CallbackProtocol.h
//  MemoryGame
//
//  Created by Ravindar Katkuri on 16/11/15.
//  Copyright © 2015 Tilicho Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CallbackProtocol <NSObject>

- (void) registerCallbackOnTarget:(nullable id)target action:(SEL)action;

@end
