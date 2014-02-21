//
//  PurchaseSuggestionManager.h
//  LowesTest
//
//  Created by Cassandra Sandquist on 21/02/2014.
//  Copyright (c) 2014 self.edu.robotwholearned. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PurchaseSuggestionManager : NSObject

+(NSArray *) rankedProductSuggestions:(NSString *)userId;

@end
