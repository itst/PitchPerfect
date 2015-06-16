//
//  RecordedAudio.swift
//  PitchPerfect
//
//  Created by Sascha A. Carlin on 15.06.15.
//  Copyright (c) 2015 Sascha A. Carlin. All rights reserved.
//

import Foundation

class RecordedAudio {

    var title: String
    var filePathUrl: NSURL
    
	init() {
		self.title = ""
		self.filePathUrl = NSURL()
	}
	
	init(title: String, filePathUrl: NSURL) {
        self.title = title
        self.filePathUrl = filePathUrl
    }

}