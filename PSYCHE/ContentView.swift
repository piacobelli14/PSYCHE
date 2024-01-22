//
//  ContentView.swift
//  PSYCHE
//
//  Created by Peter Iacobelli on 1/20/24.
//

import SwiftUI


struct ContentView: View {
    @State private var currentView: AppView = .Login

    var body: some View {
        switch currentView {
        case .Login:
            PSYCHELogin(currentView: $currentView)
        case .Reset:
            PSYCHEReset(currentView: $currentView)
        case .Register:
            PSYCHRegister(currentView: $currentView)
        case .Patients:
            PSYCHEPatients(currentView: $currentView)
        }
    }
}
