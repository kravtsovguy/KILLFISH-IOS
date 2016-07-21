//
//  Platform.swift
//  KILLFISH
//
//  Created by Matvey Kravtsov on 11.07.16.
//  Copyright © 2016 Матвей Кравцов. All rights reserved.
//

struct Platform {
    static let isSimulator: Bool = {
        var isSim = false
        #if arch(i386) || arch(x86_64)
            isSim = true
        #endif
        return isSim
    }()
}
