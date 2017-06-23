//
//  BTLeftListView.m
//  BanTang
//
//  Created by guanli on 16/4/26.
//  Copyright © 2016年 CaoFei. All rights reserved.
//

#import "BTPlazaLeftListView.h"

@interface BTPlazaLeftListContainerView : UIView

@property (nonatomic, strong) CAShapeLayer *popLayer;
@property (nonatomic, assign) CGFloat  apexOftriangelX;
@property (nonatomic, strong) UIColor *layerColor;

@end

@implementation BTPlazaLeftListContainerView

- (CAShapeLayer *)popLayer {
    if (!_popLayer) {
        _popLayer = [[CAShapeLayer alloc]init];
        [self.layer addSublayer:_popLayer];
        //_popLayer.masksToBounds = YES;
    }
    return _popLayer;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"frame"]) {
        CGRect tempFrame = CGRectNull;
        if ([object valueForKeyPath:keyPath] != [NSNull null]) {
            tempFrame = [[object valueForKeyPath:keyPath] CGRectValue];
            [self setLayerFrame:tempFrame];
        }
    }
}

- (void)setLayerFrame:(CGRect)frame {
    float apexOfTrianglelx;
    if (self.apexOftriangelX == 0) {
        apexOfTrianglelx = frame.size.width -NavBarHeight;
    } else {
        apexOfTrianglelx = self.apexOftriangelX;
    }
    
    if (apexOfTrianglelx > frame.size.width - ListViewCornerRadius) {
        apexOfTrianglelx = frame.size.width - ListViewCornerRadius - 0.5 * TriangleWidth;
    }else if (apexOfTrianglelx < ListViewCornerRadius) {
        apexOfTrianglelx = ListViewCornerRadius + 0.5 * TriangleWidth;
    }
    
    
    CGPoint point0 = CGPointMake(apexOfTrianglelx, 0);
    CGPoint point1 = CGPointMake(apexOfTrianglelx - 0.5 * TriangleWidth, TriangleHeight);
    CGPoint point2 = CGPointMake(ListViewCornerRadius, TriangleHeight);
    CGPoint point2_center = CGPointMake(ListViewCornerRadius, TriangleHeight + ListViewCornerRadius);
    
    CGPoint point3 = CGPointMake(0, frame.size.height - ListViewCornerRadius);
    CGPoint point3_center = CGPointMake(ListViewCornerRadius, frame.size.height - ListViewCornerRadius);
    
    CGPoint point4 = CGPointMake(frame.size.width - ListViewCornerRadius, frame.size.height);
    CGPoint point4_center = CGPointMake(frame.size.width - ListViewCornerRadius, frame.size.height - ListViewCornerRadius);
    
    CGPoint point5 = CGPointMake(frame.size.width, TriangleHeight + ListViewCornerRadius);
    CGPoint point5_center = CGPointMake(frame.size.width - ListViewCornerRadius, TriangleHeight + ListViewCornerRadius);
    
    CGPoint point6 = CGPointMake(apexOfTrianglelx + 0.5 * TriangleWidth, TriangleHeight);
    
    
    
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:point0];
    [path addLineToPoint:point1];
    [path addLineToPoint:point2];
    [path addArcWithCenter:point2_center radius:ListViewCornerRadius startAngle:3*M_PI_2 endAngle:M_PI clockwise:NO];
    
    [path addLineToPoint:point3];
    [path addArcWithCenter:point3_center radius:ListViewCornerRadius startAngle:M_PI endAngle:M_PI_2 clockwise:NO];
    
    [path addLineToPoint:point4];
    [path addArcWithCenter:point4_center radius:ListViewCornerRadius startAngle:M_PI_2 endAngle:0 clockwise:NO];
    
    [path addLineToPoint:point5];
    [path addArcWithCenter:point5_center radius:ListViewCornerRadius startAngle:0 endAngle:3*M_PI_2 clockwise:NO];
    
    [path addLineToPoint:point6];
    [path closePath];
    
    
    
    self.popLayer.path = path.CGPath;
    self.popLayer.fillColor = _layerColor? _layerColor.CGColor : [UIColor greenColor].CGColor;

}

- (void)setApexOftriangelX:(CGFloat)apexOftriangelX {
    _apexOftriangelX = apexOftriangelX;
    [self setLayerFrame:self.frame];
}

- (void)setLayerColor:(UIColor *)layerColor {
    _layerColor = layerColor;
    [self setLayerFrame:self.frame];
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    
    self.transform = CGAffineTransformMakeScale(1.1, 1.1);
    self.alpha = 0;
    [UIView animateWithDuration:0.2 animations:^{
        self.transform = CGAffineTransformMakeScale(1.0, 1.0);
        self.alpha = 1;
    }];
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"frame"];
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addObserver:self forKeyPath:@"frame" options:0 context:NULL];
    }
    return self;
}

@end



@interface BTPlazaLeftListView () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, retain)BTPlazaLeftListContainerView *containerView;
@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) NSArray *titleMenus;

@end

@implementation BTPlazaLeftListView

- (BTPlazaLeftListContainerView *)containerView {
    if (!_containerView) {
        _containerView = [[BTPlazaLeftListContainerView alloc]init];
        [self addSubview:_containerView];
    }
    return _containerView;
}

- (UITableView *)table
{
    if (nil == _table) {
        _table = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        //        _table.backgroundView = nil;
        //        _table.backgroundColor = [UIColor clearColor];
        //        _table.separatorColor = [UIColor whiteColor];
        _table.tableFooterView = [UIView new];
        _table.layer.cornerRadius = ListViewCornerRadius;
        _table.layer.masksToBounds = YES;
    }
    return _table;
}


- (instancetype)initWithBounds:(CGRect)bounds titleMenus:(NSArray *)titles
{
    self = [super initWithFrame:bounds];
    if (self) {
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        self.titleMenus = titles;
        
        self.table.frame = CGRectMake(0, 0, CGRectGetWidth(bounds), CGRectGetHeight(bounds));
        self.table.delegate = self;
        self.table.dataSource = self;
        
        [self setContentView:self.table];
        
        _table.scrollEnabled = NO;
        if ([_table respondsToSelector:@selector(setSeparatorInset:)]) {
            //让线头不留白
            [_table setSeparatorInset:UIEdgeInsetsZero];
            
        }
        if ([_table respondsToSelector:@selector(setLayoutMargins:)]) {
            
            [_table setLayoutMargins:UIEdgeInsetsZero];
            
        }
    }
    return self;
}

#pragma mark- set background color
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        //        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

+ (instancetype)popOverView
{
    return [[self alloc]init];
}


- (void)setContentView:(UIView *)contentView {
    _contentView = contentView;
    
    CGRect contentFrame = contentView.frame;
    
    contentFrame.origin.x = ListViewRoundMargin;
    contentFrame.origin.y = TriangleHeight + ListViewRoundMargin;
    contentView.frame = contentFrame;
    
    
    CGRect  temp = self.containerView.frame;
    temp.size.width = CGRectGetMaxX(contentFrame) + ListViewRoundMargin; // left and right space
    temp.size.height = CGRectGetMaxY(contentFrame) + ListViewRoundMargin;
    
    self.containerView.frame = temp;
    
    [self.containerView addSubview:contentView];
}

- (void)setContentViewController:(UIViewController *)contentViewController
{
    _contentViewController = contentViewController;
    [self setContentView:_contentViewController.view];
    
}

- (void)setContainerBackgroudColor:(UIColor *)containerBackgroudColor
{
    _containerBackgroudColor = containerBackgroudColor;
    self.containerView.layerColor = _containerBackgroudColor;
}




- (void)showFrom:(UIView *)from alignStyle:(ListViewAlignStyle)style
{
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];

    //[window addSubview:self];
    
    self.frame = CGRectMake(0, NavBarHeight, ScreenWidth, ScreenHeight - TabBarHeight - NavBarHeight);
    //self.frame = window.bounds;
    
    CGRect newFrame = [from convertRect:from.bounds toView:window];
    
    
    // change containerView position
    CGRect containerViewFrame = self.containerView.frame;
    //containerViewFrame.origin.y =  NavBarHeight + 5;
    containerViewFrame.origin.y = 5;
    self.containerView.frame = containerViewFrame;

    self.containerView.transform = CGAffineTransformMakeScale(1.1, 1.1);
    self.containerView.alpha = 0;
    self.containerView.hidden = NO;
    [UIView animateWithDuration:0.2 animations:^{
        self.containerView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        self.containerView.alpha = 1;
    }];
    
    
    switch (style) {
        case ListViewAlignStyleCenter:
        {
            CGPoint center = self.containerView.center;
            center.x = CGRectGetMidX(newFrame);
            self.containerView.center = center;
            
            self.containerView.apexOftriangelX = CGRectGetWidth(self.containerView.frame)/2;
        }
            break;
        case ListViewAlignStyleLeft:
        {
            CGRect frame = self.containerView.frame;
            frame.origin.x = CGRectGetMinX(newFrame);
            self.containerView.frame = frame;
            
            self.containerView.apexOftriangelX = CGRectGetWidth(from.frame)/2;
        }
            
            break;
        case ListViewAlignStyleRight:
        {
            CGRect frame = self.containerView.frame;
            frame.origin.x = CGRectGetMinX(newFrame) - (fabs(frame.size.width - newFrame.size.width));
            self.containerView.frame = frame;
            
            self.containerView.apexOftriangelX = CGRectGetWidth(self.containerView.frame) - CGRectGetWidth(from.frame)/2;
        }
            
            break;
            
        default:
            break;
    }
    
    
    if ([self.delegate respondsToSelector:@selector(listViewDidShow:)]) {
        [self.delegate listViewDidShow:self];
    }
}



- (void)dismiss
{
    
    // animations support
    [UIView animateWithDuration:0.15 animations:^{
        self.containerView.transform = CGAffineTransformMakeScale(0.9,0.9);
        self.containerView.alpha = 0;
    } completion:^(BOOL finished) {
        self.containerView.hidden = YES;
        [self removeFromSuperview];
    }];
    
    
    
    if ([self.delegate respondsToSelector:@selector(listViewDidDismiss:)]) {
        [self.delegate listViewDidDismiss:self];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismiss];
}

#pragma mark- <UITableViewDelegate, UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleMenus.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"GYPopOverCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = self.titleMenus[indexPath.row];
    cell.textLabel.textColor = TitleLightColor;
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    cell.textLabel.font = [UIFont systemFontOfSize:13.0];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(showListView:didClickAtIndex:)]) {
        [self.delegate showListView:self didClickAtIndex:indexPath.row];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setBackgroundColor:[UIColor clearColor]];
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}


@end
