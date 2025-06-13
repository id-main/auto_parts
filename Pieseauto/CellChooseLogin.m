//
//  CellChooseLogin.m
//  Piese auto
//
//  Created by Ioan Ungureanu on 21/03/16.
//  Copyright © 2016 Activesoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CellChooseLogin.h"
#import "AppDelegate.h"

@interface CellChooseLogin()

@end


@implementation CellChooseLogin
@synthesize  TitluRand,pozaRow,pozaSageataRow,TitluRandaidejacont;
-(void)viewWillAppear:(BOOL)animated {
}
-(void)loadObjectCell{
   NSLog(@"aici cell poza row");
  
}
- (void)awakeFromNib
{
    // Initialization code
   // NSLog(@"aici cell choose nib");
    self.contentView.frame = self.bounds;
    self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end