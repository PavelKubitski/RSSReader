//
//  ViewController.m
//  RSSReader
//
//  Created by Pavel Kubitski on 14.01.16.
//  Copyright (c) 2016 Pavel Kubitski. All rights reserved.
//

#import "TableViewController.h"
#import "ArticleViewController.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    CGRect frame = self.tableView.frame;
//    CGRect frameOfView = self.view.frame;
//    self.tableView.frame = frameOfView;
//    CGRect frame2 = self.tableView.frame;
//    self.tableView.frame = CGRectMake(frameOfView.origin.x, frameOfView.origin.y, frameOfView.size.width, frameOfView.size.height);
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
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    //    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    NSString *imageUrl = [((RKArticle*)[self.articleList.articles objectAtIndex:indexPath.row]) imageURL];

    cell.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]]];

    
    cell.textLabel.text = [((RKArticle*)[self.articleList.articles objectAtIndex:indexPath.row]) title];

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
