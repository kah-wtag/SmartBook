//
//  CalendarViewController.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 5/8/25.
//

import UIKit

class CalendarViewController: UIViewController {
    
    private let appointmentListVM = AppointmentListViewModel()
    private lazy var viewModel = CalendarViewModel(
        appointmentListVM: appointmentListVM
    )
    
    private let calendarView = UICalendarView()
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        setupCalendar()
        setupTableView()
        loadAppointments()
    }
    
    private func loadAppointments() {
        appointmentListVM.loadAppointments { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
            self.calendarView.reloadDecorations(
                forDateComponents: self.generateAllDateComponents(), animated: true
            )
        }
    }
    
    private func generateAllDateComponents() -> [DateComponents] {
        let calendar = Calendar.current
        return viewModel.upcomingAppointments.compactMap { appointment in
            guard let date = ISO8601DateFormatter().date(from: appointment.date ?? "") else { return nil }
            return calendar.dateComponents([.year, .month, .day], from: date)
        }
    }
    
    private func setupCalendar() {
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        calendarView.calendar = .current
        calendarView.locale = .current
        calendarView.backgroundColor = .background
        calendarView.layer.cornerRadius = 20
        view.addSubview(calendarView)
        let selection = UICalendarSelectionSingleDate(delegate: self)
        calendarView.selectionBehavior = selection
        NSLayoutConstraint.activate([
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            calendarView.heightAnchor.constraint(equalToConstant: 400)
        ])
        UILabel.appearance(whenContainedInInstancesOf: [UICalendarView.self]).font = UIFont.of(size: .regular, weight: .regular)
    }
    
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .background
        tableView.bounces = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: calendarView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension CalendarViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.upcomingAppointments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let appointment = viewModel.upcomingAppointments[indexPath.row]
        
        cell.backgroundColor = .secondaryBackground
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        
        cell.separatorInset = UIEdgeInsets.zero
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = "\(formatter.string(from: ISO8601DateFormatter().date(from: appointment.date!)!)) - \(appointment.providerName ?? "Unknown")\nTime: \(appointment.time ?? "N/A")"
        cell.textLabel?.setFontSize(.regular, weight: .regular, dynamic: true)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension CalendarViewController: UICalendarViewDelegate {
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        guard let date = dateComponents.date else { return nil }
        
        if viewModel.hasAppointment(on: date) {
            return .default(color: .secondaryText, size: .large)
        }
        return nil
    }
}

extension CalendarViewController: UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        tableView.reloadData()
    }
}

extension CalendarViewController {
    func dateSelection(_ calendar: UICalendarView, didDeselectDate dateComponents: DateComponents) {
        tableView.reloadData()
    }
}
