//
//  ShopView.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 1/2/23.
//

import SwiftUI

public struct ShopView: View {
    var dependencies: ShopDependenciesResolver
    @EnvironmentObject var booksViewModel: BooksViewModel
    @EnvironmentObject var viewModel: ShopViewModel
    var shopOrdersView: ShopOrdersView {
        dependencies.resolve()
    }
    
    public var body: some View {
        BaseViewContent(viewModel: viewModel) {
            if viewModel.booksToShop.isEmpty {
                Text("orders_emtpy_list")
                    .emptyMessageModifier()
            } else {
                VStack {
                    List {
                        ForEach(viewModel.booksToShop.sorted(by: >), id: \.key) { bookId, quantity in
                            if let book = booksViewModel.books.first(where: { $0.apiID == bookId }) {
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
                            Label("shop", systemImage: .cart)
                                .font(.futura(12))
                        }
                        .buttonStyle(.bookalooStyle)
//                        .frame(width: UIScreen.main.bounds.width * 0.8)
                        .padding()
                        
                        
                        
                        Text(String(format: NSLocalizedString("total_price_books", comment: ""), viewModel.total, Locale.current.currencySymbol ?? "€"))
                            .font(.futura(12))
                            .bold()
                            .foregroundColor(.green)
                            .opacity(0.7)
                        
                    }//: HStack
                }//: VStack
            }//: If books to shop is not empty
        }//: BaseViewContent
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                BookalooToolbarTitle()
            }//: ToolbarItem - Title
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                HStack {
                    NavigationLink {
                        shopOrdersView
                    } label: {
                        Image(systemName: .shippingBoxFill)
                    }
                }//: HStack
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
        .onAppear {
            calculateTotal()
        }
    }
}

extension ShopView {
    func calculateTotal() {
        viewModel.total = (booksViewModel.books.map { book in
            if viewModel.booksToShop.contains(where: { $0.key == book.apiID }) {
                return (book.price ?? 0) * Double(viewModel.booksToShop[book.apiID] ?? 0)
            }
            return 0
        } as [Double]).reduce(0, +)
    }
    
    var removeConfirmationPopup: some View {
        PopupView(
            showAlert: $viewModel.showRemoveBookAlert,
            title: "remove_book_popup_title") {
                Text("remove_book_popup_message")
            } buttons: {
                Button {
                    viewModel.bookSelected = nil
                    viewModel.showRemoveBookAlert.toggle()
                } label: {
                    Text("cancel")
                }
                Button {
                    withAnimation(.easeInOut) {
                        viewModel.booksToShop.forEach { (book, _) in
                            booksViewModel.report.ordered?.append(book)
                        }
                        viewModel.removeBookSelected()
                    }
                    viewModel.showRemoveBookAlert.toggle()
                    calculateTotal()
                } label: {
                    Text("accept")
                }
            }
    }
    
    var finishShopPopup: some View {
        PopupView(
            showAlert: $viewModel.finishShopAlert,
            title: "finish_shopping_popup_title") {
                Text("finish_shopping_popup_message")
            } buttons: {
                Button {
                    viewModel.finishShopAlert.toggle()
                } label: {
                    Text("cancel")
                }
                Button {
                    withAnimation(.easeInOut) {
                        viewModel.finishShop()
                    }
                    viewModel.finishShopAlert.toggle()
                } label: {
                    Text("accept")
                }
            }
    }
    
    var shopCompletePopup: some View {
        PopupView(
            showAlert: $viewModel.shopCompleteAlert,
            title: "Your order is complete") {
                Text(String(format:
                                NSLocalizedString("orders_finish_popup_message1", comment: ""), viewModel.pendingOrder?.id ?? "")) +
                Text(Image(systemName: .shippingBoxFill)) +
                Text("orders_finish_popup_message2")
            } buttons: {
                Button {
                    viewModel.shopCompleteAlert.toggle()
                } label: {
                    Text("accept")
                }
            }
    }
}

struct ShopView_Previews: PreviewProvider {
    static var previews: some View {
        (ModuleDependencies().resolve() as ShopView)
            .environmentObject(ModuleDependencies().resolve() as BooksViewModel)
            .environmentObject(ModuleDependencies().resolve() as ShopViewModel)
    }
}
