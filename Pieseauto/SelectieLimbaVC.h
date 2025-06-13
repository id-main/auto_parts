//
//  SelectieLimbaVC.h
//  Piese auto
//
//  Created by Ioan Ungureanu on 02/03/16.
//  Copyright © 2016 Activesoft. All rights reserved.
//
/*
#ifndef SelectieLimbaVC_h
#define SelectieLimbaVC_h


#endif  SelectieLimbaVC_h */
#import <UIKit/UIKit.h>
#import "utile.h"

@interface SelectieLimbaVC:UIViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate> {
    Utile *utilitarx;
}
@property (nonatomic,strong) IBOutlet UITableView* table;
@property (nonatomic,strong) IBOutlet NSArray* steaguri;
@property (nonatomic,strong) IBOutlet NSArray* titluri;
@property (nonatomic,strong) IBOutlet NSArray* subtitluri;
@property (nonatomic,strong) IBOutlet NSArray* codlimba;

-(void)returnToRoot;


@end
