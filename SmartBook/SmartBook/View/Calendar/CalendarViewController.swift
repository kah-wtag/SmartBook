//
//  CalendarViewController.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 5/8/25.
//

import UIKit

final class CalendarViewController: UIViewController {
    
    private let appointmentListVM = AppointmentListViewModel()
    private let calendarView = UICalendarView()
    private let scheduleTableView = UITableView()
    
    private lazy var viewModel = CalendarViewModel(
        appointmentListVM: appointmentListVM
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        setupCalendar()
        setupTableView()
        loadAppointmentList()
    }
    
    private func loadAppointmentList() {
        appointmentListVM.loadAppointments { [weak self] in
            guard let self else { return }
            self.scheduleTableView.reloadData()
            self.calendarView.reloadDecorations(
                forDateComponents: self.viewModel.allUpcomingDateComponents(),
                animated: true
            )
        }
    }
    
    private func setupCalendar() {
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        calendarView.calendar = .current
        calendarView.locale = .current
        calendarView.backgroundColor = .background
        calendarView.layer.cornerRadius = 20
        calendarView.delegate = self
        view.addSubview(calendarView)
        let selection = UICalendarSelectionSingleDate(delegate: self)
        calendarView.selectionBehavior = selection
        NSLayoutConstraint.activate([
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            calendarView.heightAnchor.constraint(equalToConstant: 450)
        ])
    }
    
    private func setupTableView() {
        scheduleTableView.translatesAutoresizingMaskIntoConstraints = false
        scheduleTableView.dataSource = self
        scheduleTableView.delegate = self
        scheduleTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        scheduleTableView.backgroundColor = .background
        scheduleTableView.bounces = false
        view.addSubview(scheduleTableView)
        NSLayoutConstraint.activate([
            scheduleTableView.topAnchor.constraint(
                equalTo: calendarView.bottomAnchor
            ),
            scheduleTableView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),
            scheduleTableView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),
            scheduleTableView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor
            )
        ])
        addTableViewHeaderLine()
    }
    
    private func addTableViewHeaderLine() {
        let headerLine = UIView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: scheduleTableView.frame.width,
                height: 1
            )
        )
        headerLine.backgroundColor = .separator
        scheduleTableView.tableHeaderView = headerLine
    }
}

extension CalendarViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfUpcomingAppointments
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = viewModel.displayText(for: indexPath.row)
        cell.textLabel?.setFontSize(.regular, weight: .regular, dynamic: true)
        cell.backgroundColor = .secondaryBackground
        cell.separatorInset = .zero
        
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
            return .default(color: .secondaryText, size: .small)
        }
        return nil
    }
}

extension CalendarViewController: UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        scheduleTableView.reloadData()
    }
}

extension CalendarViewController {
    func dateSelection(_ calendar: UICalendarView, didDeselectDate dateComponents: DateComponents) {
        scheduleTableView.reloadData()
    }
}
