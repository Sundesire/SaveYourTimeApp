//
//  CreateNotification.swift
//  SimpleYourTime
//
//  Created by Иван Бабушкин on 05.02.2020.
//  Copyright © 2020 Ivan Babushkin. All rights reserved.
//

import Foundation
import UserNotifications

protocol CreateNotificationProtocol {
    func createNotification(task: String, dateFrom: Date)
}

class CreateNotification: CreateNotificationProtocol {
    func createNotification(task: String, dateFrom: Date) {
        let notificationCenter = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = "Напоминание!"
        content.subtitle = "Напоминание о задаче"
        content.body = "Пора выполнить задачу: \(task)"
        content.sound = UNNotificationSound.default
        content.threadIdentifier = "local-notification temp"
        content.badge = 1
        
        let date = dateFrom
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: "content", content: content, trigger: trigger)
        
        notificationCenter.add(request) { (error) in
            if error != nil {
                print(error?.localizedDescription as Any)
            }
        }
    }
}
