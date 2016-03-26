//
//  Quote.m
//  FinanceQuotes
//
//  Created by Alexander Stepanov on 26/03/16.
//  Copyright © 2016 Alexander Stepanov. All rights reserved.
//

#import "Quote.h"

@implementation Quote

+(JSONKeyMapper *)keyMapper {
    NSDictionary* map = @{
                          @"Name": @"name",
                          @"Change": @"change",
                          @"LastTradePriceOnly": @"price",
                          @"DaysRange": @"daysRange",
                          @"PreviousClose": @"prevClose",
                          @"PercentChange": @"changePercent",
                          };
    return [[JSONKeyMapper alloc]initWithDictionary:map];
}

-(NSString *)changeWithPercent {
    return [NSString stringWithFormat:@"%@ (%@)", self.change, self.changePercent];
}

-(BOOL)isPositiveChange {
    return [self.change hasPrefix:@"+"];
}

-(BOOL)containsString:(NSString*)text {
    if ([self.symbol rangeOfString:text options:NSCaseInsensitiveSearch].location != NSNotFound) return YES;
    if ([self.name rangeOfString:text options:NSCaseInsensitiveSearch].location != NSNotFound) return YES;
    return NO;
}

@end
