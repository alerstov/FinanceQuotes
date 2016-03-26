//
//  QuotesManager.m
//  FinanceQuotes
//
//  Created by Alexander Stepanov on 26/03/16.
//  Copyright © 2016 Alexander Stepanov. All rights reserved.
//

#import "QuotesManager.h"
#import <AFNetworking.h>

#define QUERY_PREFIX @"http://query.yahooapis.com/v1/public/yql?q="
#define QUERY_SUFFIX @"&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback="

@interface QuotesManager ()
@property (nonatomic, copy) NSString* queryUrl;
@property (nonatomic) NSArray* allQuotes;
@property (nonatomic) NSArray* filteredQuotes;
@end

@implementation QuotesManager

- (instancetype)init {
    self = [super init];
    if (self) {
        NSArray* symbols = @[@"GOOG", @"AAPL", @"INTC", @"TWTR", @"FB", @"NFLX", @"AMZN", @"LNKD", @"YHOO"];
        NSMutableArray* arr = [NSMutableArray array];
        for (NSString* symbol in symbols) {
            NSString* s = [NSString stringWithFormat:@"\"%@\"", symbol];
            [arr addObject:s];
        }
        NSString* s1 = [arr componentsJoinedByString:@","];
        NSString* qs = [NSString stringWithFormat:@"select * from yahoo.finance.quotes where symbol in (%@)", s1];
        
        self.queryUrl = [NSString stringWithFormat:@"%@%@%@", QUERY_PREFIX, [qs stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding], QUERY_SUFFIX];
    }
    return self;
}

-(NSArray *)quotes {
    return self.searchText.length > 0 ? self.filteredQuotes : self.allQuotes;
}

-(void)setSearchText:(NSString *)searchText {
    _searchText = searchText;
    [self updateQuotes];
}

-(void)updateQuotes {
    if (self.searchText.length > 0){
        NSMutableArray* arr = [NSMutableArray array];
        for (Quote* q in self.allQuotes) {
            if ([q containsString:self.searchText]) {
                [arr addObject:q];
            }
        }
        self.filteredQuotes = arr;
    }
    
    self.onUpdate();
}

-(void)queryData {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:self.queryUrl parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        //NSLog(@"JSON: %@", responseObject);
        
        NSArray* arr = responseObject[@"query"][@"results"][@"quote"];
        
        NSError* error;
        NSArray* arr2 = [Quote arrayOfModelsFromDictionaries:arr error:&error];
        if (error){
            NSLog(@"Error: %@", error);
        }else{
            self.allQuotes = arr2;
            [self updateQuotes];
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self queryData];
        });
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self queryData];
        });
        
    }];
}

@end
