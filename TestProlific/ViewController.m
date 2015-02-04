//
//  ViewController.m
//  TestProlific
//
//  Created by Bharath G M on 2/3/15.
//  Copyright (c) 2015 Bharath G M. All rights reserved.
//

#import "ViewController.h"
#import "AddBookViewController.h"
#import "Author.h"
#import "DetailViewController.h"

static NSString* endPoint = @"http://prolific-interview.herokuapp.com/54b1b332031fe20007e76b5b/books/";
#define ROWHEIGHT 70;

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    NSData* data;
    Author* authorData;
    NSArray* listOfAuthours;
    UITableView* tableView;
    
}
@property (strong,nonatomic) NSData* data;

@end


@implementation ViewController
@synthesize data;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self customizeUI];
    
    [self downloadDataInBackground];
}

-(void)customizeUI
{
    self.title = @"Books";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem* addBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addBooks)];
    
    self.navigationItem.leftBarButtonItem = addBarButtonItem;

}

-(void)downloadDataInBackground
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    dispatch_async(dispatch_get_global_queue(0, 0),
                   ^{
                       self.data = [NSData dataWithContentsOfURL:[NSURL URLWithString:endPoint]];
                       NSLog(@"Data = %@", data);
                       dispatch_async(dispatch_get_main_queue(),
                                      ^{
                                          if (!data)
                                          {
                                              UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Internet appears to be offline" message:@"Please try again later" delegate:nil cancelButtonTitle:@"OK"otherButtonTitles:nil];
                                              [alertView show];
                                              [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                                              
                                          }
                                          else
                                          {
                                              [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                                              id jsonObjects = [NSJSONSerialization JSONObjectWithData:self.data options:NSJSONReadingMutableContainers error:nil];
                                              [self performSelector:@selector(jsonObject:) onThread:[NSThread mainThread] withObject:jsonObjects waitUntilDone:NO];
                                          }
                                      }
                                      );
                   });

}

-(void)jsonObject:(id)jsonObject
{
    NSMutableArray *lObjects = [NSMutableArray array];
    NSLog(@"Json Objects = %@",jsonObject);
    for (id object in jsonObject )
    {
        authorData = [[Author alloc] init];
        authorData.authorName = [object valueForKey:@"author"];
        authorData.categories = [object valueForKey:@"categories"];
        authorData.lastCheckOut = [object valueForKey:@"lastCheckedOut"];
        authorData.lastCheckOutBy = [object valueForKey:@"lastCheckedOutBy"];
        authorData.publisher = [object valueForKey:@"publisher"];
        authorData.title = [object valueForKey:@"title"];
        [lObjects addObject:authorData];
    }
    listOfAuthours = [NSArray arrayWithArray:lObjects];
    
    [self initTableView];
}

-(void)addBooks
{
    AddBookViewController* addBook = [[AddBookViewController alloc] initWithNibName:@"AddBookViewController" bundle:nil];
  
    UINavigationController* navController = [[UINavigationController alloc] initWithRootViewController:addBook];
    
    [self presentViewController:navController animated:YES completion:nil];
    
}


-(void)initTableView
{
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
}

#pragma mark --
#pragma mark Table View Data source methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [listOfAuthours count];//no of objects
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.highlighted = NO;
    }

    cell.textLabel.text = [(Author*)[listOfAuthours objectAtIndex:indexPath.row] title];
    cell.detailTextLabel.text = [(Author*)[listOfAuthours objectAtIndex:indexPath.row] authorName];
    
    return cell;
    
}

#pragma --
#pragma mark Table View Delegates
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DetailViewController *lDetailController = [[DetailViewController alloc] init];
    lDetailController.navigationItem.title = @"Detail";
    [self.navigationController pushViewController:lDetailController animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ROWHEIGHT
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
