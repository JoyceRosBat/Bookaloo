//
//  ShopOrdersView.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 12/2/23.
//

import SwiftUI

public struct ShopOrdersView: View {
    @ObservedObject var viewModel: ShopOrdersViewModel
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
            }//: VStack
        }//: BaseViewContent
        .toolbar(.hidden, for: .tabBar)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                BookalooToolbarTitle()
            }//: ToolbarItem - Title
        }//: Toolbar
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.getOrders()
        }
        .toolbarBackground(
            Color.backgroundColor,
            for: .navigationBar
        )
        .toolbarBackground(
            .visible,
            for: .navigationBar
        )
        .toolbarBackground(
            Color.backgroundColor,
            for: .tabBar
        )
        .toolbarBackground(
            .visible,
            for: .tabBar
        )
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct ShopOrdersView_Previews: PreviewProvider {
    static var previews: some View {
        ShopOrdersView(viewModel: ModuleDependencies().resolve())
    }
}
