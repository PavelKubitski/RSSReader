//
//  ViewController.h
//  RSSReader
//
//  Created by Pavel Kubitski on 14.01.16.
//  Copyright (c) 2016 Pavel Kubitski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>
#import "RKArticleList.h"
#import "RKArticle.h"
//#import "RKCDArticle.h"
//#import "RKCDArticleList.h"

@interface TableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) RKArticleList *articleList;
@property (strong, nonatomic) NSString *baseURL;

@end

