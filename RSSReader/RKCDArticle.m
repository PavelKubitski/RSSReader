//
//  RKCDArticle.m
//  RSSReader
//
//  Created by Pavel Kubitski on 20.01.16.
//  Copyright (c) 2016 Pavel Kubitski. All rights reserved.
//

#import "RKCDArticle.h"
#import "RKCDArticleList.h"


@implementation RKCDArticle

@dynamic title;
@dynamic link;
@dynamic pubDate;
@dynamic category;
@dynamic description_article;
@dynamic imageURL;
@dynamic owner;

+ (RKObjectMapping *) responseMapping {
    
    
    
    RKObjectMapping *articleMapping = [RKObjectMapping mappingForClass:[RKCDArticle class]];
    
    
    
    
    [articleMapping addAttributeMappingsFromDictionary:@{@"title.text" : @"title",
                                                         @"link.text" : @"link",
                                                         @"pubDate.text" : @"pubDate",
                                                         @"category.text" : @"category",
                                                         @"description.text" : @"description_article",
                                                         @"media:thumbnail.url" : @"imageURL"
                                                         }];
    
    
    
    return articleMapping;
}




@end
