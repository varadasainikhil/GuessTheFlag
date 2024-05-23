//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Sai Nikhil Varada on 5/13/24.
//

import SwiftUI

struct FlagImage: View {
    var image : String
    var body: some View {
        Image(image)
            .shadow(radius: 5)
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia","France","Germany","Ireland","Italy","Monaco","Nigeria","Poland","Spain","UK","Ukraine","US"]
    
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var chosenAnswer = 0
    @State private var showingAlert = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var numberOfQuestions = 0
    
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
                        FlagImage(image: countries[number])
                    }
                    
                }
                Spacer()
                Text("Your score is \(score)")
                Spacer()
            }
        }
        .alert(scoreTitle, isPresented: $showingAlert){
            Button("Continue", action: askQuestion)
        } message: {
            if scoreTitle == "Correct"{
                Text("Your score is \(score) ")
            }
            else{
                Text("Wrong! That was the flag of \(countries[chosenAnswer])")
            }
            
        }
    }
    
    func flagTapped(_ number : Int){
        chosenAnswer = number
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        }else{
            scoreTitle = "Wrong"
            score -= 1
        }
        numberOfQuestions += 1
        showingAlert = true
    }
    
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    
}

#Preview {
    ContentView()
}
