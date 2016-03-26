//
//  ViewController.m
//  FinanceQuotes
//
//  Created by Alexander Stepanov on 26/03/16.
//  Copyright © 2016 Alexander Stepanov. All rights reserved.
//

#import "ViewController.h"
#import "QuoteCell.h"
#import "QuotesManager.h"

@interface ViewController ()<UISearchResultsUpdating>
@property (nonatomic) QuotesManager* quotesManager;
@property (nonatomic) UISearchController* searchController;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.tableView.tableHeaderView = self.searchController.searchBar;
    self.definesPresentationContext = YES;
    
    self.quotesManager = [[QuotesManager alloc]init];
    __weak __typeof(self) weakSelf = self;
    self.quotesManager.onUpdate = ^{
        [weakSelf.tableView reloadData];
    };
    [self.quotesManager queryData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.quotesManager.quotes.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Quote* q = self.quotesManager.quotes[indexPath.row];
    
    QuoteCell* cell = [tableView dequeueReusableCellWithIdentifier:@"QuoteCell"];
    cell.quote = q;
    
    return cell;
}

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString* text = searchController.searchBar.text;
    self.quotesManager.searchText = text;
}

@end
