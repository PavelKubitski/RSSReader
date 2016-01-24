//
//  RKCDArticleList.m
//  RSSReader
//
//  Created by Pavel Kubitski on 22.01.16.
//  Copyright (c) 2016 Pavel Kubitski. All rights reserved.
//

#import "RKCDArticleList.h"
#import "RKCDArticle.h"


@implementation RKCDArticleList

@dynamic article_description;
@dynamic link;
@dynamic title;
@dynamic pubDate;
@dynamic articles;

+ (RKEntityMapping *) responseMapping {
    
    
    
    RKEntityMapping *articleListMapping = [RKEntityMapping mappingForEntityForName:NSStringFromClass([RKCDArticleList class]) inManagedObjectStore:[RKObjectManager sharedManager].managedObjectStore];
    
    
    
    
    [articleListMapping addAttributeMappingsFromDictionary:@{ @"title.text" : @"title",
                                                              @"link.text" : @"link",
                                                            @"description.text" : @"article_description",
                                                              @"pubDate.text" : @"pubDate"}];//article_description - my
    
    
    [articleListMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"item" toKeyPath:@"articles" withMapping:[RKCDArticle responseMapping]]];
    
    
    return articleListMapping;
}




@end
