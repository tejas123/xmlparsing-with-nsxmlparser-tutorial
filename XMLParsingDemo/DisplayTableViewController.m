//
//  DisplayTableViewController.m
//  XMLParsingDemo
//
//  Created by TheAppGuruz-iOS-103 on 31/12/14.
//  Copyright (c) 2014 TheAppGururz. All rights reserved.
//

#import "DisplayTableViewController.h"

@interface DisplayTableViewController ()

@end

@implementation DisplayTableViewController

@synthesize marrXMLData;
@synthesize mstrXMLString;
@synthesize mdictXMLPart;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self startParsing];
}

- (void)startParsing
{
    NSXMLParser *xmlparser = [[NSXMLParser alloc] initWithContentsOfURL:[NSURL URLWithString:@"http://images.apple.com/main/rss/hotnews/hotnews.rss#sthash.TyhRD7Zy.dpuf"]];
    [xmlparser setDelegate:self];
    [xmlparser parse];
    if (marrXMLData.count != 0) {
        [self.tableView reloadData];
    }
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict;
{
    if([elementName isEqualToString:@"rss"])
        marrXMLData = [[NSMutableArray alloc] init];
    if([elementName isEqualToString:@"item"])
        mdictXMLPart = [[NSMutableDictionary alloc] init];
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string;
{
    if(!mstrXMLString)
        mstrXMLString = [[NSMutableString alloc] initWithString:string];
    else
        [mstrXMLString appendString:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName;
{
    if([elementName isEqualToString:@"title"] || [elementName isEqualToString:@"pubDate"])
    {
        [mdictXMLPart setObject:mstrXMLString forKey:elementName];
    }
    if([elementName isEqualToString:@"item"])
        [marrXMLData addObject:mdictXMLPart];
    mstrXMLString = nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [marrXMLData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = [[[marrXMLData objectAtIndex:indexPath.row] valueForKey:@"title"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    cell.detailTextLabel.text = [[[marrXMLData objectAtIndex:indexPath.row] valueForKey:@"pubDate"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return cell;
}

@end
