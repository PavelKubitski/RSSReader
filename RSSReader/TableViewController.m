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
    
    self.activityIndicator.center = self.view.center;
    
    
    UIBarButtonItem* refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                                   target:self
                                                                                   action:@selector(refreshButtonAction:)];

    [self.navigationItem setRightBarButtonItem:refreshButton];

    [self prepareForNetwork];

    [self.activityIndicator startAnimating];
    [self fetchArticlesFromContext:self.baseURL];
    if ([self.articles count] == 0) {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(queue, ^{
            [self requestData];
        });
    } else {
        self.navigationItem.title = self.articleList.title;
        [self.activityIndicator stopAnimating];
        [self.tableView reloadData];
    }

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (void) refreshButtonAction:(UIBarButtonItem*) sender {
    [self deleteObjectsFromPath:self.baseURL];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        [self requestData];
    });
}

#pragma mark - RESTKit

- (void) prepareForNetwork {

    NSURL *baseURL = [NSURL URLWithString:self.baseURL];
    self.manager = [RKObjectManager managerWithBaseURL:baseURL];
    

    
    if (self.manager.managedObjectStore == nil) {
        self.manager.managedObjectStore = self.moStore;
    }
    
    [self.manager setRequestSerializationMIMEType:RKMIMETypeTextXML];
    
    RKResponseDescriptor *articleListResponseDescriptor =
    [RKResponseDescriptor responseDescriptorWithMapping:[RKCDArticleList responseMapping]
                                                 method:RKRequestMethodGET
                                            pathPattern:@"/feed"
                                                keyPath:@"rss.channel"
                                            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)
     ];
    
    [self.manager addResponseDescriptor:articleListResponseDescriptor];
    [RKObjectManager setSharedManager:self.manager];
    
    // Enable Activity Indicator Spinner
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    

    
}

- (void)requestData {
    NSString *requestPath = @"/feed";
    
    [[RKObjectManager sharedManager]
     getObjectsAtPath:requestPath
     parameters:nil
     success: ^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
         

         [self fetchArticlesFromContext:self.baseURL];
         dispatch_async(dispatch_get_main_queue(), ^{
             self.navigationItem.title = self.articleList.title;
             [self.tableView reloadData];
         });
     
         
         [self.activityIndicator stopAnimating];
     }
     failure: ^(RKObjectRequestOperation *operation, NSError *error) {
         RKLogError(@"Load failed with error: %@", error);
     }
     ];
}


- (void)fetchArticlesFromContext:(NSString*)path {
    
    NSString *normolizedPath = [NSString stringWithFormat:@"%@%@", path, @"/"];
    
    NSManagedObjectContext *context = self.manager.managedObjectStore.persistentStoreManagedObjectContext;
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"RKCDArticleList"];
    
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"pubDate" ascending:YES];
    fetchRequest.sortDescriptors = @[descriptor];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"link == %@", normolizedPath];
    fetchRequest.predicate = predicate;
    
    NSError *error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    self.articleList = [fetchedObjects firstObject];
    self.articles = [NSArray arrayWithArray:[self.articleList.articles allObjects]];
    if (self.articleList) {
        NSLog(@"OKKKK!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n");
        NSLog(@"objects fetched %lu", (unsigned long)[self.articleList.articles count]);
    }
}

- (void) deleteObjectsFromPath:(NSString *) path {
    [self fetchArticlesFromContext:path];
    [self.manager.managedObjectStore.persistentStoreManagedObjectContext deleteObject:self.articleList];
    NSError *error;
    [self.manager.managedObjectStore.persistentStoreManagedObjectContext save:&error];
}








#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.articles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CustomTableViewCell";

    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    NSString *imageUrl = [((RKCDArticle*)[self.articles objectAtIndex:indexPath.row]) imageURL];
    
    cell.image.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]]];
    
    cell.titleLabel.text = [((RKCDArticle*)[self.articles objectAtIndex:indexPath.row]) title];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    RKCDArticle *article = [self.articles objectAtIndex:indexPath.row];
    ArticleViewController *articleVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ArticleViewController"];
    [self.navigationController pushViewController:articleVC animated:YES];
        articleVC.article = article;
}
@end
