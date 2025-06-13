//
//  chooseview.h
//  Pieseauto
//
//  Created by Ioan Ungureanu on 24/02/16.
//  Copyright © 2016 Activesoft. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "DataMasterProcessor.h"
#import <UIKit/UIKit.h>
#import "utile.h"
#import "TTTAttributedLabel.h"
#import "CellChoose.h"
@interface chooseview : UIViewController<UITabBarDelegate,UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UITextFieldDelegate,UISearchBarDelegate> {
    Utile * utilitar;
    BOOL isSearching;
}

@property (nonatomic,strong) IBOutlet UITableView *LISTASELECT; //  tabel
@property (nonatomic,strong) NSMutableDictionary *judet;
@property (nonatomic,strong) NSArray *data;
@property (nonatomic,strong) NSString *CE_TIP_E; // MARCI , NOI SAU SECOND , JUDETE
@property (nonatomic,strong) NSArray *searchResults;
@property (nonatomic,strong) IBOutlet UISearchBar* baracautare;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint *tableoriginy;
@property (nonatomic,assign) NSInteger tippreferinta;
@property(strong)  NSIndexPath* lastIndexPath;

@end
