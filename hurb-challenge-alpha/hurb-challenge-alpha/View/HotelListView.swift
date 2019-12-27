//
//  HotelListView.swift
//  hurb-challenge-alpha
//
//  Created by Hannah  on 26/12/2019.
//  Copyright © 2019 Hannah . All rights reserved.
//

import SwiftUI

///class responsible for displaying a list grouped by hotels and packages
struct HotelListView: View {
    
    @ObservedObject var hotelListVM = HotelListViewModel()
    
    /// remove separator from list
    init() {
        UITableView.appearance().separatorStyle = .none
    }
    var body: some View {
        
            ZStack {
                List {
                    ForEach(hotelListVM.hotelsGroup) { grupo in
                        Section(header: HStack {
                            SectionHeaderView(stars: grupo.stars)
                            Spacer()
                        }
                        .background(Color.init(hex: "#143A7B"))
                        .listRowInsets(EdgeInsets(
                            top: 0,
                            leading: 0,
                            bottom: 0,
                            trailing: 0))
                        ) {
                            HotelRowView(hotels: grupo.value)
                        }
                    }
                }.environment(\.defaultMinListRowHeight, 350)
                ActivityIndicatorView(show: self.hotelListVM.isLoading)
                ErrorMensage(show: self.hotelListVM.showMsgError)
            }
        
    }
}

/// view responsable from show custom activity indicator while waiting for the request
struct ActivityIndicatorView: View {
    var show: Bool
    var body: some View {
        VStack {
            if self.show {
                ActivityIndicator(hide: false)
                    .frame(width: 50, height: 50)
            }
        }
    }
}

/// view responsable from show message error
struct ErrorMensage: View {
    var show: Bool
    var body: some View {
        VStack {
            if self.show {
                Text("Ops! \n Ocorreu um problema. \n Tente  novamente mais tarde")
                    .multilineTextAlignment(.center)
                    .font(.headline)
                    .foregroundColor(Color.init(hex: "#143A7B"))
                
            }
        }
        
    }
}

struct HotelListView_Previews: PreviewProvider {
    static var previews: some View {
        HotelListView()
    }
}
