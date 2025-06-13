//
//  CerereExistentaViewController.h
//  Pieseauto
//
//  Created by Ioan Ungureanu on 11/04/16.
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
@interface CerereExistentaViewController : UIViewController<UITabBarDelegate,UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate> {
    Utile * utilitar;
}

@property (nonatomic,strong) IBOutlet UITableView *LISTASELECT; //  tabel
@property (nonatomic,strong) NSMutableArray* titluri;
@property (nonatomic,strong) NSArray* subtitluri;
@property (nonatomic,strong) NSMutableDictionary *CERERE;
@property (nonatomic,strong) NSMutableArray *OFERTACASTIGATOARE;
@property (nonatomic,strong) NSMutableArray *MESAJEREX;
@property (nonatomic,strong) NSMutableDictionary *DICTIONARWINNER; // contine datele despre userul care a castigat
@property (nonatomic,strong) NSMutableDictionary *CEREREDUPAMODIFICARE; // to do ... pentru masinile deja existente si care nu se modifica
@property (nonatomic,strong) NSMutableArray *pozele;
@property (nonatomic,strong) NSMutableDictionary *intrebaridelaaltii;
@property (nonatomic,strong) NSMutableArray *mesajele;
@property (nonatomic,strong) NSArray *piesenoisausecond;
@property (nonatomic,strong) ALAssetsLibrary *librarie;
@property (nonatomic,strong) IBOutlet UITabBar *barajos; //2 butoane ->anuleaza cerere, reposteaza cerere
@property (nonatomic,strong) NSMutableDictionary *DETALIICERERE;
@property (nonatomic,strong) NSMutableDictionary *OFERTACASTIGATOARELACERERE;
@property (nonatomic,strong) NSMutableArray *itemurioferta;
@property (nonatomic,assign) BOOL AREWINNER;
@property (nonatomic,assign) BOOL ARECALIFICATIV;
@property (nonatomic,assign) BOOL E_ANULATA;
@property (nonatomic,strong) IBOutlet UIView *ANULEAZAVIEW;
@property (nonatomic,strong) IBOutlet UIButton *BTN_CONFIRMA;
@property (nonatomic,strong) IBOutlet UIButton *BTN_RENUNTA;
@property (nonatomic,strong) IBOutlet TTTAttributedLabel *TextAIALESSAANULEZI;

@property (nonatomic,strong) IBOutlet UIView *AFOSTANULATAVIEW;
@property (nonatomic,strong) IBOutlet UIButton *BTN_OK;
@property (nonatomic,strong) IBOutlet UIButton *BTN_REPOSTEAZA;
@property (nonatomic,strong) IBOutlet TTTAttributedLabel *TextAFOSTANULATA;
@property (nonatomic,strong) NSMutableArray *stareexpand;
@property (nonatomic,strong) NSString *CE_TIP_E;


@end
