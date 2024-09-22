//
//  HandleOrdersView.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 13/2/23.
//

import SwiftUI

public struct HandleOrdersView: View {
    @ObservedObject var viewModel: HandleOrderViewModel
    @State var searchType: SearchType = .email
    @State var searchText: String = ""
    @State var scrollOffset: CGFloat = 0
    @State var hideHeader: Bool = false
    @FocusState private var isFocused: Bool
    
    public var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Text("orders_management_header_title")
                .font(.futura(24))
                .bold()
                .foregroundStyle(StyleConstants.bookalooGradient)
                .frame(height: 100)
            
            ExpandableView {
                HStack {
                    Spacer()
                    Button {
                        viewModel.getAll()
                        isFocused = false
                    } label: {
                        Text("search_all")
                            .font(.futura(12))
                    }//: Button search all
                    .buttonStyle(.bookalooStyle())
                    Spacer()
                }
            } content: {
                VStack(spacing: 4) {
                    VStack(spacing: 4) {
                        Picker(selection: $searchType) {
                            ForEach(SearchType.allCases) { searchType in
                                Text(searchType.rawValue)
                                    .font(.futura(12))
                                    .bold()
                                    .opacity(0.7)
                            }
                        } label: {
                            Text("")
                        }//: Picker
                        .foregroundColor(.accentColor)
                        
                        HStack {
                            BookalooTextfield(textfieldText: $searchText, orientation: .vertical(.searchable)) {
                                viewModel.cleanSearchOrders()
                                viewModel.ordersEmpty.toggle()
                            }
                            .onChange(of: searchText) { _ in
                                viewModel.ordersEmpty = false
                            }
                            .focused($isFocused)
                            
                            Button {
                                isFocused = false
                                switch searchType {
                                case .email:
                                    viewModel.getOrders(by: searchText)
                                case .id:
                                    viewModel.getOrder(by: searchText)
                                }
                            } label: {
                                Text("search")
                                    .font(.futura(12))
                            }//: Button search
                            .buttonStyle(.bookalooStyle())
                        }//: HStack
                    }//: HStack
                    //                        .padding(.horizontal, 16)
                }//: VStack
            }
            .padding()
            .frame(height: hideHeader ? .zero : nil)
            .opacity(hideHeader ? 0 : 1)
            
            
            if viewModel.ordersEmpty, !searchText.isEmpty {
                Text(String(format: NSLocalizedString("no_orders_for", comment: ""), searchText))
                    .emptyMessageModifier()
            } else if !viewModel.searchOrders.isEmpty {
                ObservableScrollView(scrollOffset: $scrollOffset) {
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
                }//: ScrollView
                .scrollIndicators(.hidden)
                .onChange(of: scrollOffset) { scrollOfset in
                    if scrollOfset > 0 {
                        withAnimation(.easeIn(duration: 0.5), {
                            hideHeader = true
                        })
                    } else if scrollOfset < 0 {
                        withAnimation(.easeIn(duration: 0.5), {
                            hideHeader = false
                        })
                    }
                }//: OnChange scroll
            }//: If there are results
            Spacer()
        }//: VStack
        .onTapGesture {
            isFocused = false
        }
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
