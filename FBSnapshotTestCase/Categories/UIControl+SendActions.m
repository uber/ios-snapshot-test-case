/**
 Copyright (c) 2018 Uber Technologies, Inc.

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

#import "UIControl+SendActions.h"

/**
 UIControlEvents has options in the range 0-8, 12-13, 16-19. 9-11 are reserved for future UIControlEventTouch* options. 14-15 are reserved for other options. If new options are added after 19, this const will need to be updated.
 */
static NSUInteger const UIControlEventsMaxOffset = 19;


@implementation UIControl (UberTesting)

- (void)ub_sendActionsForControlEvents:(UIControlEvents)controlEvents
{
  for (NSUInteger i = 0; i < UIControlEventsMaxOffset; i++) {
    UIControlEvents controlEvent = 1 << i;
    if (controlEvents & controlEvent) {
      for (id target in self.allTargets) {
        NSArray<NSString *> *targetActions = [self actionsForTarget:target forControlEvent:controlEvent];
        for (NSString *action in targetActions) {
          SEL selector = NSSelectorFromString(action);
          IMP imp = [target methodForSelector:selector];
          void (*func)(id, SEL, id) = (void *)imp;
          func(target, selector, self);
        }
      }
    }
  }
}

@end
