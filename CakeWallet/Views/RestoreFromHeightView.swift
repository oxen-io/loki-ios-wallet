import UIKit
import FlexLayout
import SwiftSoup

// The date when loki was forked from monero
private let minDate: Date? = {
    var minDateComponents = DateComponents()
    minDateComponents.year = 2018
    minDateComponents.month = 5
    minDateComponents.day = 3
    return Calendar.current.date(from: minDateComponents)
}()

private let dates: [Date: UInt64] = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM"

    // Loki: These are just estimated block heights, not actual ones
    // The estimates here are the block heights at the start of each month
    return [
        formatter.date(from: "2018-05")!: 0,
        formatter.date(from: "2018-06")!: 21166,
        formatter.date(from: "2018-07")!: 42671,
        formatter.date(from: "2018-08")!: 64925,
        formatter.date(from: "2018-09")!: 87178,
        formatter.date(from: "2018-10")!: 108687,
        formatter.date(from: "2018-11")!: 130933,
        formatter.date(from: "2018-12")!: 152455,
        formatter.date(from: "2019-01")!: 174685,
        formatter.date(from: "2019-02")!: 196908,
        formatter.date(from: "2019-03")!: 217021,
        formatter.date(from: "2019-04")!: 239351,
        formatter.date(from: "2019-05")!: 260947,
        formatter.date(from: "2019-06")!: 283215
    ]
}()

extension Date {
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }
    
    func previousMonth() -> Date {
        return Calendar.current.date(byAdding: .month, value: -1, to: self)!
    }
}


func getHeight(of date: Date, calendar: Calendar = Calendar.current) -> UInt64 {
    guard
        let minDate = minDate,
        minDate < date else { return 0 }
    var startDate = date.startOfMonth()
    let endDate = calendar.date(byAdding: .month, value: 1, to: startDate)!
    var startHeight: UInt64 = 0
    var endHeight: UInt64 = 0
    
    if let _endHeight = dates[endDate] {
        endHeight = _endHeight
    } else {
        let datesArray = Array(dates.keys).sorted(by: { $1 > $0 })
        let lastMonth = datesArray[datesArray.count - 1]
        endHeight = dates[lastMonth]!
        
        let preLastMonth = datesArray[datesArray.count - 2]
        startHeight = dates[preLastMonth]!
        startDate = lastMonth
    }
    
    if (startHeight == 0) {
        startHeight = dates[startDate]!
    }
    
    let diff = endHeight - startHeight
    let days = calendar.range(of: .day, in: .month, for: date)!
    let heightPerDay = diff / UInt64(days.count)
    let countOfDays  = calendar.dateComponents([.day], from: startDate, to: date).day!
    let height = startHeight + UInt64(countOfDays) * heightPerDay
    
    return height
}

func getHeight(from date: Date, handler: @escaping (UInt64) -> Void) {
    DispatchQueue.global(qos: .background).async {
        let height = getHeight(of: date)
        handler(height)
//        let timestamp = Int(date.timeIntervalSince1970)
//        var url =  URLComponents(string: "https://chainradar.com/xmr/blocks")!
//        url.queryItems = [
//            URLQueryItem(name: "filter[timestamp_greater]", value: "\(timestamp)")
//        ]
//        var request = URLRequest(url: url.url!)
//        request.httpMethod = "GET"
//
//        let connection = URLSession.shared.dataTask(with: request) { data, response, error in
//            do {
//                if let error = error {
//                    print(error)
//                    handler(0)
//                    return
//                }
//
//                guard
//                    let data = data,
//                    let html = String(data: data, encoding: String.Encoding.utf8),
//                    let doc: Document = try? SwiftSoup.parse(html)  else {
//                        handler(0)
//                        return
//                }
//
//                if
//                    let row: Element = try  doc.getElementById("blocks-tbody")!.children().first(),
//                    let heightStr = try row.children().first()?.text(),
//                    let height = UInt64(heightStr) {
//                    handler(height)
//                } else {
//                    handler(0)
//                }
//            } catch {
//                print(error)
//                handler(0)
//            }
//        }
//
//        connection.resume()
    }
}

final class RestoreFromHeightView: BaseFlexView {
    let restoreHeightTextField: UITextField
    let dateTextField: UITextField
    let datePicker: UIDatePicker
    var restoreHeight: UInt64 {
        var height: UInt64 = 0
        if
            let heightStr = restoreHeightTextField.text,
            let _height = UInt64(heightStr.replacingOccurrences(of: ",", with: "")) {
            height = _height
        }
        return height
    }
    
    
    required init() {
        restoreHeightTextField = FloatingLabelTextField(placeholder: NSLocalizedString("restore_height", comment: ""), isOptional: true)
        dateTextField = FloatingLabelTextField(placeholder: NSLocalizedString("restore_from_date", comment: ""), isOptional: true)
        datePicker = UIDatePicker()
        super.init()
    }
    
    override func configureView() {
        super.configureView()
        backgroundColor = .clear
        restoreHeightTextField.keyboardType = .numberPad
        datePicker.datePickerMode = .date
        datePicker.locale = Locale.current
        dateTextField.inputView = datePicker
        datePicker.minimumDate = minDate
        datePicker.maximumDate = Date()
        datePicker.addTarget(self, action: #selector(handleDatePicker), for: .valueChanged)
        datePicker.addTarget(self, action: #selector(onDateChange(_:)), for: .valueChanged)
        addSubview(restoreHeightTextField)
        addSubview(dateTextField)
    }
    
    @objc
    private func onDateChange(_ datePicker: UIDatePicker) {
        let date = datePicker.date
        
        getHeight(from: date) { [weak self] height in
            DispatchQueue.main.async {
                self?.restoreHeightTextField.text = "\(height)"
            }
        }
    }
    
    @objc
    private func handleDatePicker() {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = Locale.current.regionCode?.lowercased() == "us" ? "MMMM d, yyyy" : "d MMMM, yyyy" //fixme hardcoded regionCode value
        dateTextField.text = dateFormatter.string(from: datePicker.date)
    }
    
    override func configureConstraints() {
        rootFlexContainer.flex.backgroundColor(.clear).define { flex in
            flex.addItem(restoreHeightTextField).marginTop(10).height(50)
            flex.addItem(dateTextField).marginTop(10).height(50)
        }
    }
}
