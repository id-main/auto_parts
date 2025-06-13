//
//  CellLanguage.h
//  Piese auto
//
//  Created by Ioan Ungureanu on 02/03/16.
//  Copyright © 2016 Activesoft. All rights reserved.
//

/*#ifndef CellLanguage_h
#define CellLanguage_h


#endif  CellLanguage_h */
#import <UIKit/UIKit.h>
#import "utile.h"

@interface CellLanguage:UITableViewCell {
    
    Utile *utilitarx;
}

@property(nonatomic, strong) IBOutlet UILabel *TitluTara;
@property(nonatomic, strong) IBOutlet UILabel *SubtitluTara;
@property(nonatomic, strong) IBOutlet UIImageView *Steag; //poza imagine steag
@property(nonatomic, strong) IBOutlet UIImageView *sageata; //poza imagine steag
-(void)loadObjectCell;


@end