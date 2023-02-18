//
//  ShopView.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 1/2/23.
//

import SwiftUI

struct ShopView: View {
    var dependencies: ShopDependenciesResolver
    @EnvironmentObject var booksViewModel: BooksViewModel
    @EnvironmentObject var viewModel: ShopViewModel
    
    var body: some View {
        BaseViewContent(viewModel: viewModel) {
            if viewModel.booksToShop.isEmpty {
                Text("**There are no books ordered yet.**\n\nSelect a book and press *Shop* button to order one.")
                    .emptyMessageModifier()
            } else {
                VStack {
                    List {
                        ForEach(viewModel.booksToShop.sorted(by: >), id: \.key) { bookId, quantity in
                            if let book = booksViewModel.books.first(where: { $0.id == bookId }) {
                                BookShopCell(book: book, bookId: bookId, quantity: quantity, showAlert: $viewModel.showRemoveBookAlert)
                            }//: If book found...
                        }//: ForEach
                    }//: List
                    .scrollContentBackground(.hidden)
                    .scrollIndicators(.hidden)
                    
                    HStack {
                        Button {
                            viewModel.finishShopAlert = true
                        } label: {
                            Label("Shop", systemImage: "cart")
                        }
                        .buttonStyle(.bookalooStyle)
                        .frame(width: UIScreen.main.bounds.width * 0.8)
                        .padding()
                    }//: HStack
                }//: VStack
            }//: If books to shop is not empty
        }//: BaseViewContent
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Text("Bookaloo")
                    .font(.futura(24))
                    .bold()
                    .foregroundStyle(StyleConstants.bookalooGradient)
            }//: ToolbarItem - Title
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                HStack {
                    NavigationLink {
                        dependencies.shopOrdersView()
                    } label: {
                        Image(systemName: "shippingbox.fill")
                    }
                    
                    if viewModel.isAdmin {
                        NavigationLink {
                            dependencies.handleOdersView()
                        } label: {
                            Image(systemName: "tray.and.arrow.down.fill")
                        }
                    }
                }
            }//: ToolbarItemGroup
        }//: Toolbar
        .overlay {
            if viewModel.showRemoveBookAlert {
                removeConfirmationPopup
            }
            if viewModel.finishShopAlert {
                finishShopPopup
            }
            if viewModel.shopCompleteAlert {
                shopCompletePopup
            }
        }//: Overlay - Show remove book confirmation popup
        .toolbar((viewModel.showRemoveBookAlert ||
                  viewModel.showError ||
                  viewModel.finishShopAlert ||
                  viewModel.shopCompleteAlert) ? .hidden : .visible, for: .tabBar)
        .navigationBarTitleDisplayMode(.inline)
    }
}

extension ShopView {
    @ViewBuilder
    var removeConfirmationPopup: some View {
        PopupView(
            showAlert: $viewModel.showRemoveBookAlert,
            title: "The book will be removed from the list") {
                Text("Do you want to remove it?")
            } buttons: {
                Button {
                    viewModel.bookSelected = nil
                    viewModel.showRemoveBookAlert.toggle()
                } label: {
                    Text("Cancel")
                }
                Button {
                    withAnimation(.easeInOut) {
                        viewModel.booksToShop.forEach { (book, _) in
                            booksViewModel.report.ordered?.append(book)
                        }
                        viewModel.removeBookSelected()
                    }
                    viewModel.showRemoveBookAlert.toggle()
                } label: {
                    Text("Accept")
                }
            }
    }
    
    @ViewBuilder
    var finishShopPopup: some View {
        PopupView(
            showAlert: $viewModel.finishShopAlert,
            title: "Finish shop") {
                Text("Do you want to finish shopping?")
            } buttons: {
                Button {
                    viewModel.finishShopAlert.toggle()
                } label: {
                    Text("Cancel")
                }
                Button {
                    withAnimation(.easeInOut) {
                        viewModel.finishShop()
                    }
                    viewModel.finishShopAlert.toggle()
                } label: {
                    Text("Accept")
                }
            }
    }
    
    @ViewBuilder
    var shopCompletePopup: some View {
        PopupView(
            showAlert: $viewModel.shopCompleteAlert,
            title: "Your order is complete") {
                Text("Your oder number:\n**\(viewModel.pendingOrder?.id ?? "")**\n\nYou can check all your orders on the button ") +
                Text(Image(systemName: "shippingbox.fill")) +
                Text(" at the top")
            } buttons: {
                Button {
                    viewModel.shopCompleteAlert.toggle()
                } label: {
                    Text("Accept")
                }
            }
    }
}

struct ShopView_Previews: PreviewProvider {
    static var previews: some View {
        ModuleDependencies().shopView()
            .environmentObject(ModuleDependencies().booksViewModel())
    }
}
