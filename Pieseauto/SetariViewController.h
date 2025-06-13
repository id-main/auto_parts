//
//  SetariViewController.h
//  Pieseauto
//
//  Created by Ioan Ungureanu on 30/03/16.
//  Copyright © 2016 Activesoft. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "DataMasterProcessor.h"
#import <UIKit/UIKit.h>
#import "utile.h"
#import "TTTAttributedLabel.h"
#import "utile.h"

@interface SetariViewController : UIViewController<UITabBarDelegate,UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UITextFieldDelegate,UISearchBarDelegate,UINavigationBarDelegate,UINavigationControllerDelegate> {
    Utile * utilitar;
}
@property (nonatomic,strong) IBOutlet UITableView *LISTASELECT; //  tabel
@property (nonatomic,strong) NSArray *titluriCAMPURI; //  titluriCAMPURI
@property (nonatomic,assign) BOOL dinmodificari;
@end
