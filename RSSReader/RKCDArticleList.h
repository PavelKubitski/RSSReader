//
//  RKCDArticleList.h
//  RSSReader
//
//  Created by Pavel Kubitski on 20.01.16.
//  Copyright (c) 2016 Pavel Kubitski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <RestKit/RestKit.h>
#import "RKCDArticle.h"

@interface RKCDArticleList : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * article_description;
@property (nonatomic, retain) NSString * link;
@property (nonatomic, retain) NSSet *articles;

+ (RKObjectMapping *) responseMapping;


@end

@interface RKCDArticleList (CoreDataGeneratedAccessors)

- (void)addArticlesObject:(NSManagedObject *)value;
- (void)removeArticlesObject:(NSManagedObject *)value;
- (void)addArticles:(NSSet *)values;
- (void)removeArticles:(NSSet *)values;

@end
