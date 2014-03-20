//
//  TestJSONViewController.m
//  TestJSON
//
//  Created by Quinn Ebert on 3/19/14.
//  Copyright (c) 2014 Quinn Ebert. All rights reserved.
//

#import "TestJSONViewController.h"

@implementation TestJSONViewController

@synthesize rootItems;
@synthesize rootItemsCount;

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self setNeedsStatusBarAppearanceUpdate];
    self.rootItems = [[NSMutableArray alloc] init];
    self.rootItemsCount = 0;
    [self.table reloadData];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

#pragma mark -
#pragma mark Table view delegate lifecycle

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIAlertView *uav = [[UIAlertView alloc] initWithTitle:@"Selected" message:[@"You just selected: " stringByAppendingString:[self.rootItems objectAtIndex:indexPath.row]] delegate:nil cancelButtonTitle:@"Awesome!" otherButtonTitles:nil];
    [uav show];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.rootItemsCount;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SimpleTableItem"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SimpleTableItem"];
    }
    
    cell.textLabel.text = [self.rootItems objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark -
#pragma mark Button tap event lifecycle

- (IBAction)btnTest_onClick:(id)sender {
    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:HOST_URL] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:120];
    NSData *jsonData = [NSURLConnection sendSynchronousRequest:req returningResponse:nil error:nil];
    self.rootItems = [[NSMutableArray alloc] init];
    self.rootItemsCount = 0;
    if (jsonData != nil) {
        NSArray *jsonArr = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        if (jsonArr != nil) {
            for (int x = 0; x < [jsonArr count]; x++)
            {
                if ([[jsonArr objectAtIndex:x] isKindOfClass:[NSString class]]) {
                    NSLog(@"Object at index %i is String (\"%@\")",x,[jsonArr objectAtIndex:x]);
                    [self.rootItems addObject:[jsonArr objectAtIndex:x]];
                    self.rootItemsCount++;
                } else {
                    NSLog(@"Object at index %i is Array!",x);
                    for (int y = 0; y < [[jsonArr objectAtIndex:x] count]; y++)
                    {
                        if ([[[jsonArr objectAtIndex:x] objectAtIndex:y] isKindOfClass:[NSString class]]) {
                            NSLog(@"  Object at index %i,%i is String (\"%@\")",x,y,[[jsonArr objectAtIndex:x] objectAtIndex:y]);
                        } else {
                            NSLog(@"  Object at index %i,%i is Array!",x,y);
                        }
                    }
                }
            }
        } else {
            UIAlertView *uav = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to decode data!" delegate:nil cancelButtonTitle:@"Oh darn!" otherButtonTitles:nil];
            [uav show];
        }
    } else {
        UIAlertView *uav = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to gather data!" delegate:nil cancelButtonTitle:@"Oh darn!" otherButtonTitles:nil];
        [uav show];
    }
    [self.table reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
