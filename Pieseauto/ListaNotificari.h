//
//  ListaNotificari.h
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

@interface ListaNotificari : UIViewController<UITabBarDelegate,UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UITextFieldDelegate,UISearchBarDelegate> {
    Utile * utilitar;
}
@property (nonatomic,strong) IBOutlet UITableView *LISTASELECT; //  tabel
@property (nonatomic,strong) NSMutableArray *titluriCAMPURI; //  titluriCAMPURI
@property (nonatomic,strong) NSDictionary *listaNOTIFICARI; //  titluriCAMPURI
@property (nonatomic,assign) int catepagininotificari;
@property (nonatomic,assign) int _currentPage_notificari;
@property (nonatomic,assign) BOOL edinback;
@property (nonatomic,strong) IBOutlet UILabel  *nusuntnotificari; //  tabel
@property (nonatomic,assign) BOOL edinpsuh;
@property (nonatomic,strong) UIRefreshControl *refreshControl;
@property (nonatomic,strong) UITableViewController *xrays;

@end
