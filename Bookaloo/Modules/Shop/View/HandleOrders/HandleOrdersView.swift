//
//  HandleOrdersView.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 13/2/23.
//

import SwiftUI

struct HandleOrdersView: View {
    @EnvironmentObject var viewModel: ShopViewModel
    @State var searchType: SearchType = .email
    @State var searchText: String = ""
    
    var body: some View {
        BaseViewContent(viewModel: viewModel) {
            VStack {
                VStack (spacing: 16) {
                    HStack(spacing: 16) {
                        Picker(selection: $searchType) {
                            ForEach(SearchType.allCases) { searchType in
                                Text(searchType.rawValue)
                                    .font(.futura(14))
                                    .bold()
                                    .opacity(0.7)
                            }
                        } label: {
                            Text("")
                        }//: Picker
                        .foregroundColor(.accentColor)
                        
                        BookalooTextfield(textfieldText: $searchText, orientation: .vertical(.searchable)) {
                            viewModel.cleanSearchOrders()
                            viewModel.ordersEmpty.toggle()
                        }
                        .onChange(of: searchText) { _ in
                            viewModel.ordersEmpty = false
                        }
                    }//: HStack
                    .padding(.horizontal, 16)
                    
                    Button {
                        switch searchType {
                        case .email:
                            viewModel.getOrders(by: searchText)
                        case .id:
                            viewModel.getOrder(by: searchText)
                        }
                    } label: {
                        Text("Search")
                    }//: Button search
                    .buttonStyle(.bookalooStyle)
                    
                }//: VStack
                List {
                    if viewModel.ordersEmpty {
                        Text("There are no orders for\n*\(searchText)*")
                            .emptyMessageModifier()
                    } else {
                        ForEach(viewModel.searchOrders) { order in
                            HandleOrderCellView(
                                email: order.email,
                                orderNumber: order.id,
                                date: order.date,
                                books: order.books
                            )
                        }//: ForEach order
                    }
                }//: List
                .scrollContentBackground(.hidden)
            }//: VStack
        }//: BaseViewContent
        .toolbar(.hidden, for: .tabBar)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Text("Bookaloo")
                    .font(.futura(24))
                    .bold()
                    .foregroundStyle(StyleConstants.bookalooGradient)
            }//: ToolbarItem - Title
        }//: Toolbar
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct HandleOrdersView_Previews: PreviewProvider {
    static var previews: some View {
        HandleOrdersView()
            .environmentObject(ModuleDependencies().shopsViewModel())
    }
}
