//
//  ViewController.m
//  RSSReader
//
//  Created by Pavel Kubitski on 14.01.16.
//  Copyright (c) 2016 Pavel Kubitski. All rights reserved.
//

#import "TableViewController.h"
#import "ArticleViewController.h"
#import "CustomTableViewCell.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareForNetwork];
    [self requestData];
    


    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    CGRect frameOfView = self.view.frame;
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.articleList.articles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CustomTableViewCell";
    
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    //    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    NSString *imageUrl = [((RKArticle*)[self.articleList.articles objectAtIndex:indexPath.row]) imageURL];
    

    
    cell.image.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]]];

    
    cell.titleLabel.text = [((RKArticle*)[self.articleList.articles objectAtIndex:indexPath.row]) title];

    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
    RKArticle *article = [self.articleList.articles objectAtIndex:indexPath.row];
    ArticleViewController *articleVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ArticleViewController"];
    [self.navigationController pushViewController:articleVC animated:YES];
    articleVC.article = article;
}


#pragma mark - RESTKit

- (void) prepareForNetwork {
    NSURL *baseURL = [NSURL URLWithString:@"http://tech.onliner.by"];
    RKObjectManager *objectManager = [RKObjectManager managerWithBaseURL:baseURL];

    [objectManager setRequestSerializationMIMEType:RKMIMETypeTextXML];
    
    RKResponseDescriptor *articleListResponseDescriptor =
    [RKResponseDescriptor responseDescriptorWithMapping:[RKArticleList responseMapping]
                                                 method:RKRequestMethodGET
                                            pathPattern:@"/feed"
                                                keyPath:@"rss.channel"
                                            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)
     ];
    
    [objectManager addResponseDescriptor:articleListResponseDescriptor];
    
    // Enable Activity Indicator Spinner
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
}




- (void)requestData {
    NSString *requestPath = @"/feed";
    [[RKObjectManager sharedManager]
     getObjectsAtPath:requestPath
     parameters:nil
     success: ^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
         
         self.articleList = (RKArticleList*)[mappingResult.array firstObject];
         
         [self.tableView reloadData];
         
     }
     failure: ^(RKObjectRequestOperation *operation, NSError *error) {
         RKLogError(@"Load failed with error: %@", error);
     }
     ];
}




@end
