//
//  OrdersList.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 12/2/23.
//

import SwiftUI

struct OrdersList: View {
    @Binding var status: PurchaseStatus
    @Binding var orders: [Order]
    
    var body: some View {
        if orders.isEmpty {
            Text(String(format: NSLocalizedString("no_orders", comment: ""), status.rawValue.capitalized))
                .emptyMessageModifier()
        } else {
            List {
                ForEach($orders) { order in
                    VStack(alignment: .leading) {
                        if let id = order.id {
                            HStack(alignment: .top) {
                                Text("order_number_title")
                                    .bold()
                                    .font(.futura(12))
                                Spacer()
                                Text(id)
                                    .font(.futura(12))
                                    .bold()
                                    .opacity(0.7)
                                    .foregroundColor(.accentColor)
                            }//:Hstack
                        }
                        
                        if let date = order.date.wrappedValue,
                           let dateString = date.formatted(date: .abbreviated, time: .omitted) {
                            HStack(alignment: .top) {
                                Text("date_title")
                                    .bold()
                                    .font(.futura(12))
                                Spacer()
                                Text(dateString)
                                    .font(.futura(12))
                                    .bold()
                                    .opacity(0.7)
                                    .foregroundColor(.accentColor)
                            }//:Hstack
                        }
                        
                        ExpandableView {
                            Text(order.status.wrappedValue?.rawValue.capitalized ?? "")
                                .font(StyleConstants.bookalooFont)
                                .bold()
                                .font(.futura(12))
                                .foregroundStyle(StyleConstants.bookalooGradient)
                        } content: {
                            PurchasedBooksList(books: order.books.wrappedValue)
                        }
                    }//: VStack
                }//: ForEach
            }//: List
            .scrollIndicators(.hidden)
        }//: Orders list is not empty
    }
}

struct OrdersList_Previews: PreviewProvider {
    static var previews: some View {
        OrdersList(status: .constant(.inProgress),orders: .constant([.test]))
    }
}
