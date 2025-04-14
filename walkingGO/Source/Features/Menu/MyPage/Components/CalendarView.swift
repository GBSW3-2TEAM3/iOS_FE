//
//  CalendarView.swift
//  walkingGO
//
//  Created by 박성민 on 4/11/25.
//

import SwiftUI

struct CalendarView: View {
    @State private var selectedDate = Date()
    @State private var dateValues: [Int: Double] = [:]
    
    let calendar = Calendar.current
    
    var currentMonth: [Date] {
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: selectedDate))!
        let range = calendar.range(of: .day, in: .month, for: startOfMonth)!
        
        let firstDayOfMonth = calendar.component(.weekday, from: startOfMonth)
        let blankDays = firstDayOfMonth - 1
        
        var dates: [Date] = range.compactMap { day in
            calendar.date(byAdding: .day, value: day - 1, to: startOfMonth)
        }
        
        for _ in 0..<blankDays {
            dates.insert(Date.distantPast, at: 0)
        }
        
        return dates
    }
    
    func previousMonth() {
        if let previousMonthDate = calendar.date(byAdding: .month, value: -1, to: selectedDate) {
            selectedDate = previousMonthDate
        }
    }
    
    func nextMonth() {
        if let nextMonthDate = calendar.date(byAdding: .month, value: 1, to: selectedDate) {
            selectedDate = nextMonthDate
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Button(action: previousMonth) {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .frame(width:10,height: 20)
                        .foregroundStyle(.black)
                }
                Spacer()
                Text("\(calendar.component(.month, from: selectedDate))월")
                    .font(AppFont.PretendardSemiBold(size: 18))
                    .padding()
                Spacer()
                Button(action: nextMonth) {
                    Image(systemName: "chevron.right")
                        .resizable()
                        .frame(width:10,height: 20)
                        .foregroundStyle(.black)
                }
            }
            .padding()
            
            HStack {
                ForEach(["일", "월", "화", "수", "목", "금", "토"], id: \.self) { day in
                    Text(day)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.black)
                }
            }
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 10) {
                ForEach(currentMonth, id: \.self) { date in
                    if date == Date.distantPast {
                        Text("")
                            
                    } else {
                        let day = calendar.component(.day, from: date)
                        let value = dateValues[day] ?? 0
                        
                        VStack {
                            Text("\(day)")
                                .font(AppFont.PretendardMedium(size: 14))
                                .frame(maxWidth: .infinity)
                                .background(Color.clear)
                                .foregroundColor(.black)
                            
                            Text(String(format: "%.1f", value))
                                    .font(.caption)
                                    .foregroundColor(value != 0 ? .red : .clear)
                                    .frame(height: 14)
                        }
                        .frame(minHeight: 60)
                    }
                }
            }
        }
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .onAppear {
            dateValues = (1...31).reduce(into: [Int: Double]()) { result, day in
                result[day] = Double(day * 10)
            }
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
