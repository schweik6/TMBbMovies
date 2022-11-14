//
//  MovieRoleView.swift
//  TMBbMovies
//
//  Created by schweik on 2022/11/14.
//

import SwiftUI

/// The component view of MovieDetail view, render the diff roles of the members..
struct MovieRoleView: View {
    // The num to render the columns.
    private static let renderColumns = 2
    // The member data to render this page.
    var members: [Member]
    // The role name to display.
    var roleName: String

    var body: some View {
        // For every two members in a row to display.
        let renderRows = members.count / MovieRoleView.renderColumns + 1
        // To render the rows.
        ForEach(0 ..< renderRows, id: \.self) { rowIndex in
            HStack {
                // To render the colums.
                ForEach(0 ..< MovieRoleView.renderColumns, id: \.self) { columnIndex in
                    // To calculate the actual index of the member, and judge whether to display.
                    let memberIndex = rowIndex * MovieRoleView.renderColumns + columnIndex
                    if memberIndex < members.count {
                        let member = members[memberIndex]
                        
                        // Align lead in the VStack.
                        VStack(alignment: .leading) {
                            // To render the member's name.
                            Text(member.name).font(.system(size: 14, weight: .medium)).lineLimit(1)
                            // To render the roleName.
                            Text(roleName).font(.system(size: 14)).foregroundColor(Color.init(white: 0.65))
                        }
                        // Split and align lead too the VStack.
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    }
                }
            }.padding(.top).padding(.leading)
        }
    }
}

