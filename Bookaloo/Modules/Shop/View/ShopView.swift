//
//  ShopView.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 1/2/23.
//

import SwiftUI

struct ShopView: View {
    @ObservedObject var viewModel: ShopViewModel
    
    var body: some View {
        BaseViewContent(viewModel: viewModel) {
            VStack {
                Text("Shop")
            }
        }
    }
}

struct ShopView_Previews: PreviewProvider {
    static var previews: some View {
        ModuleDependencies().shopView()
    }
}