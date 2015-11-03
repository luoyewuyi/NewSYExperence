//
//  SYAppListCollectionViewController.m
//  SYExperence
//
//  Created by yuhang on 15/9/21.
//  Copyright (c) 2015年 yuhang. All rights reserved.
//

#import "SYAppListCollectionViewController.h"
#import "SYAppItemCell.h"
#import "SYAppItem.h"
@interface SYAppListCollectionViewController ()


@property (nonatomic, strong)   NSArray* appInfos;

@end

@implementation SYAppListCollectionViewController

static NSString * const reuseIdentifier = @"Cell";
- (id)init
{
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];

    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(10, 5, 10, 5);
    layout.itemSize = CGSizeMake(100, 100);
    
    self = [super initWithCollectionViewLayout:layout];
    if (self)
    {
        //
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[SYAppItemCell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.alwaysBounceVertical = YES;
    self.collectionView.alwaysBounceHorizontal = YES;
    
    // Do any additional setup after loading the view.
    SYAppItem* item1 = [[SYAppItem alloc] init];
    item1.title = @"item1";
    item1.icon = @"apper";
    
    SYAppItem* item2 = [[SYAppItem alloc] init];
    item2.title = @"item2";
    item2.icon = @"caipiao";
    
    SYAppItem* item3 = [[SYAppItem alloc] init];
    item3.title = @"item3";
    item3.icon = @"cloudphotos";
    
    _appInfos = @[item1, item2, item3, item2, item3, item2, item3, item2, item3, item2, item3];
    self.collectionView.backgroundColor = [UIColor grayColor];
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

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _appInfos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SYAppItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    SYAppItem* item = _appInfos[indexPath.row];
    cell.item = item;
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

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
