//
//  RKArticleList.m
//  RSSReader
//
//  Created by Pavel Kubitski on 14.01.16.
//  Copyright (c) 2016 Pavel Kubitski. All rights reserved.
//

#import "RKArticleList.h"
#import "RKObjectMapping.h"
//#import "RKEntityMapping.h"
#import "RKArticle.h"


@implementation RKArticleList

+ (RKObjectMapping *) responseMapping {
    
    
    
    RKObjectMapping *articleListMapping = [RKObjectMapping mappingForClass:[RKArticleList class]];
    
    
    
    
    [articleListMapping addAttributeMappingsFromDictionary:@{ @"title.text" : @"title",
                                                              @"link.text" : @"link",
                                                              @"description.text" : @"article_description" }];//article_description - my
    
    
    [articleListMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"item" toKeyPath:@"articles" withMapping:[RKArticle responseMapping]]];
    
    
    return articleListMapping;
}




@end
