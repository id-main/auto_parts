//
//  EcranAdresaViewController.h -> un view cu 8 rows ...adresa completa judet localitate etc
//  Pieseauto
//
//  Created by Ioan Ungureanu on 04/04/16.
//  Copyright © 2016 Activesoft. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "DataMasterProcessor.h"
#import <UIKit/UIKit.h>
#import "utile.h"
#import "TTTAttributedLabel.h"


@interface EcranAdresaViewController : UIViewController<UITabBarDelegate,UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UITextFieldDelegate,UISearchBarDelegate> {
    Utile * utilitar;
}
@property (nonatomic,strong) IBOutlet UIButton *Continua;
@property (nonatomic,strong) IBOutlet UITableView *LISTASELECT; //  tabel
@property (nonatomic,strong) NSArray *titluriCAMPURI; //  titluriCAMPURI
@property (nonatomic,strong) NSString *CE_TIP_E;
@property (nonatomic,weak) IBOutlet  NSLayoutConstraint *dynamictableheightJ; // different table height
@property (nonatomic,weak) IBOutlet  NSLayoutConstraint *dynamicHEIGHTTEXTVIEW; // different table height
@end
