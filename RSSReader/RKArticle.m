//
//  RKArticle.m
//  RSSReader
//
//  Created by Pavel Kubitski on 14.01.16.
//  Copyright (c) 2016 Pavel Kubitski. All rights reserved.
//

#import "RKArticle.h"
#import "RKObjectMapping.h"

@implementation RKArticle

+ (RKObjectMapping *) responseMapping {
    
    
    
    RKObjectMapping *articleMapping = [RKObjectMapping mappingForClass:[RKArticle class]];
    
    
    
    
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
