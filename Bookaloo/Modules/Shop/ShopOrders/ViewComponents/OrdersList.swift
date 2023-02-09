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
            Text("There are no orders **\(status.rawValue.capitalized)**")
                .emptyMessageModifier()
        } else {
            List {
                ForEach($orders) { order in
                    VStack(alignment: .leading) {
                        if let id = order.id {
                            HStack(alignment: .top) {
                                Text("Order number:")
                                    .bold()
                                Spacer()
                                Text(id)
                            }//:Hstack
                            .font(StyleConstants.bookalooFont)
                        }
                        
                        if let date = order.date.wrappedValue,
                           let dateString = date.formatted(date: .abbreviated, time: .omitted) {
                            HStack(alignment: .top) {
                                Text("Date:")
                                    .bold()
                                Text(dateString)
                            }//:Hstack
                            .font(StyleConstants.bookalooFont)
                        }
                        
                        ExpandableView {
                            Text(order.status.wrappedValue?.rawValue.capitalized ?? "")
                                .font(StyleConstants.bookalooFont)
                                .bold()
                                .foregroundStyle(StyleConstants.bookalooGradient)
                        } content: {
                            PurchasedBooksList(books: order.books.wrappedValue)
                        }
                    }//: VStack
                }//: ForEach
            }//: List
        }//: Orders list is not empty
    }
}

struct OrdersList_Previews: PreviewProvider {
    static var previews: some View {
        OrdersList(status: .constant(.inProgress),orders: .constant([.test]))
    }
}
