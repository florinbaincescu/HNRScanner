//
//  ViewController.swift
//  HNRScanner
//
//  Created by Deshun Cai on 11/5/18.
//  Copyright © 2018 NUS Hackers. All rights reserved.
//

import UIKit
import BarcodeScanner

class BaseViewController: UIViewController, BarcodeScannerCodeDelegate, BarcodeScannerErrorDelegate, BarcodeScannerDismissalDelegate {
    
    func scanner(_ controller: BarcodeScannerViewController, didCaptureCode code: String, type: String) {
        print(code)
        print(type)
    }
    
    func scanner(_ controller: BarcodeScannerViewController, didReceiveError error: Error) {
        print(error)
    }
    
    func scannerDidDismiss(_ controller: BarcodeScannerViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    private(set) lazy var startScanningButton: UIButton = {
        let this = UIButton()
        this.setTitleColor(UIColor.darkGray, for: .normal)
        this.setTitle("Scan Barcode", for: .normal)
        this.frame = CGRect(x: 0, y: 0, width: 200, height: 100)
        this.addTarget(self, action: #selector(openBarcodeScanner), for: .touchUpInside)
        return this
    }()
    
    
    @objc func openBarcodeScanner() {
        self.performSegue(withIdentifier: "BaseToBarcodeScanner", sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(startScanningButton)
        self.view.bringSubview(toFront: startScanningButton)
    }
    
    
    // MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "BaseToRegisterSuccess" {
            if let vc = segue.destination as? RegisterSuccessViewController {
                vc.participantName = "Suyash"
            }
        }
        
        if let barcodeScannerVC = segue.destination as? BarcodeScannerViewController {
            barcodeScannerVC.codeDelegate = self
            barcodeScannerVC.errorDelegate = self
            barcodeScannerVC.dismissalDelegate = self
            barcodeScannerVC.title = "Welcome to Hack&Roll 2018"
            barcodeScannerVC.messageViewController.messages.processingText = "Looking up your details..."
        }
    }
    

}

