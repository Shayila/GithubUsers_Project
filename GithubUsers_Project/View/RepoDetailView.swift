//
//  RepoDetailView.swift
//  GithubUsers_Project
//
//  Created by Shayila Kamaal on 16/07/26.
//

import SwiftUI


struct RepoDetailView : View {
    var repoDetail : Repository
    @Environment(\.openURL) var openURL
    var body : some View {
        
            VStack(alignment: .center){
                
                HStack(spacing: 10) {
                    let url = URL(string: repoDetail.owner.avatar ?? "")
                        AsyncImage(url: url) { image in
                            image.resizable()
                        } placeholder: {
                            
                        Image("ProfileImg").resizable()
                                .aspectRatio(contentMode: .fill)
                        }
                        .frame(width: 80,height: 80)
                        .clipShape(.circle)
                            
                    
                    Text(repoDetail.owner.loginName ?? "")
                        .font(.title)
                        .bold()
                        .frame(alignment: .center)
                        .padding()
                }
                List {
                gitHubDetailCell()
            }
        }
            .padding()
    }
    
    @ViewBuilder
    func gitHubDetailCell() -> some View {
        
        Button {
            if let url = URL(string: repoDetail.htmlUrl ?? ""){
                openURL(url)
            }
        } label: {
            VStack(alignment: .leading) {
                
                HStack {
                    Image(systemName: "text.book.closed")
                        .resizable().frame(width: 16,height: 16)
                        .foregroundStyle(.black.opacity(0.4))
                    
                    Text(repoDetail.name ?? "")
                        .font(.title2)
                        .fontWeight(.medium)
                        .foregroundStyle(.blue)
                    
                    Text(repoDetail.visibility ?? "")
                        .fontWeight(.medium)
                        .padding(.horizontal, 4)
                        .padding(.vertical, 4)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black.opacity(0.4), lineWidth: 1)
                        )
                        .foregroundStyle(.black.opacity(0.5))
                    
                    
                }
                
                Text(repoDetail.gitDescription ?? "")
                    .font(.caption)
                    .padding(.bottom,6)
                    .foregroundStyle(.black.opacity(0.6))
                
                
                HStack {
                    
                    
                    if let language = repoDetail.language {
                        Text("🔵 \(language)").foregroundStyle(.black.opacity(0.6))
                    }
                    
                    Button {
                        if let url = URL(string: repoDetail.forkUrl ?? ""){
                            openURL(url)
                        }
                    } label: {
                        Label(repoDetail.name ?? "", systemImage: "arrow.trianglehead.branch")
                            .font(.default)
                            .fontWeight(.medium)
                            .foregroundStyle(.black.opacity(0.6))
                    }
                    
                    
                }
            }
        }
        //.foregroundStyle(.clear)
    }
    
}

#Preview {
    let data = formTempModalDetail()
    RepoDetailView(repoDetail: data)
}
