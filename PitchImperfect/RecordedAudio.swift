//
//  RecordedAudio.swift
//  PitchImperfect
//
//  Created by Michael Rubinstein on 4/24/15.
//  Copyright (c) 2015 Hyloware. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject {
    var filePathUrl: NSURL!
    var title: String!
    init(filePathUrl:NSURL, title:String) {
        self.filePathUrl = filePathUrl
        self.title = title
    }
}