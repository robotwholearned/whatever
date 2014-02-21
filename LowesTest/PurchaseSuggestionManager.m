//
//  PurchaseSuggestionManager.m
//  LowesTest
//
//  Created by Cassandra Sandquist on 21/02/2014.
//  Copyright (c) 2014 self.edu.robotwholearned. All rights reserved.
//

#import "PurchaseSuggestionManager.h"

@implementation PurchaseSuggestionManager

/*Problem Definition
 
 Imagine that you are a developer with the Lowe's iOS team.
 The team has been tasked with launching a new product suggestion service.
 
 The suggestion logic is based on the following rules:
 •	A customer should only be suggested to purchase a product that they have not bought themselves.
 •	A customer should only be suggested to purchase a product that their friends have purchased
 •	The suggestion order should be driven by how many friends have purchased the same item
 •If multiple friends purchased the same item, it should be higher in the suggestions than a product that only one friend owns.
 
 You are provided two library functions to help you
 •	getFriendsListForUser – returns a list of customer IDs (String) that identify the friends of a user
 •	getPurchasesForUser – returns a list of product IDs (String)  ordered by purchase date newest to oldest for a particular user
 
 For this evaluation, please:
 1)	Write a function that provides a ranked (high to low) list of product suggestions for a provided user.
 2)	Write code for a few key unit tests for your code, you may make assumptions about availability of mock data
 3)	Provide the space and time complexity of your solution.

 */

//getFriendsListForUser
//getPurchasesForUser


+(NSArray *) rankedProductSuggestions:(NSString *)userId
{
    NSArray *rankedItmes= @[];
    NSMutableDictionary *itemsAndRanks= [NSMutableDictionary new];
    NSArray *friendsOfUser = [self getFriendsListForUser:userId];
    NSMutableDictionary *friendsAndTheirPurchases = [NSMutableDictionary new];
    NSMutableArray *listOfProducts;
    NSMutableDictionary *dict = [NSMutableDictionary new];
    
    for (int i = 0; [friendsOfUser count] > i; i++)
    {
        NSString *userKey = friendsOfUser[i];
        listOfProducts = [self getPurchasesForUser:userId];
        NSMutableArray *friendsPurchases = [self getPurchasesForUser:userKey];
        
        //remove perviously purchased items
        for(NSString *strings in listOfProducts)
        {
            [friendsPurchases removeObject:strings];
        }
        
        [friendsAndTheirPurchases setObject:friendsPurchases forKey:userKey];
        [dict setObject:friendsPurchases forKey:userKey];
    }
    
    for (id key in friendsAndTheirPurchases) {
        id anObject = [friendsAndTheirPurchases objectForKey:key];
        for (id second in anObject)
        {
            if  (itemsAndRanks[second] == nil)
            {[itemsAndRanks setObject:@1 forKey:second];}
            else
            {
                [itemsAndRanks setObject:@([itemsAndRanks[second] intValue] + 1) forKey:second];
            }
        }
        
    }
    
    rankedItmes = [itemsAndRanks keysSortedByValueUsingComparator:^NSComparisonResult(id obj1, id obj2){
        int thing1 = [obj1 intValue];
        int thing2 = [obj2 intValue];
        
        if (thing1 > thing2)
            return NSOrderedAscending;
        else if (thing1 < thing2)
            return NSOrderedDescending;
        else
            return NSOrderedSame;
    }];
    
    return rankedItmes;
}

+(NSMutableArray *)getFriendsListForUser:(NSString *)userId
{
    return [[NSMutableArray alloc] initWithArray:@[@"A", @"B", @"C", @"D"]];
}
+(NSMutableArray *)getPurchasesForUser:(NSString *)userId
{
    if ([userId  isEqualToString: @"A"])
    {
        return [[NSMutableArray alloc] initWithArray:@[@"car", @"truck", @"sink", @"wevs"]];
    }
    if ([userId  isEqualToString: @"B"])
    {
        return [[NSMutableArray alloc] initWithArray:@[@"sink", @"wevs", @"sink", @"wevs"]];
    }
    if ([userId  isEqualToString: @"C"])
    {
        return [[NSMutableArray alloc] initWithArray:@[@"sink", @"pig", @"nooo", @"cow"]];
    }
    if ([userId  isEqualToString: @"D"])
    {
        return [[NSMutableArray alloc] initWithArray:@[@"sink", @"beer", @"sink", @"more beer"]];
    }
    if ([userId  isEqualToString: @"1"])
    {
        return [[NSMutableArray alloc] initWithArray:@[@"car"]];
    }
    return nil;
    
}
@end
