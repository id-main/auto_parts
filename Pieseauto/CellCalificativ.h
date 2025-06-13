//
//  CellCalificativ.h
//  Piese auto
//
//  Created by Ioan Ungureanu on 31/03/16.
//  Copyright © 2016 Activesoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "utile.h"
#import "TTTAttributedLabel.h"
#import "CustomBadge.h"

@interface CellCalificativ:UITableViewCell<UITextFieldDelegate> {
    
    Utile *utilitarx;
}

@property (nonatomic,strong) IBOutlet UISegmentedControl *SEGCNTRL;
@property (nonatomic,weak) IBOutlet  NSLayoutConstraint *dynamiccellcomentariuheight; // comentariul are h dinamic
///////////////////////////////////////////////////////////
@property (nonatomic,strong) IBOutlet UIView *RowGalben;
@property (nonatomic,strong) IBOutlet UIImageView *iconinfo;
@property (nonatomic,strong) IBOutlet UILabel *nuacordamesaj;
@property (nonatomic,strong) IBOutlet UIImageView *iconclose;

@property (nonatomic,strong) IBOutlet UIView *RowAcorda;
@property (nonatomic,strong) IBOutlet TTTAttributedLabel *titlucerereanunt;
@property (nonatomic,strong) IBOutlet TTTAttributedLabel *acordacalificativ;
@property (nonatomic,strong) IBOutlet TTTAttributedLabel *numeutilizator;
@property (nonatomic,strong) IBOutlet TTTAttributedLabel *numeutilizatorextins;
@property (nonatomic,strong) IBOutlet UIImageView *iconuser;
@property (nonatomic,strong) IBOutlet UIImageView *sageatablue;
@property (nonatomic,strong) IBOutlet UIImageView *iconcalificativ;
@property (nonatomic,strong) IBOutlet UIImageView *sageatagri;


@end

