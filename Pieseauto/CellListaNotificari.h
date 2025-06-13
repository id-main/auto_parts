//
//  CellListaNotificari.h
//  Piese auto
//
//  Created by Ioan Ungureanu on 31/03/16.
//  Copyright © 2016 Activesoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "utile.h"
#import "TTTAttributedLabel.h"
#import "CustomBadge.h"

@interface CellListaNotificari:UITableViewCell<UITextFieldDelegate> {
    
    Utile *utilitarx;
}

@property (nonatomic,strong) IBOutlet UIImageView *roundblue;//cerc albastru
@property (nonatomic,strong) IBOutlet UIImageView *sageatagri; //sageata gri middle
@property (nonatomic,strong) IBOutlet UILabel *TitluRand;
@property (nonatomic,strong) IBOutlet UILabel *datasiora;


@end

