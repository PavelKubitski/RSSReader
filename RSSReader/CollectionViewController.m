//
//  CollectionViewController.m
//  RSSReader
//
//  Created by Pavel Kubitski on 18.01.16.
//  Copyright (c) 2016 Pavel Kubitski. All rights reserved.
//

#import "CollectionViewController.h"
#import "CollectionViewCell.h"
#import "TableViewController.h"

@interface CollectionViewController ()

@property (strong, nonatomic) NSArray *links;
@property (strong, nonatomic) NSArray *titleOfSection;

@end

@implementation CollectionViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    

    
    self.navigationItem.title = @"Onliner RSS Reader";

    self.links = [NSArray arrayWithObjects:@"http://people.onliner.by", @"http://auto.onliner.by", @"http://tech.onliner.by", @"http://realt.onliner.by", nil];
    self.titleOfSection = [NSArray arrayWithObjects:@"People", @"Auto", @"Tech", @"Realt", nil];
    
    // Do any additional setup after loading the view.
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * const reuseIdentifier = @"CollectionViewCell";
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];


    cell.titleLabel.text = [self.titleOfSection objectAtIndex:indexPath.row];
    cell.titleLabel.textColor = [UIColor whiteColor];
    cell.titleLabel.adjustsFontSizeToFitWidth = YES;
    cell.titleLabel.font = [cell.titleLabel.font fontWithSize:120];
    
    return cell;
}



#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    TableViewController *sectionVC = [self.storyboard instantiateViewControllerWithIdentifier:@"TableViewController"];
    [self.navigationController pushViewController:sectionVC animated:YES];
    sectionVC.baseURL = [self.links objectAtIndex:indexPath.row];
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: Deselect item
}


/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
