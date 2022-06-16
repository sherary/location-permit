//
//  ViewController.swift
//  location-permit
//
//  Created by Sherary Apriliana on 16/06/22.
//

import UIKit
import CoreLocation
import MessageUI

class ViewController: UIViewController, CLLocationManagerDelegate, MFMessageComposeViewControllerDelegate {

    private var locationManager: CLLocationManager?
    private let latLngLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemFill
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 26)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        latLngLabel.frame = CGRect(x: 20, y: view.bounds.height / 2 - 50, width: view.bounds.width - 40, height: 100)
        view.addSubview(latLngLabel)
        getUserLocation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getUserLocation() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        locationManager?.startUpdatingLocation()
        locationManager?.allowsBackgroundLocationUpdates = true
    }
    
    internal func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            latLngLabel.text = "Lat: \(location.coordinate.latitude) \nLong: \(location.coordinate.longitude)"
        }
    }
    
    @IBAction func sendSMS(_ sender: Any) {
        if MFMessageComposeViewController.canSendText() {
            let controller = MFMessageComposeViewController()
            controller.body = "Halp!"
            controller.recipients = ["081703088740"]
            controller.messageComposeDelegate = self
            self.present(controller, animated: true, completion: nil)
        } else {
            print("Cannot send text AAAAAAAAAAAAAAAAAAAH")
        }
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch (result) {
            case .cancelled:
                print("Message cancelled")
                dismiss(animated: true, completion: nil)
            case .failed:
                print("Message failed")
                dismiss(animated: true, completion: nil)
            case .sent:
                print("Message sent")
                dismiss(animated: true, completion: nil)
            default:
                break
        }
    }
    
    @IBAction func sendWhatsapp(_ sender: UIButton) {
    }
}

