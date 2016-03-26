//
//  Quote.h
//  FinanceQuotes
//
//  Created by Alexander Stepanov on 26/03/16.
//  Copyright © 2016 Alexander Stepanov. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface Quote : JSONModel
@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSString* symbol;
@property (nonatomic, copy) NSString* price;
@property (nonatomic, copy) NSString* change;
@property (nonatomic, copy) NSString* changePercent;
@property (nonatomic, copy) NSString* prevClose;
@property (nonatomic, copy) NSString* daysRange;

@property (nonatomic, copy, readonly) NSString* changeWithPercent;
@property (nonatomic, readonly) BOOL isPositiveChange;

-(BOOL)containsString:(NSString*)text;

@end
