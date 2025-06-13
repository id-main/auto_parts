//
// TabelPozeCerereVC.h -> un view cu poze selectate pe cerere
//  Pieseauto
//
//  Created by Ioan Ungureanu on 17/03/16.
//  Copyright © 2016 Activesoft. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "DataMasterProcessor.h"
#import <UIKit/UIKit.h>
#import "utile.h"
#import "TTTAttributedLabel.h"
//@import Photos iOS 8
#import <Photos/PHPhotoLibrary.h>
#import <Photos/PHImageManager.h>
#import <Photos/PHAsset.h>
#import <Photos/PHFetchResult.h>
//iOS7
#import <AssetsLibrary/AssetsLibrary.h>

@interface TabelPozeCerereVC : UIViewController<UITabBarDelegate,UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UITextFieldDelegate,UISearchBarDelegate> {
    Utile * utilitar;
}
@property (nonatomic,strong) IBOutlet UITableView *LISTASELECT; //  tabel
@property (nonatomic,strong) IBOutlet UILabel *labelsusaddpoza; //  albel mare cu buton add poza
@property (nonatomic,strong) NSMutableArray *POZEALESE;
@property (nonatomic,strong) NSMutableArray *ARRAYASSETURI;
@property (nonatomic,strong) NSMutableArray *ARRAYASSETURIEXTERNE;
@property (nonatomic,strong) NSMutableArray *POZEUTILIZATOR;
@property (nonatomic,strong) IBOutlet ALAssetsLibrary *librarie;
@end
