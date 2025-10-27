//
//  SmartBookingService.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 1/10/25.
//

import UIKit

final class SmartBookingService {
    
    static let shared = SmartBookingService()
    
    private let baseURL = "https://bookinggggggg.free.beeceptor.com/data"
    private let appointmentURL = "https://bookinggggggg.free.beeceptor.com/data1"
    
    private init() { }
    
    func fetchServices(completion: @escaping ([SmartService]?, Error?) -> Void) {
        guard let url = URL(string: baseURL) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data, error == nil else {
                DispatchQueue.main.async { completion(nil, error) }
                return
            }
            do {
                let response = try JSONDecoder().decode(SmartServices.self, from: data)
                let services = response.services ?? []
                DispatchQueue.main.async { completion(services, nil) }
            } catch {
                print("Decode error:", error)
                DispatchQueue.main.async { completion(nil, error) }
            }
        }.resume()
    }
    
    func fetchFields(serviceID: Int, completion: @escaping ([SmartServiceField]?, Error?) -> Void) {
        fetchServices { services, error in
            guard let services else {
                completion(nil, error)
                return
            }
            let fields = services.first(where: { $0.serviceID == serviceID })?.fields ?? []
            completion(fields, nil)
        }
    }
    
    func fetchProviders(fieldTypeID: Int, completion: @escaping ([ServiceProvider]?, Error?) -> Void) {
        fetchServices { services, error in
            guard let services else {
                completion(nil, error)
                return
            }
            let allFields = services.flatMap { $0.fields ?? [] }
            let providers = allFields.first(where: { $0.fieldTypeID == fieldTypeID })?.serviceProvider ?? []
            completion(providers, nil)
        }
    }
    
    func fetchAppointments(completion: @escaping ([Appointment]?, Error?) -> Void) {
        guard let url = URL(string: appointmentURL) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data, error == nil else {
                DispatchQueue.main.async { completion(nil, error) }
                return
            }
            do {
                let response = try JSONDecoder().decode(AppointmentList.self, from: data)
                let appointments = response.appointments
                DispatchQueue.main.async { completion(appointments, nil) }
            } catch {
                print("Decode error:", error)
                DispatchQueue.main.async { completion(nil, error) }
            }
        }.resume()
    }
}
