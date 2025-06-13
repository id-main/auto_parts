//
//  choose4view.h -> un view cu 3 textfields
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


@interface choose4view : UIViewController<UITabBarDelegate,UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UITextFieldDelegate,UISearchBarDelegate,UITextViewDelegate> {
    Utile * utilitar;
}
@property (nonatomic,strong) IBOutlet UIButton *Continua;
@property (nonatomic,strong) IBOutlet UITableView *LISTASELECT; //  tabel
@property (nonatomic,strong) NSArray *titluriCAMPURI; //  titluriCAMPURI
@property (nonatomic,strong) IBOutlet UIImageView *sageatablue; //
@property (nonatomic,strong) NSString *CE_TIP_E;
@property (nonatomic,weak) IBOutlet  NSLayoutConstraint *dynamictableheightJ; // different table height
-(void)editProfile :(NSString *)AUTHTOKEN :(NSMutableDictionary *)DATEUSER :(NSString *)tip_date;//numeprenume, adresa etc.
@end
