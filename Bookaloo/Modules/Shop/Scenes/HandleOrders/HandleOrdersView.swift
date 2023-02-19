//
//  HandleOrdersView.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 13/2/23.
//

import SwiftUI

struct HandleOrdersView: View {
    @StateObject var viewModel: HandleOrderViewModel
    @State var searchType: SearchType = .email
    @State var searchText: String = ""
    
    var body: some View {
        BaseViewContent(viewModel: viewModel) {
            VStack(alignment: .center, spacing: 0) {
                Text("Orders Management")
                    .font(.futura(32))
                    .bold()
                    .foregroundStyle(StyleConstants.bookalooGradient)
                    .frame(height: 100)
                
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
                
                if viewModel.ordersEmpty, !searchText.isEmpty {
                    Text("There are no orders for\n*\(searchText)*")
                        .emptyMessageModifier()
                } else if !viewModel.searchOrders.isEmpty {
                    List {
                        ForEach(viewModel.searchOrders) { order in
                            HandleOrderCellView(
                                email: order.email,
                                orderNumber: order.id,
                                date: order.date,
                                books: order.books) { status in
                                    viewModel.modify(
                                        order.id,
                                        status: status
                                    )
                                }
                        }//: ForEach order
                    }//: List
                    .scrollContentBackground(.hidden)
                    .scrollIndicators(.hidden)
                }//: If there are results
                Spacer()
            }//: VStack
        }//: BaseViewContent
        .navigationBarTitleDisplayMode(.inline)
        .padding(.bottom)
    }
}

struct HandleOrdersView_Previews: PreviewProvider {
    static var previews: some View {
        HandleOrdersView(viewModel: ModuleDependencies().resolve())
            .environmentObject(ModuleDependencies().resolve()as ShopViewModel)
    }
}
