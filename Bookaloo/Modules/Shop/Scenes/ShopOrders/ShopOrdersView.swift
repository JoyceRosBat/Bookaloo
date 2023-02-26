//
//  ShopOrdersView.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 12/2/23.
//

import SwiftUI

public struct ShopOrdersView: View {
    @StateObject var viewModel: ShopOrdersViewModel
    @State var statusSelected: PurchaseStatus = .inProgress
    
//    init(){
//        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color.accentColor)
//    }
    
    public var body: some View {
        BaseViewContent(viewModel: viewModel) {
            VStack {
                Picker("order_status", selection: $statusSelected) {
                    ForEach(viewModel.ordersStatus, id: \.self) { status in
                        Text(status.rawValue.capitalized)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.leading, 20)
                .padding(.trailing, 20)
                
                switch statusSelected {
                case .inProgress:
                    OrdersList(status: $statusSelected, orders: $viewModel.inProgressList)
                case .delivered:
                    OrdersList(status: $statusSelected, orders: $viewModel.deliveredList)
                case .cancelled:
                    OrdersList(status: $statusSelected, orders: $viewModel.cancelledList)
                }
                
                Spacer()
            }
            .toolbar(.hidden, for: .tabBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    BookalooToolbarTitle()
                }//: ToolbarItem - Title
            }//: Toolbar
        }//: BaseViewContent
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.getOrders()
        }
    }
}

struct ShopOrdersView_Previews: PreviewProvider {
    static var previews: some View {
        ShopOrdersView(viewModel: ModuleDependencies().resolve())
    }
}
