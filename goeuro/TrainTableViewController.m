//
//  TrainTableViewController.m
//  goeuro
//
//  Created by Ray on 2016/10/21.
//  Copyright © 2016年 test. All rights reserved.
//

#import "TrainTableViewController.h"
#import "ListItemTableViewCell.h"
#import "Trip.h"
#import <UIImageView+AFNetworking.h>

@interface TrainTableViewController ()
{
    BOOL priceAscending;
    BOOL stopAscending;
    BOOL loadingData;
}
@property (nonatomic, strong) NSMutableArray *fetchArray;
@property (nonatomic, strong) NSArray *subArray;
@property (nonatomic, assign) NSInteger pagecount;
@end

@implementation TrainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.trainTableView.delegate = self;
    self.trainTableView.dataSource = self;
    loadingData = false;
    self.pagecount = 0;
    self.fetchArray = [[NSMutableArray alloc]init];
    self.fetchArray = [Trip getTrips:0];
    if ([self.fetchArray count] > 0) {
        self.subArray = [self.fetchArray subarrayWithRange:NSMakeRange(self.pagecount, 10)];
        self.pagecount +=10;
    }else{
        [self.demoManager getDatafromServer:0 withSucess:^(NSMutableArray *result) {
            self.fetchArray =result;
            self.subArray = [self.fetchArray subarrayWithRange:NSMakeRange(self.pagecount, 10)];
            self.pagecount +=10;
            [self.trainTableView reloadData];
        }];
    
    }
    
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"TrainTableViewController viewWillAppear");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.subArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"ListItemTableViewCell";
    ListItemTableViewCell * cell = [self.trainTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[ListItemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    Trip *trip = [self.subArray objectAtIndex:indexPath.row];
    cell.price.text =[trip getPrice:trip.priceInEuros];
    cell.travelTime.text = [trip getTravelTimeDeparture:trip.departureTime Arrival:trip.arrivalTime stop:trip.numberOfStops];
    
    [self loadImageURL:[NSURL URLWithString:trip.providerLogo] forImageView:cell.travelLogo];
    cell.direct.text = [trip getDireectTimeDeparture:trip.departureTime Arrival:trip.arrivalTime];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //DetailViewController *detailVC = [[DetailViewController alloc]initWithNibName:@"DetailViewController" bundle:nil];
    //[self.navigationController pushViewController:detailVC animated:YES];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger lastSectionIndex = [tableView numberOfSections] - 1;
    NSInteger lastRowIndex = [tableView numberOfRowsInSection:lastSectionIndex] - 1;
    if ((indexPath.section == lastSectionIndex) && (indexPath.row == lastRowIndex)) {
        loadingData = true;
        [self loadMore];
    }
}

- (void)loadMore
{
    if (loadingData && !(self.pagecount+1 > [self.fetchArray count])) {
        NSArray *nextArray =[self.fetchArray subarrayWithRange:NSMakeRange(self.pagecount, 10)];
        self.subArray =[self.subArray arrayByAddingObjectsFromArray:nextArray];
        self.pagecount +=10;
        [self.trainTableView reloadData];
        loadingData = false;
    }else{
        loadingData = false;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 96;
}

- (void)loadImageURL:(NSURL *)url forImageView:(UIImageView *)imageView
{
    [self.imageManager downloadImageWithURL:url
                                    options:0
                                   progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                       
                                   }
                                  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                      imageView.image = image;
                                  }];
    
}

-(void)postListViewAction
{
    
}
-(void)sortClicked:(id)sender
{
}

-(void)postAction
{
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Sort",@"Sort")
                                                                         message:nil
                                                                  preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel",@"Cancel") style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Sort By Price",@"Sort By Price") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self sortByPrice];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Sort By Stop",@"Sort By Stop") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self sortByStop];
        
    }]];
    [self presentViewController:actionSheet animated:YES completion:nil];
    
    
}

-(void)sortByPrice
{
    [self.fetchArray sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"priceInEuros" ascending:priceAscending]]];
    priceAscending = !priceAscending;
    self.pagecount = 0;
    self.subArray = [self.fetchArray subarrayWithRange:NSMakeRange(self.pagecount, self.pagecount+10)];
    [self.trainTableView reloadData];
}

-(void)sortByStop
{
    [self.fetchArray sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"numberOfStops" ascending:stopAscending]]];
    stopAscending = !stopAscending;
    self.pagecount = 0;
    self.subArray = [self.fetchArray subarrayWithRange:NSMakeRange(self.pagecount, self.pagecount+10)];
    [self.trainTableView reloadData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
