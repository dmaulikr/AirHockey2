//
//  AboutViewController.swift
//  AirHockey2
//
//  Created by student1 on 5/26/17.
//  Copyright © 2017 John Hersey High School. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func back(_ sender: UIButton) {
        var viewControllerForSegue = self.view?.window?.rootViewController
        viewControllerForSegue?.dismiss(animated: true, completion: nil)
    }


}
