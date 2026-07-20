//
//  ContentView.swift
//  GithubUsers_Project
//
//  Created by Shayila Kamaal on 16/07/26.
//

import SwiftUI
import SwiftData


struct ContentView: View {
    @StateObject var userVM = UserViewModal()
    @Environment(\.modelContext) private var context
    //@EnvironmentObject var stack : NavigationManager
    @State private var network = InternetManager()
    
    var body: some View {
        
        NavigationStack {
            List {
                    ForEach(userVM.repoList) { repo in
                        
                        NavigationLink {
                            RepoDetailView(repoDetail: repo)
                        }
                        label: {
                            repoAndUserDetailCell(repo: repo)
                        }
                        
                        .onAppear {
                            Task {
                                await userVM.checkIfItsToLoadMore(id: repo.id!)
                            }
                        }
                        
                    
                }.padding(10)
            }

                                    
            .navigationTitle("Latest GitHub list\(network.isAvailable ? "🟢" : "⛔️" )")
            .navigationBarBackButtonHidden(true)
            
            .overlay{
                if userVM.isLoading && userVM.repoList.isEmpty{
                    ProgressView()
                }
            }
            .searchable(text: $userVM.searchText,placement: SearchFieldPlacement.navigationBarDrawer, prompt: "Search for repository..")
            .refreshable {
                userVM.fetchLatestList()
            }            
        }
        .onAppear() {
            userVM.setModelContext(context)
            userVM.fetchLatestList()
        }
        .alert("Error", isPresented: $userVM.isFailed, actions: {
            Button("OK"){
                userVM.resetErrorMessage()
            }
        }, message: {
            Text(userVM.errorMessage)
        })
     
    }
    
    @ViewBuilder
    func repoAndUserDetailCell(repo : Repository) -> some View {
        
        HStack(spacing: 10) {
            
            let url = URL(string: repo.owner.avatar ?? "")
                AsyncImage(url: url) { image in
                    image.resizable()
                } placeholder: {
                    
                Image("ProfileImg").resizable()
                        .aspectRatio(contentMode: .fill)
                }.frame(width: 80,height: 120)
                    .cornerRadius(5)
            
            VStack(alignment: .leading,spacing: 10) {
                labelAndValueCell(label: "Name", value: repo.owner.loginName ?? "")
                labelAndValueCell(label: "Stars", value: repo.score ?? 0)
                labelAndValueCell(label: "Language", value: repo.language ?? "")
            }
        }
        
    }
    
    @ViewBuilder
    func labelAndValueCell(label : String, value : Any) -> some View
    {
        HStack(spacing: 6) {
            Text("\(label):").font(.title3)
                .fontWeight(.medium)
            if label == "Stars", let rate = value as? Double {
                Text(String(repeating: "⭐️", count: Int(rate)))
            }
            else if let val = value as? String{
                Text(val)
            }
        }
    }
}

#Preview {
    ContentView().modelContainer(for:[RepositoryEntity.self,OwnerEntity.self])
}
