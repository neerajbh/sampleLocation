//
//  LocationUpdator.swift
//  project
//
//  Created by neeraj bhatt on 26/09/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

import UIKit
import CoreLocation
import UserNotifications

@objc(LocationUpdator)
class LocationUpdator: UIViewController, CLLocationManagerDelegate, UNUserNotificationCenterDelegate {
  
  let locationManager = CLLocationManager()
  var time: Int = 0
  var alti: Double!
  var longi: Double!
  var lati: Double!
  private weak var locationDelegate: CLLocationManagerDelegate?
  
  func methodQueue() -> DispatchQueue {
    return DispatchQueue.main
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  @objc(locationUpdate)
  func locationUpdate() -> Void {
    
    locationManager.requestAlwaysAuthorization()
    locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
    locationManager.startUpdatingLocation()
    locationManager.allowsBackgroundLocationUpdates = true
    locationManager.pausesLocationUpdatesAutomatically = false
    locationDelegate = locationManager.delegate
    locationManager.delegate = self
  }
  
  
  
  private func requestAuthorization(completionHandler: @escaping (_ success: Bool) -> ()) {
    // Request Authorization
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (success, error) in
      if let error = error {
        print("Request Authorization Failed (\(error), \(error.localizedDescription))")
      }
      
      completionHandler(success)
    }
  }
  
  func scheduleLocalNotification(_ longi: Double, _ lati: Double, _ alti: Double) {
    // Create Notification Content
    let notificationContent = UNMutableNotificationContent()
    
    // Configure Notification Content
    notificationContent.title = "My Notification"
    notificationContent.subtitle = "Location is"
    notificationContent.body = "Longitude: \(longi), Latitude: \(lati), Altitude: \(alti)"
    
    // Add Trigger
    let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
    
    // Create Notification Request
    let notificationRequest = UNNotificationRequest(identifier: "cocoacasts_local_notification", content: notificationContent, trigger: notificationTrigger)
    
    // Add Request to User Notification Center
    UNUserNotificationCenter.current().add(notificationRequest) { (error) in
      if let error = error {
        print("Unable to Add Notification Request (\(error), \(error.localizedDescription))")
      }
    }
  }
  
  @objc(addEvent:location:)
  func addEvent(name: String, location: String) -> Void {
    // Date is ready to use!
    NSLog("%@ %@", name, location)
  }
  
  
  @objc func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    alti = manager.location?.altitude
    lati = manager.location?.coordinate.latitude
    longi = manager.location?.coordinate.longitude
    print(alti)
    NSLog("%@", "\(String(describing: alti))")
    NSLog("%@", "hello")
    UNUserNotificationCenter.current().getNotificationSettings { (notificationSettings) in
      switch notificationSettings.authorizationStatus {
      case .notDetermined:
        self.requestAuthorization(completionHandler: { (success) in
          guard success else { return }
          
          // Schedule Local Notification
        })
      case .authorized:
        self.scheduleLocalNotification(self.longi, self.lati, self.alti)
        print("sent")
      case .denied:
        print("Application Not Allowed to Display Notifications")
      case .provisional:
        print("provisional")
      }
    }
    UNUserNotificationCenter.current().delegate = self
  }
  
  
  
  func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
      }
}
