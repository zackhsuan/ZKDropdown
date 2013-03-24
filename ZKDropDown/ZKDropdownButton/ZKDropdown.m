//
//  ZKDropdownButton.m
//  ZKDropDown
//
//  Created by Kheam on 21/03/13.
//  Copyright (c) 2013 zack. All rights reserved.
//

#import "ZKDropdown.h"

@interface ZKDropdown(){
    UITableView *dropdownList;
    ZKDropdownHandler custHandler;
    CGFloat frameHeight;
    UIView *trigger;
    BOOL isDropping;
    ZKSelectionMode selectionMode;
}

@end

@implementation ZKDropdown

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id) initDropdownToObject:(UIView *) view WithKeys:(NSArray *)keys andValues:(NSArray*)values withType:(ZKSelectionMode)mode complete:(ZKDropdownHandler)handle{
    
    self = [super init];
    
    if (self) {
        selectionMode = mode;
        custHandler = handle;
        CGFloat origX = view.frame.origin.x;
        CGFloat origY = view.frame.origin.y;
        CGFloat origW = view.frame.size.width;
        CGFloat origH = view.frame.size.height;
        frameHeight = keys.count > 5 ? 220 : keys.count * 40;
        
        self.frame = CGRectMake(origX, origY + origH, origW, 0);
        self.keys = keys;
        self.values = values == nil ? keys : values;
        self.backgroundColor = [UIColor whiteColor];
        trigger = view;
        
        dropdownList = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, origW, 0)];
        dropdownList.delegate = self;
        dropdownList.dataSource = self;
        dropdownList.bounces = NO;
        
        dropdownList.layer.cornerRadius = 5;
        
        self.layer.masksToBounds = NO;
        self.layer.cornerRadius = 5;
        self.layer.shadowOffset = CGSizeMake(-5, 5);
        self.layer.shadowRadius = 5;
        self.layer.shadowOpacity = 0.5;
        
        //self.layer.shouldRasterize = YES;
        isDropping = NO;
        [dropdownList reloadData];
        
        [self addSubview:dropdownList];
        
        if (mode == ZKSelectionModeMutiple) {
            
        }

    }
    
    return self;
}

-(CGRect) updateFrame{
    CGFloat origX = trigger.frame.origin.x;
    CGFloat origY = trigger.frame.origin.y;
    CGFloat origW = trigger.frame.size.width;
    CGFloat origH = trigger.frame.size.height;
    
    return CGRectMake(origX, origY + origH, origW, self.frame.size.height);
}

-(void) dropList{
    [trigger.superview addSubview:self];
    
    if (isDropping) {
        [self hideDropdownListByIndex:-1];
        return;
    }
    self.frame = [self updateFrame];
    
    [UIView animateWithDuration:0.4 animations:^{
        CGRect newframe = self.frame;
        newframe.size.height = frameHeight;
        self.frame = newframe;
        newframe.origin.x = newframe.origin.y = 0;
        dropdownList.frame = newframe;
    } completion:^(BOOL finished) {
        isDropping = YES;
    }];

}

-(void) hideDropdownListByIndex:(int)index{
    self.frame = [self updateFrame];
    
    [UIView animateWithDuration:0.4 animations:^{
        CGRect newFrame = self.frame;
        newFrame.size.height = 0;
        self.frame = newFrame;
        newFrame.origin.x = newFrame.origin.y = 0;
        dropdownList.frame = newFrame;
    } completion:^(BOOL finished) {
        isDropping = NO;
        
        if (index < 0) {
            custHandler(NO,nil, nil);
        }else{
            custHandler(YES, [self.keys objectAtIndex:index], [self.values objectAtIndex:index]);
        }
    }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self hideDropdownListByIndex:indexPath.row];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.keys.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellId = @"ZKDropCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.textLabel.font = [trigger valueForKey:@"font"];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.textColor = [UIColor blackColor];
        
        UIView * v = [[UIView alloc] init];
        v.backgroundColor = [UIColor darkGrayColor];
        cell.selectedBackgroundView = v;
        
    }
    
    cell.textLabel.text = [self.keys objectAtIndex:indexPath.row];
    
    return cell;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect
//{
//    // Drawing code
//
//
//}


@end
