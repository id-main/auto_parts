//
//pozemesajeviewVC.h ->
//  Pieseauto
//
//  Created by Ioan Ungureanu on 14/03/16.
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

@interface pozemesajeviewVC : UIViewController<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate> {
    Utile * utilitar;
    
}
@property (nonatomic,strong) IBOutlet UIButton *faopoza;
@property (nonatomic,strong) IBOutlet NSMutableArray *POZEUTILIZATOR; //  galeria foto din telefon
@property (nonatomic,strong) IBOutlet NSMutableArray *THUMBNAILSPOZEUTILIZATOR; //  galeria foto din telefon
@property (nonatomic,strong) IBOutlet NSMutableArray *POZEALESE; //  ce a selectat userul -> indecsi
@property (nonatomic,strong) IBOutlet NSMutableArray *ARRAYASSETURI; //toata aria cu assets selectate
@property (nonatomic,strong) IBOutlet UICollectionView *ttil; //thumbnails poze
@property (nonatomic,strong) IBOutlet ALAssetsLibrary *librarie;
@property (nonatomic,assign) int numarmaxpoze;
@property (strong, atomic) ALAssetsLibrary* libraryx;
- (ALAssetsLibrary *)defaultAssetsLibrary;
@property (nonatomic,assign) BOOL pozaNOUA;
typedef void(^myCompletion)(BOOL);
@end
