//
//  CategoryView.swift
//  ReadBookApp
//
//  Created by Phan Tam Nhu on 25/03/2022.
//

import SwiftUI

struct CategoryView: View {
    @State private var selectedBottomNavBarItemIndex = 2
    @StateObject private var vm = HomeViewModel()
    @Environment(\.presentationMode) var presentationMode : Binding<PresentationMode>
    
    var body: some View {
    
        ZStack {
            VStack(alignment: .leading, spacing: 15) {
                Spacer()
                
                Text("CÁC THỂ LOẠI SÁCH HAY NHẤT HIỆN NAY")
                    .fontWeight(.bold)
                    .font(.system(size: 16.5))
                    .foregroundColor(.black)

                VStack(spacing: 15) {
                    listCategory(vm: vm, categories: vm.categories)
                }
            }
            .padding(.horizontal)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: CustomBackButtonView (
                                    action:{
                                        presentationMode.wrappedValue.dismiss()
                                    })
                                )
            .navigationBarTitle("THỂ LOẠI", displayMode: .inline)
            .onAppear {
                vm.fetchBookCategories()
                vm.fetchBooks()
            }
            .onDisappear {
                vm.removeAllListeners()
            }
            bottomNavBar(selectedBottomNavBarItemIndex: $selectedBottomNavBarItemIndex)
        }
    }
}

struct ButtonCategory: View {
    
    @State var randColor = Color.white
    let name: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 4)
                .fill(randColor)
                .frame(height: 80)
            
            HStack(spacing: 15){
                RoundedRectangle(cornerRadius: 4)
                    .fill(.white)
                    .frame(width: 10, height: 33)
                
                VStack(alignment: .leading) {
                    Text(name)
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Text("3 sách")
                        .font(.system(size: 14))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }
            }
        }.onAppear{self.changeColor()}
    }
    
    func changeColor() {
        let ran1 = Double.random(in: 0...1)
        let ran2 = Double.random(in: 0...1)
        let ran3 = Double.random(in: 0...1)

        let randColor = Color(red: ran1, green: ran2, blue: ran3)
        self.randColor = randColor
    }
}

struct listCategory: View {
    @State private var actionn: Int? = 0
    
    @ObservedObject var vm: HomeViewModel
    let categories:[BookCategory]
    
    @State var navigationViewIsActive: Bool = false
    @State var selectedData : BookCategory? = nil // biến tuỳ chọn
    
    var body: some View {
        ScrollView (.vertical, showsIndicators: false) {
            VStack {
                if selectedData != nil {
                    NavigationLink("", destination: DetailCategoryView(category: selectedData!.name, categoryId: selectedData!.id), isActive: $navigationViewIsActive)
                }
            }.hidden()
            
            ForEach(categories.indices, id: \.self) { index in
                Button(action: {
                    self.selectedData = categories[index]
                    self.navigationViewIsActive = true
                }, label: {
                    ButtonCategory(name: categories[index].name)
                })
            }
        }
    }
    
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView()
    }
}
