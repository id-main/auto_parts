//
//  CereriAnulateViewController.h
//  Pieseauto
//
//  Created by Ioan Ungureanu on 31/03/16.
//  Copyright © 2016 Activesoft. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "DataMasterProcessor.h"
#import <UIKit/UIKit.h>
#import "utile.h"
#import "TTTAttributedLabel.h"
#import "CustomBadge.h"

@interface CereriAnulateViewController : UIViewController<UITabBarDelegate,UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UITextFieldDelegate,UISearchBarDelegate  > {
    Utile * utilitar;
}
@property (nonatomic,strong) IBOutlet UITableView *LISTASELECT; //  tabel
////ANULATE
@property (nonatomic,strong) NSMutableArray *ANULATE; // cererile anulate se aduc cu cancelled
@property (nonatomic,assign) int numarpaginianulate; // nr pag  cererile anulata
@property (nonatomic,assign) int _currentPageAnulate; // cererile anulate
@property (nonatomic,assign) int totalcererianulate; // nr  cererile anulate -> e ultimul rand in tabel de rezolvate x anulate
@property (nonatomic,strong) IBOutlet UITabBar *barajos; //3 butoane ->adauga cerere, cererile mele  si cont


@end
