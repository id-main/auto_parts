//
//  LoginView.h -> un view cu 2 textfields mail parola
//  Pieseauto
//
//  Created by Ioan Ungureanu on 21/03/16.
//  Copyright © 2016 Activesoft. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "DataMasterProcessor.h"
#import <UIKit/UIKit.h>
#import "utile.h"
#import "TTTAttributedLabel.h"


@interface LoginView : UIViewController<UITabBarDelegate,UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UITextFieldDelegate,UISearchBarDelegate> {
    Utile * utilitar;
}
@property (nonatomic,strong) IBOutlet UITableView *LISTASELECT; //  tabel
@property (nonatomic,strong) NSArray *titluriCAMPURI; //  titluriCAMPURI
@property (nonatomic,strong) NSString *CE_TIP_E; // login , register
@property (nonatomic,assign) BOOL DEACORD;

//-(BOOL) isValidEmail:(NSString *)checkString; //folosit la register
//-(BOOL) isValidPhone:(NSString *)checkString;
@end
