//
//  RKCDArticleList.m
//  RSSReader
//
//  Created by Pavel Kubitski on 20.01.16.
//  Copyright (c) 2016 Pavel Kubitski. All rights reserved.
//

#import "RKCDArticleList.h"


@implementation RKCDArticleList

@dynamic title;
@dynamic article_description;
@dynamic link;
@dynamic articles;

+ (RKObjectMapping *) responseMapping {
    
    
    
    RKObjectMapping *articleListMapping = [RKObjectMapping mappingForClass:[RKCDArticleList class]];
    
    
    
    
    [articleListMapping addAttributeMappingsFromDictionary:@{ @"title.text" : @"title",
                                                              @"link.text" : @"link",
                                                              @"description.text" : @"article_description" }];//article_description - my
    
    
    [articleListMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"item" toKeyPath:@"articles" withMapping:[RKCDArticle responseMapping]]];
    
    
    return articleListMapping;
}



@end
