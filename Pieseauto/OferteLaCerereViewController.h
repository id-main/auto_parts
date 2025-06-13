//
//  OferteLaCerereViewController.h
//  Pieseauto
//
//  Created by Ioan Ungureanu on 05/04/16.
//  Copyright © 2016 Activesoft. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "DataMasterProcessor.h"
#import <UIKit/UIKit.h>
#import "utile.h"
#import "TTTAttributedLabel.h"
#import "CustomBadge.h"

@interface OferteLaCerereViewController : UIViewController<UITabBarDelegate,UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UITextFieldDelegate,UISearchBarDelegate>{
    Utile * utilitar;
}
@property (nonatomic,strong) IBOutlet UITableView *LISTASELECT; //  tabel
@property (nonatomic,strong) IBOutlet UISegmentedControl *SEGCNTRL; //Active | Rezolvate
@property (nonatomic,strong) NSMutableArray *TOATE; //  cererile mele
@property (nonatomic,strong) NSMutableArray *PREFERATE; // cererile rezolvate
@property (nonatomic,strong) UIButton *btniconpreferate;
@property (nonatomic,strong) IBOutlet UIView *HEADERCERERE; //contine titlu si ce e mai jos
@property (nonatomic,strong) IBOutlet TTTAttributedLabel *numecerere;
@property (nonatomic,strong) IBOutlet TTTAttributedLabel *masinacerere;
@property (nonatomic,strong) IBOutlet UIImageView *pozacerere;
@property (nonatomic,strong) IBOutlet UIImageView *sageatablue;
@property (nonatomic,strong) NSString *idcerere;
@property (nonatomic,strong) IBOutlet UILabel *nuaipreferate;
@property (nonatomic,strong) NSMutableDictionary *CORPDATE; //  contine detaliu cerere + ARRAY OFERTE  -> vine din ecranul anterior cererile mele
@property (nonatomic,strong) NSMutableDictionary *DETALIUCERERE;
@property (nonatomic,assign) int  _currentPage; // toate ofertele
@property (nonatomic,assign) int _currentPagePreferate; // oferte preferate
@property (nonatomic,assign) int numarpagini; // nr  pag ofertele active
@property (nonatomic,assign) int numarpaginipreferate; // nr  pag ofertele preferate
@property (nonatomic,strong) NSMutableDictionary *comentariicerere; //  cererile mele
@property (nonatomic,strong) NSMutableDictionary *DETALIUOFERTA;
@property (nonatomic,weak) IBOutlet  NSLayoutConstraint *dynamicHEADLEFT; // different cell text align (cu sau fara poza)
@property (nonatomic,assign) BOOL E_DIN_DETALIU_CERERE;
@property (nonatomic,weak) IBOutlet  NSLayoutConstraint *dynamicINALTIMETITLUCERERE; //
@property (nonatomic,weak) IBOutlet  NSLayoutConstraint *dynamicINALTIMEMASINACERERE;
@property (nonatomic,weak) IBOutlet  NSLayoutConstraint *dynamicINALTIMEHEADER;

@end
