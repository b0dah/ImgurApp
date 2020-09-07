//
//  Result.swift
//  ImgurApp
//
//  Created by Иван Романов on 07.09.2020.
//  Copyright © 2020 Иван Романов. All rights reserved.
//

import UIKit

enum Result<ResultType> {
  case results(ResultType)
  case error(Error)
}

enum Error: Swift.Error {
  case unknownAPIResponse
  case generic
}
