//
//  HandleOrderCellView.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 14/2/23.
//

import SwiftUI

struct HandleOrderCellView: View {
    var email: String
    var orderNumber: String?
    var date: Date?
    @State var books: [Int]?
    @State var statusSelected: Status = .received
    var modifyAction: ((Status) -> Void)?
    
    var body: some View {
        VStack(alignment: .center, spacing: 24) {
            VStack (alignment: .leading) {
                Text(email)
                    .font(.futura(14))
                    .bold()
                    .opacity(0.6)
                
                if let orderNumber {
                    Text(orderNumber)
                        .font(.futura(14))
                        .bold()
                        .opacity(0.6)
                }
                
                if let date {
                    Text(date.formatted(date: .abbreviated, time: .omitted))
                        .font(.futura(14))
                        .bold()
                        .opacity(0.7)
                }
                
                Menu {
                    Picker(selection: $statusSelected) {
                        ForEach(Status.allCases) { status in
                            Text(status.rawValue.capitalized)
                                .font(.futura(14))
                                .bold()
                                .opacity(0.7)
                        }
                    } label: {
                        
                    }//: Picker
                    .foregroundColor(.accentColor)
                    .onChange(of: statusSelected) { newValue in
                        modifyAction?(statusSelected)
                    }
                } label: {
                    Label(statusSelected.rawValue.capitalized, systemImage: .arrowDownLine)
                        .font(.futura(14))
                        .bold()
                        .opacity(0.7)
                }//: Menu picker
                
                
                PurchasedBooksList(books: books)
            }//: VStack
        }//: VStack
        .padding()
    }
}

struct HandleOrderCellView_Previews: PreviewProvider {
    static var previews: some View {
        HandleOrderCellView(
            email: "joyce.admin@bookaloo.com",
            orderNumber: "AFFS-55JNJ-5N8MSL-WBSUY",
            date: .now,
            books: [1,2,4,2,3,1,5]
        )
    }
}
