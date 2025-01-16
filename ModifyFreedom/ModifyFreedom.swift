//
//  ContentView.swift
//  ModifyFreedom
//
//  Created by BeastMode on 12/6/24.
//

import SwiftUI

struct ModifyFreedom: View {
        
    @StateObject var freedom: FreedomModelDataStore = FreedomModelDataStore()
    
    var body: some View {
        VStack {
             
            Form {
                
                Section(header: Text("ID")){
                    
                    TextField("ID", value: $freedom.id, format: .number)
                    
                }
                
                Section(header: Text("Debt")){
                    
                    TextField("Debt", value: $freedom.debt, format: .number)
                    
                    TextField("Debt Balance", value: $freedom.debtBalance, format: .number)
                    
                }
                
                Section(header: Text("Emergency Fund")){
                    
                    TextField("Goal", value: $freedom.emergencyFund, format: .number)
                    
                    TextField("Balance", value: $freedom.efBalance, format: .number)
                    
                }
                
                Section(header: Text("Mortgage")){
                    
                    TextField("Mortgage", value: $freedom.mortgage, format: .number)
                    
                    TextField("Balance", value: $freedom.mortgageBalance, format: .number)
                    
                }
                
                Section(header: Text("Baby Steps")){
                    
                    VStack {
                        Toggle("Step 1", isOn: $freedom.step1)
                        Toggle("Step 2", isOn: $freedom.step2)
                        Toggle("Step 3", isOn: $freedom.step3)
                        Toggle("Step 4", isOn: $freedom.step4)
                        Toggle("Step 5", isOn: $freedom.step5)
                        Toggle("Step 6", isOn: $freedom.step6)
                        Toggle("Step 7", isOn: $freedom.step7)

                    }
                }
                
                HStack{
                    Spacer()
                    Button("Save") {
                        freedom.saveFreedomModelData(completion: { _ in })
                    }
                    Spacer()
                }
                
            }
            .task  {
                await freedom.getData()
                
            }
        }
        .padding()
    }
}

#Preview {
    ModifyFreedom()
}
