//
//  DetaliuProfil.h
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

@interface DetaliuProfil : UIViewController<UITabBarDelegate,UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UITextFieldDelegate,UISearchBarDelegate  > {
    Utile * utilitar;
}
@property (nonatomic,strong) IBOutlet UITableView *LISTASELECT; //  tabel
@property (nonatomic,strong) NSArray *titluriCAMPURI; //  titluriCAMPURI
@property (nonatomic,assign) BOOL PROFILULMEU;
@property (nonatomic,assign) BOOL AREFIRMA;
@property (nonatomic,strong) NSMutableDictionary *DATEPROFIL;
@property (nonatomic,assign) int catetoate;
@property (nonatomic,assign) int catepozitive;
@property (nonatomic,assign) int cateneutre;
@property (nonatomic,assign) int catenegative;
@property (nonatomic,assign) int _currentPage_toate;
@property (nonatomic,assign) int _currentPage_pozitive;
@property (nonatomic,assign) int _currentPage_neutre;
@property (nonatomic,assign) int _currentPage_negative;


@property (nonatomic,strong) NSMutableArray *TOATECALIFICATIVE;
@property (nonatomic,strong) NSMutableArray *TOATEPOZITIVE;
@property (nonatomic,strong) NSMutableArray *TOATENEUTRE;
@property (nonatomic,strong) NSMutableArray *TOATENEGATIVE;
@property (nonatomic,assign) int SEGMENTACTIV; //e segment selectat implicit
@property (nonatomic,assign) BOOL toateaduse;
@property (nonatomic,assign) BOOL pozitiveaduse;
@property (nonatomic,assign) BOOL neutreaduse;
@property (nonatomic,assign) BOOL negativeaduse;

@end
@interface LABELNUARE: UILabel
//private properties
@property (nonatomic, strong) UILabel *cevaalttext;
@end
