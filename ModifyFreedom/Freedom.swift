//
//  FreedomModelData.swift
//  Freedom
//
//  Created by BeastMode on 12/4/24.
//
import SwiftUI
import Foundation

struct FreedomModelData: Codable, Identifiable{
    
    let id: Int
    let step1: Bool
    let step2: Bool
    let step3: Bool
    let step4: Bool
    let step5: Bool
    let step6: Bool
    let step7: Bool
    let workingOn: String
    let debt: Double
    let debtBalance: Double
    let emergencyFund: Double
    let efBalance: Double
    let mortgage: Double
    let mortgageBalance: Double
    
}

@MainActor class FreedomModelDataStore: ObservableObject{
    
    @Published var id: Int = 1
    @Published var step1: Bool = false
    @Published var step2: Bool = false
    @Published var step3: Bool = false
    @Published var step4: Bool = false
    @Published var step5: Bool = false
    @Published var step6: Bool = false
    @Published var step7: Bool = false
    @Published var workingOn: String = ""
    @Published var debt: Double = 0
    @Published var debtBalance: Double = 0
    @Published var emergencyFund: Double = 0
    @Published var efBalance: Double = 0
    @Published var mortgage: Double = 0
    @Published var mortgageBalance: Double = 0
    
    let freedomUrl = URL(string: "https://api.jsonsilo.com/public/daeef78e-4b86-4271-b6bb-0b1dea73fda6")!
    
//    init(){
//        getFreedomModelData{(freedom) in
//            
//            self.id = freedom.id
//            self.step1 = freedom.step1
//            self.step2 = freedom.step2
//            self.step3 = freedom.step3
//            self.step4 = freedom.step4
//            self.step5 = freedom.step5
//            self.step6 = freedom.step6
//            self.step7 = freedom.step7
//            self.workingOn = freedom.workingOn
//            self.debt = freedom.debt
//            self.debtBalance = freedom.debtBalance
//            self.emergencyFund = freedom.emergencyFund
//            self.efBalance = freedom.efBalance
//            self.mortgage = freedom.mortgage
//            self.mortgageBalance = freedom.mortgageBalance
//            
//        }
//    }

    func getFreedomModelData(completion:@escaping (FreedomModelData) -> ()) {
        
        URLSession.shared.dataTask(with: freedomUrl) { data, _, _  in
            
            let freedom = try!  JSONDecoder().decode(FreedomModelData.self, from: data!)
            
            DispatchQueue.main.async {
                completion(freedom)
                
            }
        }
        .resume()
        
    }
    
    func saveFreedomModelData(completion:@escaping (FreedomModelData) -> ()) {
        
        let freedomModelData = FreedomModelData(id: id, step1: step1, step2: step2, step3: step3, step4: step4, step5: step5, step6: step6, step7: step7, workingOn: workingOn, debt: debt, debtBalance: debtBalance, emergencyFund: emergencyFund, efBalance: efBalance, mortgage: mortgage, mortgageBalance: mortgageBalance)
        
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted
        
        let url = URL.documentsDirectory.appending(path: "https://api.jsonsilo.com/public/daeef78e-4b86-4271-b6bb-0b1dea73fda6")

        do {
            
            let encodeFreedom = try jsonEncoder.encode(freedomModelData)
            try encodeFreedom.write(to: url)

            let endcodeStringPerson = String(data: encodeFreedom, encoding: .utf8)!
            print(endcodeStringPerson)
            
        }
        catch
        {
            print(error.localizedDescription)
        }
        
        
    }
    
    func getData() async{
        guard let url = URL(string: "https://api.jsonsilo.com/public/daeef78e-4b86-4271-b6bb-0b1dea73fda6")
        else {
            print("Error getting url: https://api.jsonsilo.com/public/daeef78e-4b86-4271-b6bb-0b1dea73fda6")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            guard let freedom = try? JSONDecoder().decode(FreedomModelData.self , from: data) else {
                
                print("Could not decode")
                return
            }
            
            self.id = freedom.id
            self.step1 = freedom.step1
            self.step2 = freedom.step2
            self.step3 = freedom.step3
            self.step4 = freedom.step4
            self.step5 = freedom.step5
            self.step6 = freedom.step6
            self.step7 = freedom.step7
            self.workingOn = freedom.workingOn
            self.debt = freedom.debt
            self.debtBalance = freedom.debtBalance
            self.emergencyFund = freedom.emergencyFund
            self.efBalance = freedom.efBalance
            self.mortgage = freedom.mortgage
            self.mortgageBalance = freedom.mortgageBalance
            
            print("Successfully decoded")
            
        } catch {
            print("Error: URL Session not working")
        }
    }
    
}

