//
//  CerereNouaViewController.h
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
#import "CellHome.h"
//@import Photos iOS 8
#import <Photos/PHPhotoLibrary.h>
#import <Photos/PHImageManager.h>
#import <Photos/PHAsset.h>
#import <Photos/PHFetchResult.h>
//iOS7
#import <AssetsLibrary/AssetsLibrary.h>
@interface CerereNouaViewController : UIViewController<UITabBarDelegate,UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate> {
    Utile * utilitar;
}

@property (nonatomic,strong) IBOutlet TTTAttributedLabel *ceriofertatext;//textul cu 3 puncte...
@property (nonatomic,strong) IBOutlet UITableView *LISTASELECT; //  tabel
@property (nonatomic,strong) NSArray* titluri;
@property (nonatomic,strong) NSArray* subtitluri;
@property (nonatomic,strong) NSMutableDictionary *CERERE;
@property (nonatomic,strong) NSMutableDictionary *CEREREDUPAMODIFICARE; // to do ... pentru masinile deja existente si care nu se modifica
@property (nonatomic,strong) NSMutableArray *pozele;
@property (nonatomic,strong) NSArray *piesenoisausecond;
@property (nonatomic,strong) ALAssetsLibrary *librarie;
@property (nonatomic,assign) BOOL primadata; //face focus pe input text doar prima data cand intra in ecran
@property (nonatomic,assign) BOOL eineditare; //daca keyboard e deschis
@property (nonatomic,assign) BOOL precompletarejudet;


-(IBAction)fapozaAction:(id)sender;
@end
