//
//  QuoteCell.m
//  FinanceQuotes
//
//  Created by Alexander Stepanov on 26/03/16.
//  Copyright © 2016 Alexander Stepanov. All rights reserved.
//

#import "QuoteCell.h"

@interface QuoteCell ()
@property (weak, nonatomic) IBOutlet UILabel *symbolLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *prevCloseLabel;
@property (weak, nonatomic) IBOutlet UILabel *daysRangeLabel;
@property (weak, nonatomic) IBOutlet UILabel *changeLabel;
@end

@implementation QuoteCell

-(void)setQuote:(Quote *)quote
{
    _quote = quote;
    
    self.symbolLabel.text = quote.symbol;
    self.nameLabel.text = quote.name;
    self.priceLabel.text = quote.price;
    self.changeLabel.text = quote.changeWithPercent;
    self.prevCloseLabel.text = quote.prevClose;
    self.daysRangeLabel.text = quote.daysRange;
    
    self.changeLabel.textColor = quote.isPositiveChange ? [UIColor greenColor] : [UIColor redColor];
}

@end
