//
//  QuotesManager.h
//  FinanceQuotes
//
//  Created by Alexander Stepanov on 26/03/16.
//  Copyright © 2016 Alexander Stepanov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Quote.h"

@interface QuotesManager : NSObject

@property (nonatomic, readonly) NSArray* quotes;
@property (nonatomic, copy) NSString* searchText;
@property (nonatomic, copy) void(^onUpdate)();

-(void)queryData;

@end
