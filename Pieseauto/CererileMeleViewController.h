//
//  CererileMeleViewController.h
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

@interface CererileMeleViewController : UIViewController<UITabBarDelegate,UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UITextFieldDelegate,UISearchBarDelegate  > {
    Utile * utilitar;
}
@property (nonatomic,strong) IBOutlet UITableView *LISTASELECT; //  tabel
@property (nonatomic, strong) IBOutlet UISegmentedControl *SEGCNTRL; //Active | Rezolvate
////CERERI ACTIVE
@property (nonatomic,strong) NSMutableArray *CERERIACTIVE; //  cererile mele
@property (nonatomic,assign) int  _currentPage; // cererile active
@property (nonatomic,assign) int numarpagini; // nr  pag cererile active
////REZOLVATE
@property (nonatomic,strong) NSMutableArray *REZOLVATE; // cererile rezolvate
@property (nonatomic,assign) int _currentPageRezolvate; // cererile rezolvate
@property (nonatomic,assign) int numarpaginirezolvate; // nr pag  cererile rezolvate
////ANULATE
@property (nonatomic,strong) NSMutableArray *ANULATE; // cererile anulate se aduc cu cancelled
@property (nonatomic,assign) int numarpaginianulate; // nr pag  cererile anulata
@property (nonatomic,assign) int _currentPageAnulate; // cererile anulate
@property (nonatomic,assign) int totalcererianulate; // nr  cererile anulate -> e ultimul rand in tabel de rezolvate x anulate

@property (nonatomic,strong) IBOutlet UILabel *MOMENTANNUSUNTCERERI; //  label
@property (nonatomic,strong) IBOutlet UITabBar *barajos; //3 butoane ->adauga cerere, cererile mele  si cont
@property (nonatomic,assign) BOOL REINCARCALISTA;
@end
