//
//  DisplayTableViewController.h
//  XMLParsingDemo
//
//  Created by TheAppGuruz-iOS-103 on 31/12/14.
//  Copyright (c) 2014 TheAppGururz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DisplayTableViewController : UITableViewController <NSXMLParserDelegate>

@property (nonatomic, strong) NSMutableDictionary *dictData;
@property (nonatomic,strong) NSMutableArray *marrXMLData;
@property (nonatomic,strong) NSMutableString *mstrXMLString;
@property (nonatomic,strong) NSMutableDictionary *mdictXMLPart;

@end
