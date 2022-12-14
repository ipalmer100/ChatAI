// You do not need to use this in your project file...
//  ContentView.swift
//  ChatAI2
//
//  Created by Isaac Palmer on 12/13/22.
//

import OpenAISwift
import SwiftUI

final class ViewModel: ObservableObject {
    init() {}
    
    private var client: OpenAISwift?
    
    func setup() {
        client = OpenAISwift(authToken: "ABCDEFGHIJKLMNOPQRSTUVWXYZ") //<- Change this key in the file you download
