//
//  MobileUpPresenter.swift
//  TestMU
//
//  Created by Андрей Цуркан on 24.04.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol MobileUpPresentationLogic {
  func presentData(response: MobileUp.Model.Response.ResponseType)
}

class MobileUpPresenter: MobileUpPresentationLogic {
  weak var viewController: MobileUpDisplayLogic?
  
  func presentData(response: MobileUp.Model.Response.ResponseType) {
  
  }
  
}
