//
//  ZKDropdownButton.h
//  ZKDropDown
//
//  Created by Kheam on 21/03/13.
//  Copyright (c) 2013 zack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuartzCore/QuartzCore.h"

typedef enum _ZKSelectionMode {
    ZKSelectionModeSingle = 0,
    ZKSelectionModeMutiple
} ZKSelectionMode;

typedef void (^ZKDropdownHandler)(BOOL isSelectionMade, id key, id value);

@interface ZKDropdown : UIView<UITableViewDataSource, UITableViewDelegate>

@property NSArray *values;
@property NSArray *keys;

@property id selectedValue;
@property id selectedKey;

-(id) initDropdownToObject:(UIView *) view WithKeys:(NSArray *)keys andValues:(NSArray*)values withType:(ZKSelectionMode)mode complete:(ZKDropdownHandler) handle;

-(void) dropList;

@end
