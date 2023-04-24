//
//  MobileUpInteractor.swift
//  TestMU
//
//  Created by Андрей Цуркан on 24.04.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol MobileUpBusinessLogic {
  func makeRequest(request: MobileUp.Model.Request.RequestType)
}

class MobileUpInteractor: MobileUpBusinessLogic {

  var presenter: MobileUpPresentationLogic?
  var service: MobileUpService?
  
  func makeRequest(request: MobileUp.Model.Request.RequestType) {
    if service == nil {
      service = MobileUpService()
    }
  }
  
}
