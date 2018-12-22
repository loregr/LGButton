//
//  ViewController.swift
//  LGButtonDemo
//
//  Created by Lorenzo Greco on 28/05/2017.
//  Copyright © 2017 Lorenzo Greco. All rights reserved.
//

import UIKit
import LGButton

class ViewController: UIViewController {


    @IBAction func action(_ sender: LGButton) {
        sender.isLoading = true
        let deadlineTime = DispatchTime.now() + .seconds(3)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            sender.isLoading = false
            // DO SOMETHING
        }
    }
}

