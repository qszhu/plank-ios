//
//  VoicePlayer.m
//  Plank
//
//  Created by Qinsi ZHU on 9/15/13.
//  Copyright (c) 2013 Qinsi ZHU. All rights reserved.
//

#import "VoicePlayer.h"
#import "AVFoundation/AVFoundation.h"

@interface VoicePlayer()
@property (strong, nonatomic) AVQueuePlayer *player;
@end

@implementation VoicePlayer

- (void)playText:(NSString *)text {
    NSMutableArray *items = [[NSMutableArray alloc] init];
    for (NSString *word in [text componentsSeparatedByString:@" "]) {
        NSString *path = [[NSBundle mainBundle] pathForResource:word ofType:@"m4a"];
        NSURL *url = [NSURL fileURLWithPath:path];
        AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:url];
        [items addObject:item];
    }
    self.player = [AVQueuePlayer queuePlayerWithItems:items];
    [self.player play];
}

@end
