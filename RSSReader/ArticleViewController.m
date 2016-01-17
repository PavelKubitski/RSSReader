//
//  ArticleViewController.m
//  RSSReader
//
//  Created by Pavel Kubitski on 16.01.16.
//  Copyright (c) 2016 Pavel Kubitski. All rights reserved.
//

#import "ArticleViewController.h"
#import "TFHpple.h"
#import "News.h"

@interface ArticleViewController ()

@end

@implementation ArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.text = self.article.title;
    self.imageView.image =[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.article.imageURL]]];
//    [self prepareForNetwork];
//    [self requestData];
    [self requestDataUsingAFNetworking];
    self.titleLabel.backgroundColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:1.0];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - RESTKit

- (void) prepareForNetwork {
    NSString *baseUrlSting = @"http://tech.onliner.by";
    NSURL *baseURL = [NSURL URLWithString:baseUrlSting];
    RKObjectManager *objectManager = [RKObjectManager managerWithBaseURL:baseURL];
    NSString *pathPattern = [self.article.link stringByReplacingOccurrencesOfString:baseUrlSting withString:@""];
    
    [objectManager setRequestSerializationMIMEType:RKMIMETypeTextXML];
    
    RKResponseDescriptor *newsResponseDescriptor =
    [RKResponseDescriptor responseDescriptorWithMapping:[RKNews responseMapping]
                                                 method:RKRequestMethodGET
                                            pathPattern:pathPattern
                                                keyPath:nil
                                            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)
     ];
    
    [objectManager addResponseDescriptor:newsResponseDescriptor];
    
    // Enable Activity Indicator Spinner
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
}

- (void)requestData {
    
    NSString *baseUrlSting = @"http://tech.onliner.by";
//    [[RKParserRegistry sharedRegistry] setParserClass:[RKJSONParserJSONKit class] forMIMEType:@"text/html"];
    NSString *requestPath = [self.article.link stringByReplacingOccurrencesOfString:baseUrlSting withString:@""];
    
    [[RKObjectManager sharedManager]
     getObjectsAtPath:requestPath
     parameters:nil
     success: ^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
         

         RKNews *news = (RKNews*)[mappingResult.array firstObject];

         
     }
     failure: ^(RKObjectRequestOperation *operation, NSError *error) {
         RKLogError(@"Load failed with error: %@", error);
     }
     ];
}

- (void) requestDataUsingAFNetworking {
    NSString *baseUrlSting = @"http://tech.onliner.by";
    
    
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:baseUrlSting]];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET"
                                                            path:self.article.link
                                                      parameters:nil];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [httpClient registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {


        
        TFHpple *parser = [TFHpple hppleWithHTMLData:responseObject];
        NSString *xpath = @"//div[@class='b-posts-1-item__text']/p";
        NSArray *nodes = [parser searchWithXPathQuery:xpath];
        
        NSMutableArray *news = [NSMutableArray new];
        for (TFHppleElement *elem in nodes ) {

            for (TFHppleElement *child in elem.children) {
                if ([child.tagName isEqualToString:@"em"]) {
                    News *article = [News new];
                    article.textOfNews = [[child firstChild] content];
                    [news addObject:article];
                }
                else {
                    News *article = [News new];
                    article.textOfNews = [[elem firstChild] content];
                    [news addObject:article];
                }
            }
        }
        [self appendAllTexts:news];
        self.textField.text = self.textOfArticle;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    [operation start];
}

- (void) appendAllTexts:(NSMutableArray*) news {
    NSMutableString *textOfNew = [NSMutableString new];
    for (News *element in news) {
        if (element.textOfNews) {
            [textOfNew appendString:element.textOfNews];
            [textOfNew appendString:@"\n"];
        }

    }
    self.textOfArticle = [NSString stringWithString:textOfNew];
    
}



@end
