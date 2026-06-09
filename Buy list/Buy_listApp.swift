//
//  Buy_listApp.swift
//  Buy list
//
//  Created by Lorran Silva on 23/12/25.
//

import SwiftUI

@main
struct MercadoSimpleApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .tint(AppTheme.tint)
                .preferredColorScheme(.light)
        }
    }
}
