//
//  MobileUpViewController.swift
//  TestMU
//
//  Created by Андрей Цуркан on 24.04.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol MobileUpDisplayLogic: class {
  func displayData(viewModel: MobileUp.Model.ViewModel.ViewModelData)
}

class MobileUpViewController: UIViewController, MobileUpDisplayLogic {

  var interactor: MobileUpBusinessLogic?
  var router: (NSObjectProtocol & MobileUpRoutingLogic)?

  // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  
  private func setup() {
    let viewController        = self
    let interactor            = MobileUpInteractor()
    let presenter             = MobileUpPresenter()
    let router                = MobileUpRouter()
    viewController.interactor = interactor
    viewController.router     = router
    interactor.presenter      = presenter
    presenter.viewController  = viewController
    router.viewController     = viewController
  }
  
  // MARK: Routing
  

  
  // MARK: View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  func displayData(viewModel: MobileUp.Model.ViewModel.ViewModelData) {

  }
  
}
