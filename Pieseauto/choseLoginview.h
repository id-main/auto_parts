//
// choseLoginview.h
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
#import <FacebookSDK/FacebookSDK.h>


@interface choseLoginview : UIViewController<UITabBarDelegate,UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UITextFieldDelegate,UISearchBarDelegate,FBLoginViewDelegate> {
    Utile * utilitar;
}
@property (nonatomic,strong) IBOutlet UIButton *Continua;
@property (nonatomic,strong) IBOutlet UITableView *LISTASELECT; //  tabel
@property (nonatomic,strong) NSArray *titluriCAMPURI; //  titluriCAMPURI
@property (nonatomic,strong) NSArray *pozeCAMPURI; //  titluriCAMPURI
@property (nonatomic,strong) IBOutlet UIImageView *sageatablue; //  titluriCAMPURI
@property (nonatomic,strong) IBOutlet UIView *introdunrtelefon; //
@property (nonatomic,strong) IBOutlet TTTAttributedLabel *labeltelefon; //
@property (nonatomic,strong) IBOutlet UITextField *textetelefon; //
@property (nonatomic,strong) IBOutlet UIButton *butonOK; //
@property (nonatomic,strong) IBOutlet UIButton *butonRENUNTA; //
@property (nonatomic,strong) NSString *FACEBOOKTOKENTEMPORAR; // il tine in ecran
@property (nonatomic,assign) BOOL isFBRegister;
-(void)doFacebookLogin: (NSString*) FBTOKEN :(NSString *) telefon;
@end
