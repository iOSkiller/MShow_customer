//
//  YYShoppingCartSpecificationView.m
//  DDFood
//
//  Created by YZ Y on 16/11/28.
//  Copyright © 2016年 YZ Y. All rights reserved.
//

#define titleViewHeight 44
#define countViewHeight RELATIVE_WIDTH(126)
#define sureButtonHeight RELATIVE_WIDTH(90)
#define goodsSpecViewHeight RELATIVE_WIDTH(270)
#define collectionViewHeight RELATIVE_WIDTH(280)
#define backViewHeight RELATIVE_WIDTH(920)

#import "YYShoppingCartSpecificationView.h"
#import "YYGoodsModel.h"
#import "YYGoodsSpecificationCell.h"
#import "YYGoodsSpecificationModel.h"
#import "YYGoodsSpecificationFlowLayout.h"
#import "YYGoodsSpecInfoView.h"
#import "YYShoppingCartSpecificationViewCell.h"
//#import "YYShoppingCartHandle.h"


static NSString *const kCellID = @"YYShoppingCatSpecificationCellID";

@interface YYShoppingCartSpecificationView () <CAAnimationDelegate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) UIButton *closeButton;
@property (nonatomic, weak) UIButton *sureButton;
@property (nonatomic, weak) UIView *backView;
@property (nonatomic, weak) UIView *tapView;
@property (nonatomic, weak) YYGoodsSpecInfoView *specInfoView;
@property (nonatomic, weak) YYBaseTableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *cartGoodsArray;


@end

@implementation YYShoppingCartSpecificationView

{
    CALayer *imageViewLayer;
    UIBezierPath *path;
    CGRect _originalFrame;
    NSInteger _goodsCount;
    NSUInteger repeatGoodsIdx;
    BOOL isRepeatGoods;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray *)cartGoodsArray {
    if (!_cartGoodsArray) {
        _cartGoodsArray = [NSMutableArray array];
    }
    return _cartGoodsArray;
}


- (UIView *)tapView {
    if (!_tapView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, self.mj_h - backViewHeight)];
        view.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeAction)];
        [view addGestureRecognizer:tap];
        [self addSubview:view];
        _tapView = view;
    }
    return _tapView;
}


- (UIView *)backView {
    if (!_backView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, backViewHeight)];
        view.backgroundColor = [UIColor whiteColor];
        [self addSubview:view];
        _backView = view;
    }
    return _backView;
}

- (UIButton *)closeButton {
    if (!_closeButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"img_mistake"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
        [self.specInfoView addSubview:button];
        _closeButton = button;
    }
    return _closeButton;
}

- (UIButton *)sureButton {
    if (!_sureButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"确定" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(44)];
        button.backgroundColor = YYGlobalColor;
        [button addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
        [self.backView addSubview:button];
        _sureButton = button;
    }
    return _sureButton;
}

- (YYBaseTableView *)tableView {
    if (!_tableView) {
        YYBaseTableView *view = [[YYBaseTableView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, backViewHeight - sureButtonHeight) style:UITableViewStylePlain];
        view.backgroundColor = [UIColor whiteColor];
        view.separatorColor = YYSeparatorColor;
        view.separatorInset = UIEdgeInsetsMake(0, RELATIVE_WIDTH(24), 0, RELATIVE_WIDTH(24));
        view.layoutMargins = UIEdgeInsetsMake(0, RELATIVE_WIDTH(24), 0, RELATIVE_WIDTH(24));
        view.delegate = self;
        view.dataSource = self;
        [self.backView addSubview:view];
        _tableView = view;
    }
    return _tableView;
}

- (YYGoodsSpecInfoView *)specInfoView {
    if (!_specInfoView) {
        YYGoodsSpecInfoView *view = [[YYGoodsSpecInfoView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, RELATIVE_WIDTH(264))];
        view.imgView.backgroundColor = [UIColor orangeColor];
        view.lastestPriceLabel.attributedText = [NSString str1:@"全新价：" font1:[UIFont systemFontOfSize:RELATIVE_WIDTH(30)] color1:YYTextColor str2:@"￥1200" font2:[UIFont systemFontOfSize:RELATIVE_WIDTH(30)] color2:YYGlobalColor];
        view.cheapPriceLabel.attributedText = [NSString str1:@"共享价：" font1:[UIFont systemFontOfSize:RELATIVE_WIDTH(30)] color1:YYTextColor str2:@"￥12" font2:[UIFont systemFontOfSize:RELATIVE_WIDTH(30)] color2:YYGlobalColor];
        view.stockLabel.text = @"库存：20件";
        view.specLabel.text = @"已选：粉色，S";
        [self.backView addSubview:view];
        _specInfoView = view;
    }
    return _specInfoView;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.goodsModel = [YYGoodsModel new];
        self.goodsModel.color = @"粉红";
        self.goodsModel.size = @"S";
        _goodsCount = 1;
        _originalFrame = CGRectMake(0, self.mj_h - backViewHeight, self.mj_w, backViewHeight);
        self.backView.mj_y = WIN_HEIGHT;
        [self tapView];
        [self backView];
        [self tableView];
        [self closeButton];
        [self sureButton];
        
        self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, RELATIVE_WIDTH(30))];
        
        self.hidden = YES;
        [self updateLayout];
    }
    return self;
}

- (void)setGoodsModel:(YYGoodsModel *)goodsModel
{
    _goodsModel = goodsModel;
    _goodsModel.count = @"1";
//    [self fetchData:goodsModel.commodityid];
    
}

- (void)updateSpecInfoView
{
    self.specInfoView.specLabel.text = [NSString stringWithFormat:@"已选：%@，%@", _goodsModel.color, _goodsModel.size];
}

- (void)show
{
    [(mAppDelegate).window addSubview:self];
    self.hidden = NO;
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.75];
    
    //初始化
    [self.cartGoodsArray removeAllObjects];
//    [self.cartGoodsArray addObjectsFromArray:(mAppDelegate).cartDataArr];
    //[self logCart:@"show"];
    _goodsModel.count = @"1";
//    _goodsModel.spec_id = nil;
    _goodsModel.spec = nil;
    
    [self checkGoodsSpec];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.backView.frame = _originalFrame;
    }];
}

- (void)updateGoodsCount:(NSString *)count
{
    _goodsModel.count = count;
}

- (void)checkGoodsSpec
{
    if (self.dataArray.count) {
        if (_selectedSpec != nil && ![_selectedSpec isEqualToString:@""]) {
            for (YYGoodsSpecificationModel *model in self.dataArray) {
                if ([model.specid isEqualToString:_selectedSpec]) {
//                    NSUInteger idx = [self.dataArray indexOfObject:model];
                    
                    [self updateGoodsPrice:model];
                    break;
                }
            }
        } else {
            [self updateGoodsPrice:self.dataArray[0]];
        }
    }
}

#pragma mark - UITableViewDataSource/Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = [NSString stringWithFormat:@"YYShoppingCartSpecificationViewCellID:%@%@", @(indexPath.row), @(indexPath.section)];
    YYShoppingCartSpecificationViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[YYShoppingCartSpecificationViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        WS(weakSelf);
        switch (indexPath.row) {
            case 0:
            {
                [cell setType:YYShoppingCartSpecificationViewCellTypeSpecSelection selectionArray:[YYGoodsSpecificationModel testSpecDataArray]];
                cell.didSelectSpecBlock = ^(NSString *spec_id, NSString *spec) {
                    StrongSelf(strongSelf);
                    strongSelf = weakSelf;
                    strongSelf.goodsModel.color = spec;
                    [strongSelf updateSpecInfoView];
                };
                break;
            }
            case 1:
            {
                [cell setType:YYShoppingCartSpecificationViewCellTypeSizeSelection selectionArray:[YYGoodsSpecificationModel testSizeDataArray]];
                cell.didSelectSizeBlock = ^(NSString *spec_id, NSString *size) {
                    StrongSelf(strongSelf);
                    strongSelf = weakSelf;
                    strongSelf.goodsModel.size = size;
                    [strongSelf updateSpecInfoView];
                };
                break;
            }
            case 2:
            {
                [cell setType:YYShoppingCartSpecificationViewCellTypeCountSelection selectionArray:nil];
                cell.didSelectCountBlock = ^(NSString *count) {
                    StrongSelf(strongSelf);
                    strongSelf = weakSelf;
                    strongSelf.goodsModel.count = count;
                    [strongSelf updateSpecInfoView];
                };
                break;
            }
            default:
                break;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(YYShoppingCartSpecificationViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, RELATIVE_WIDTH(24), 0, RELATIVE_WIDTH(24))];
    }
    if ([cell respondsToSelector:@selector(setLayoutManager:)]) {
        [cell setLayoutMargins:UIEdgeInsetsMake(0, RELATIVE_WIDTH(24), 0, RELATIVE_WIDTH(24))];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            return RELATIVE_WIDTH(280);
            break;
        case 1:
            return RELATIVE_WIDTH(200);
            break;
        case 2:
            return RELATIVE_WIDTH(140);
            break;
        default:
            break;
    }
    return 44;
}

#pragma mark - buttonAction

- (void)closeAction
{
    [self hide];
    
    if (_delegate && [_delegate respondsToSelector:@selector(isHide)]) {
        [_delegate isHide];
    }
}

- (void)sureAction
{
    _goodsModel.isSelected = YES;
    //是否立即购买
    if (_isImmediatedBuy) {
        [self finishAddGoods];
        return;
    }
    
    isRepeatGoods = NO;
    
//    for (YYGoodsModel *temp in self.cartGoodsArray) {
//        if ([temp.spec_id isEqualToString:self.goodsModel.spec_id]) {
//            isRepeatGoods = YES;
//            repeatGoodsIdx = [self.cartGoodsArray indexOfObject:temp];
//            break;
//        }
//    }
    
    if (isRepeatGoods) {
        YYGoodsModel *temp = self.cartGoodsArray[repeatGoodsIdx];
        NSInteger count = [temp.count integerValue] + _goodsCount;
        _goodsModel.count = [NSString stringWithFormat:@"%@", @(count)];
        _totalCount -= [temp.count integerValue];
//        if ((mAppDelegate).isLogin) {
//            
//        } else {
//            [self.cartGoodsArray replaceObjectAtIndex:repeatGoodsIdx withObject:_goodsModel];
//            _totalCount += count;
//            [self finishAddGoods];
//        }
//        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
//        [YYShoppingCartHandle executeManageShopingCartUserID:(mAppDelegate).userId goodsArray:@[_goodsModel] type:YYShoppingCartHandleTypeAdd success:^(id obj) {
//            [hud hide:YES afterDelay:0.1];
//            [self.cartGoodsArray replaceObjectAtIndex:repeatGoodsIdx withObject:_goodsModel];
//            _totalCount += count;
//            [self finishAddGoods];
//        } failed:^(id failed) {
//            hud.mode = MBProgressHUDModeText;
//            hud.labelText = failed;
//            [hud hide:YES afterDelay:1.5];
//
//        }];
    } else {
//        if ((mAppDelegate).isLogin) {
//           
//        } else {
//            _totalCount += [self.goodsModel.count integerValue];
//            [self.cartGoodsArray addObject:self.goodsModel];
//            isRepeatGoods = YES;
//            repeatGoodsIdx = self.cartGoodsArray.count - 1;
//            [self finishAddGoods];
//        }
//        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
//        [YYShoppingCartHandle executeManageShopingCartUserID:(mAppDelegate).userId goodsArray:@[_goodsModel] type:YYShoppingCartHandleTypeAdd success:^(id obj) {
//            [hud hide:YES afterDelay:0.1];
//            [self.cartGoodsArray addObject:self.goodsModel];
//
//            _totalCount += [self.goodsModel.count integerValue];
//            isRepeatGoods = YES;
//            repeatGoodsIdx = self.cartGoodsArray.count - 1;
//            [self finishAddGoods];
//        } failed:^(id failed) {
//            hud.mode = MBProgressHUDModeText;
//            hud.labelText = failed;
//            [hud hide:YES afterDelay:1.5];
//        }];
    }
    [self finishAddGoods];
    [self hide];
   
}

- (void)hide
{
    self.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
        self.backView.mj_y = WIN_HEIGHT;
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.hidden = YES;
        [self removeFromSuperview];
    });
}


- (void)finishAddGoods
{
    CGRect imageFrame = self.specInfoView.imgView.frame;
    imageFrame.origin.y = self.specInfoView.mj_y;
    [self startAnimationWithRect:imageFrame imageView:self.specInfoView.imgView];
    
    
    
    if (_isImmediatedBuy) {
        if (_delegate && [_delegate respondsToSelector:@selector(gotoMakeDeal:isImmediatedBuy:)]) {
            [_delegate gotoMakeDeal:_goodsModel isImmediatedBuy:_isImmediatedBuy];
        }
    } else {
        if (_delegate && [_delegate respondsToSelector:@selector(addGoodsToCart:goodsModel:)]) {
            [_delegate addGoodsToCart:_totalCount goodsModel:_goodsModel];
        }
    }
}

- (void)fetchData:(NSString *)goodsID
{
    [self.dataArray removeAllObjects];
    
//    [YYShoppingCartHandle executeGetGoodsSpecList:self.goodsModel.goods_id success:^(id obj) {
//        [self.dataArray addObjectsFromArray:obj];
//
//        [self.collectionView reloadData];
//        [self.collectionView layoutIfNeeded];
//        [self checkGoodsSpec];
//        [self updateLayout];
//    } failed:^(id failed) {
//
//    }];
}


- (void)updateGoodsPrice:(YYGoodsSpecificationModel *)model
{
    _goodsModel.spec = model.name;
    _goodsModel.spec_notes = [NSString stringWithFormat:@"%@kg/%@%@", model.weight, model.unit, model.notes];
//    _goodsModel.spec_id = model.specid;
    _goodsModel.currentPrice = model.price;
    _goodsModel.stockcounts = model.stock;
//    _goodsModel.originalPrice = model.original_price;
//    _goodsModel.begintime = model.begintime;
//    _goodsModel.discounttime = model.discounttime;
//    _goodsModel.prom_type = model.prom_type;
    if (self.dataArray.count == 1 || model.prom_type == 2) {
        
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectSpec:)]) {
        [_delegate didSelectSpec:_goodsModel];
    }
}


- (void)updateLayout
{
    WS(ws);
    
//    [self.backView mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.left.right.equalTo(ws);
//        make.height.mas_equalTo(backViewHeight);
//    }];
    
    [self.specInfoView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView).offset(-RELATIVE_WIDTH(40));
        make.left.right.equalTo(ws);
        make.height.mas_equalTo(RELATIVE_WIDTH(264));
    }];
    
    [self.closeButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.specInfoView).offset(RELATIVE_WIDTH(80));
        make.right.equalTo(self.specInfoView).offset(-RELATIVE_WIDTH(26));
        make.width.height.mas_equalTo(RELATIVE_WIDTH(44));
    }];
    
    [self.tapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(ws);
        make.bottom.equalTo(self.backView.mas_top);
    }];
    
    [self.sureButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.mj_w, sureButtonHeight));
        make.left.equalTo(self.backView);
        make.bottom.equalTo(self.backView.mas_bottom).offset((mAppDelegate).iPhoneX ? -iPhoneX_MARGIN_BOTTOM - RELATIVE_WIDTH(30) : 0);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.backView);
        make.top.equalTo(self.specInfoView.mas_bottom);
        make.bottom.equalTo(self.sureButton.mas_top);
    }];
    
}

#pragma mark - Animation
- (void)startAnimationWithRect:(CGRect)rect imageView:(UIImageView *)imageView
{
    if (!imageViewLayer) {
        
        imageViewLayer = [CALayer layer];
        imageViewLayer.contents = (id)imageView.layer.contents;
        
        imageViewLayer.contentsGravity = kCAGravityResizeAspectFill;
        imageViewLayer.bounds = rect;
        [imageViewLayer setCornerRadius:CGRectGetHeight([imageViewLayer bounds]) / 2];
        imageViewLayer.masksToBounds = YES;
        // 导航64
        imageViewLayer.position = CGPointMake(imageView.center.x, CGRectGetMidY(rect));
        [self.layer addSublayer:imageViewLayer];
        path = [UIBezierPath bezierPath];
        //画笔移动到起点
        [path moveToPoint:imageViewLayer.position];
        //画二元曲线 设置终点 和 起点
        switch (_animationType) {
            case YYShoppingCartAnimationTypeRight:
                [path addQuadCurveToPoint:CGPointMake(WIN_WIDTH - 40, WIN_WIDTH - 40) controlPoint:CGPointMake(rect.origin.x, rect.origin.y)];
                break;
            case YYShoppingCartAnimationTypeBottom:
                [path addQuadCurveToPoint:CGPointMake(RELATIVE_WIDTH(124), WIN_WIDTH - 44) controlPoint:CGPointMake(WIN_WIDTH / 2, rect.origin.y)];
                break;
            default:
                break;
        }
        
        
    }
    [self groupAnimation];
}

- (void)groupAnimation
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = path.CGPath;
    animation.rotationMode = kCAAnimationRotateAuto;
    CABasicAnimation *expandAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    expandAnimation.duration = 0.5f;
    expandAnimation.fromValue = [NSNumber numberWithFloat:0.5f];
    expandAnimation.toValue = [NSNumber numberWithFloat:0.2f];
    expandAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    CABasicAnimation *narrowAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    narrowAnimation.beginTime = .2f;
    narrowAnimation.fromValue = [NSNumber numberWithFloat:0.5f];
    narrowAnimation.duration = 0.5f;
    narrowAnimation.toValue = [NSNumber numberWithFloat:0.2f];
    
    narrowAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CAAnimationGroup *groups = [CAAnimationGroup animation];
    groups.animations = @[animation, expandAnimation, narrowAnimation];
    groups.duration = 0.5f;
    groups.removedOnCompletion = NO;
    groups.fillMode = kCAFillModeForwards;
    groups.delegate = self;
    
    //动画开始 关闭交互
    self.userInteractionEnabled = NO;
    [imageViewLayer addAnimation:groups forKey:@"group"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    // [anim def];
    if (anim == [imageViewLayer animationForKey:@"group"]) {
        [imageViewLayer removeFromSuperlayer];
        imageViewLayer = nil;
    }
    
    //动画结束 开启交互
    self.userInteractionEnabled = YES;
    [self closeAction];
}


@end
