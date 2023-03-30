//
//  CongratulationViewController.swift
//  BecomeMillionaire
//
//  Created by Дмитрий on 30.03.2023.
//

import UIKit

protocol CongratulationViewControllerDelegate: AnyObject {
    func restartFromCongratulation(dismiss: Void)
}

class CongratulationViewController: UIViewController {
    
    weak var delegate: CongratulationViewControllerDelegate?
    
    func changeAmount(_ amount: String) {
        
    }
}
