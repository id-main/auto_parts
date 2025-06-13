//
//  EcranCalificative.h
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

@interface EcranCalificative : UIViewController<UITabBarDelegate,UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UITextFieldDelegate,UISearchBarDelegate  > {
    Utile * utilitar;
}
@property (nonatomic,strong) IBOutlet UITableView *LISTASELECT; //  tabel
@property (nonatomic,strong) NSArray *titluriCAMPURI; //  titluriCAMPURI
@property (nonatomic,assign) int catedeacordat;
@property (nonatomic,assign) int cateacordate;
@property (nonatomic,assign) int cateprimite;
@property (nonatomic,assign) int _currentPage_deacordat;
@property (nonatomic,assign) int _currentPage_acordate;
@property (nonatomic,assign) int _currentPage_primite;
@property (nonatomic,assign) BOOL INCHIDEALERTA;



@property (nonatomic,strong) NSMutableArray *TOATEDEACORDAT;
@property (nonatomic,strong) NSMutableArray *TOATEACORDATE;
@property (nonatomic,strong) NSMutableArray *TOATEPRIMITE;
@property (nonatomic,assign) int SEGMENTACTIV; //e segment selectat implicit 0
@property (nonatomic,strong) IBOutlet UISegmentedControl *SEGCNTRL;
@end
