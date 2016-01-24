//
//  ArticleViewController.h
//  RSSReader
//
//  Created by Pavel Kubitski on 16.01.16.
//  Copyright (c) 2016 Pavel Kubitski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RKCDArticle.h"
#import "RKNews.h"

@interface ArticleViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorActivity;


@property (strong, nonatomic) RKCDArticle *article;
@property (strong, nonatomic) NSString *textOfArticle;
@end
