//
//  UserViewModal.swift
//  GithubUsers_Project
//
//  Created by Shayila Kamaal on 16/07/26.
//
import SwiftUI
import Combine
import SwiftData

@MainActor
class UserViewModal : ObservableObject {
    @Published var gitHublist : GitHubList?
    @Published var repoList : [Repository] = [Repository]()
    
    private(set) var store = Set<AnyCancellable>()
    @Published var isLoading = false
    @Published var searchText = ""
    
    var pageNumber = 1
    private(set) var offlineModel : OfflineModel?
    
    @Published var errorMessage = ""
    @Published var isFailed = false
    
    init(){
        $searchText.debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] item in
                self?.fetchLatestList()
            }.store(in: &store)
    }
    
    
    
    
    func fetchLatestList(pageNum : Int = 1){
        guard !isLoading else { return }
        
        isLoading = true
        
        self.pageNumber = pageNum
        
        let userManager = UserRequestManager()        
        
        let webService = WebServiceManager(delegate: userManager)
        do {
            /*?q=swift&sort=stars&page=1&per_page=4*/
            
            var param =  ["page":"\(pageNum)","sort":"stars","per_page" : "20","order" : "desc"]
            if !searchText.isEmpty {
                param["q"] = "\(searchText)"
            }
           
            try webService.serviceCall(requestType: param)//
                .sink {[weak self] error in
                    self?.isLoading = false

                    switch error {
                    case .finished: break
                    case .failure(let apiError):
                        print(apiError.localizedDescription)
                        DispatchQueue.main.async {
                            if !(self?.isFailed ?? false){
                                self?.isFailed = true
                            }
                            self?.errorMessage = apiError.localizedDescription
                        }
                        self?.offlineModefetch()
                        break
                    }
                    
                } receiveValue: { [weak self] gitHub in
                    DispatchQueue.main.async {
                        self?.isLoading = false
                        
                        var result = [Repository]()
                        if self?.pageNumber == 1 {
                            self?.gitHublist = gitHub
                            result = Constant.removeDuplicates(from: gitHub.items)
                            self?.flushOutDB()
                            self?.saveDataToDB(list: result)
                        }
                        else {
                            
                            if let oldList = self?.repoList {
                                let newResult = Constant.removeDuplicates(from: oldList, and: gitHub.items)
                                result = oldList + newResult
                                
                                self?.saveDataToDB(list: newResult)
                            }
                            self?.gitHublist = gitHub
                        }
                        
                        self?.repoList = result
                        
                    }
                    
                }.store(in: &store)
        }
        catch {
            self.isLoading = false
            self.isFailed = true
            self.errorMessage = error.localizedDescription
            print(error.localizedDescription)
        }
    }
    
    func checkIfItsToLoadMore(id  : Int) async {
            if id > 0 && repoList.last?.id! == id {//&& (gitHublist?.incompleteResult ?? false) 
                pageNumber += 1
                fetchLatestList(pageNum: pageNumber)
            }        
    }
    
    func resetErrorMessage() {
        isFailed = false
    errorMessage = ""
    }
    
    
    //MARK: -  Offline Methods
    func setModelContext(_ context: ModelContext) {
        self.offlineModel = OfflineModel(context: context)
    }
    
    func saveDataToDB(list : [Repository]) {
        DispatchQueue.main.async {
            self.offlineModel?.saveRepositories(list: list)}
    }
    
    func flushOutDB(){
        self.offlineModel?.deleteAllRows()
    }
    
    func offlineModefetch() {
        guard let repositories = self.offlineModel?.fetchRepositories() else {return}
        DispatchQueue.main.async {
            self.repoList = repositories
        }
    }
}

//TODO: - Junk Data
extension UserViewModal {
    func setDumpData(){
        let response = formTempModal()
        self.gitHublist = response
        self.repoList = response.items
    }

}
