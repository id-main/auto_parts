//
//  CellPoza.h
//  Piese auto
//
//  Created by Ioan Ungureanu on 04/03/16.
//  Copyright © 2016 Activesoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "utile.h"

@interface CellPoza:UICollectionViewCell {
    
    Utile *utilitarx;
}

@property(nonatomic, strong) IBOutlet UIImageView *patrat; //apare la select cell
@property(nonatomic, strong) IBOutlet UIImageView *pozaTHUMB; //imaginea de cell
@property(nonatomic, strong) IBOutlet UILabel *scriscifre; //apare la select cell
-(void)loadObjectCell;


@end