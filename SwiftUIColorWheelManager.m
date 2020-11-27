//
//  SwiftUIColorWheelManager.m
//  lava
//
//  Created by Ryan Sam on 11/27/20.
//

#import <Foundation/Foundation.h>
#import "React/RCTViewManager.h"
#import "React/RCTComponentEvent.h"
#import "lava-Swift.h"

@interface SwiftUIColorWheelManager : RCTViewManager
@end

@implementation SwiftUIColorWheelManager

-(UIView *)view {
  SwiftUIColorWheelProxy *proxy = [[SwiftUIColorWheelProxy alloc] init];
  return [proxy view];
}

@end
