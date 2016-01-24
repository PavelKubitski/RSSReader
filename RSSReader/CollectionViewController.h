//
//  CollectionViewController.h
//  RSSReader
//
//  Created by Pavel Kubitski on 18.01.16.
//  Copyright (c) 2016 Pavel Kubitski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <RestKit/RestKit.h>

@interface CollectionViewController : UICollectionViewController <UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) RKObjectManager *manager;
@property (strong, nonatomic) RKManagedObjectStore * moStore;

@end
