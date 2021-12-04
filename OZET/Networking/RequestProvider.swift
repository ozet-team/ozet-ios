//
//  RequestProvider.swift
//  OZET
//
//  Created by MK-Mac-255 on 2021/12/05.
//  Copyright © 2021 app.OZET. All rights reserved.
//

import Moya

typealias ResumeProvider = RequestProvider<ResumeAPI>

final class RequestProvider<Target: TargetType>: MoyaProvider<Target> {
  
}
