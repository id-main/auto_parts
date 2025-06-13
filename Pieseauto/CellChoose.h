//
//  CellChoose.h
//  Piese auto
//
//  Created by Ioan Ungureanu on 07/03/16.
//  Copyright © 2016 Activesoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "utile.h"

@interface CellChoose:UITableViewCell {
    
    Utile *utilitarx;
}

@property(nonatomic, strong) IBOutlet UILabel *SubtitluRand;
@property(nonatomic, strong) IBOutlet UIImageView *sageata; //poza imagine sageata
@property(nonatomic, strong) IBOutlet UIImageView *bifablue; //bifa imagine 
-(void)loadObjectCell;


@end