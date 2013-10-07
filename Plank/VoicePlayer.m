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
@property (strong, nonatomic) AVSpeechSynthesizer *synth;
@end

@implementation VoicePlayer

- (id)init {
    self = [super init];
    if (self) {
        self.synth = [AVSpeechSynthesizer new];
    }
    return self;
}
- (void)playText:(NSString *)text {
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:text];
    [self.synth speakUtterance:utterance];
}

@end
