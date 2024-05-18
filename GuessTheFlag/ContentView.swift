//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Sai Nikhil Varada on 5/13/24.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia","France","Germany","Ireland","Italy","Monaco","Nigeria","Poland","Spain","UK","Ukraine","US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    
    var body: some View {
        ZStack{
            
            LinearGradient(colors: [.white, .mint], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(spacing : 30){
                Spacer()
                
                Text("Guess the Flag")
                    .font(.title.bold())
                
                Spacer()
                
                VStack{
                    Text("Tap the flag of ")
                        .font(.subheadline.weight(.heavy))
                    
                    Text(countries[correctAnswer])
                        .font(.largeTitle.weight(.semibold))
                       
                }
                
                ForEach(0..<3){ number in
                    Button(){
                        flagTapped(number)
                    } label: {
                        Image(countries[number])
                            .shadow(radius: 5)
                    }
                    
                }
                Spacer()
                Text("Your score is \(score)")
                Spacer()
            }
        }
        .alert(scoreTitle, isPresented: $showingScore){
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score) ")
        }
    }
    
    func flagTapped(_ number : Int){
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        }else{
            scoreTitle = "Wrong"
            score -= 1
        }
        
        showingScore = true
    }
    
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    
}

#Preview {
    ContentView()
}
