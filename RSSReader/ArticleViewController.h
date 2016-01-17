//
//  ArticleViewController.h
//  RSSReader
//
//  Created by Pavel Kubitski on 16.01.16.
//  Copyright (c) 2016 Pavel Kubitski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RKArticle.h"
#import "RKNews.h"

@interface ArticleViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextView *textField;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@property (strong, nonatomic) RKArticle *article;
@property (strong, nonatomic) NSString *textOfArticle;
@end
