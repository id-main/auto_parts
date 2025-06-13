//
//  CellChoose4.m
//  Piese auto
//
//  Created by Ioan Ungureanu on 07/03/16.
//  Copyright © 2016 Activesoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CellChoose.h"
#import "AppDelegate.h"

@interface CellChoose ()

@end


@implementation CellChoose
@synthesize  SubtitluRand,sageata,bifablue;
-(void)viewWillAppear:(BOOL)animated {
}
-(void)loadObjectCell{
 //  NSLog(@"aici cell choose");
  
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