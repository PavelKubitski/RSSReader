//
//  RKCDArticleList.h
//  RSSReader
//
//  Created by Pavel Kubitski on 22.01.16.
//  Copyright (c) 2016 Pavel Kubitski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <RestKit/RestKit.h>

@class RKCDArticle;

@interface RKCDArticleList : NSManagedObject

@property (nonatomic, retain) NSString * article_description;
@property (nonatomic, retain) NSString * link;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSDate * pubDate;
@property (nonatomic, retain) NSSet *articles;

+ (RKEntityMapping *) responseMapping;

@end

@interface RKCDArticleList (CoreDataGeneratedAccessors)

- (void)addArticlesObject:(RKCDArticle *)value;
- (void)removeArticlesObject:(RKCDArticle *)value;
- (void)addArticles:(NSSet *)values;
- (void)removeArticles:(NSSet *)values;

@end
