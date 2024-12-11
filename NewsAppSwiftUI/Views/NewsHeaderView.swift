//
//  NewsHeaderView.swift
//  NewsAppSwiftUI
//
//  Created by Octo Siswardhono on 09/12/24.
//

import SwiftUI

struct NewsHeaderView: View {
    var body: some View {
        Text("News")
            .font(.largeTitle)
            .bold()
            .padding(.leading, 16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(UIColor.systemBackground))
    }
}
