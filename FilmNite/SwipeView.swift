//
//  SwipeView.swift
//  FilmNite
//
//  Created by Sarah O'Brien on 11/25/20.
//

import SwiftUI

struct SwipeView: View{

    var body: some View{
        VStack{
            //Top Stack
            HStack{
//                do i need top stack??
            }
            
            //Card
            ZStack{
                ForEach(Card.data) { card in
                CardView(card: card).padding(8)
            }
            }.zIndex(1.0)
            
            
            //bottom stack
//            HStack(spacing: 0){
//
//                Button(action:{}){
//                    Image("dismiss_circle")
//                }
//
//                Button(action:{
//
//                }){
//                    Image("like_circle")
//
//
//                    }
//                }
                
            }
        }
    }


struct SwipeView_Previews: PreviewProvider{
    static var previews: some View{
        SwipeView()
    }
}

struct CardView: View{
    @State var card: Card
    var body: some View{
    ZStack(alignment: .topLeading){
        Image(card.imageName).resizable()
       //could add gradient
        VStack{
            Spacer()
            VStack(alignment: .leading){
                HStack{
                    Text(card.name).font(.largeTitle).fontWeight(.bold)
                    Text(String(card.released)).font(.title)

                }
                Text(card.bio)

            }
        }
        .padding()
        .foregroundColor(.white)
   
        HStack{
            Image("like")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:150)
                .opacity(Double(card.x/10 - 1)) //if its positive then it is liked Use this for commonalitiees probs
            Spacer()
            Image("nope")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150)
                .opacity(Double(card.x/10 * -1 - 1)) //if its positive then it is disliked. Use this for commonalitiees probs
        }
    
    }
    .cornerRadius(8)
    .offset(x: card.x, y: card.y)
    .rotationEffect(.init(degrees: card.degree))
    .gesture(
        DragGesture()
            .onChanged { value in
                //user dragging view
                withAnimation(.default){
                    card.x = value.translation.width
                    card.y = value.translation.height
                    card.degree = 7 * (value.translation.width > 0 ? 1 : -1)
                }
            }
        
            .onEnded{ value in
                //after letting go of card
                withAnimation(.interpolatingSpring(mass: 1.0, stiffness: 50, damping: 8, initialVelocity: 0)){
                    switch value.translation.width{
                        case 0...100:
                            card.x = 0; card.degree = 0; card.y = 0
                        case let x where x > 100:
                            card.x = 500; card.degree = 12
                        case (-100)...(-1):
                            card.x = 0; card.degree = 0; card.y = 0;
                        case let x where x < -100:
                            card.x = -500; card.degree = -12
                        default: card.x = 0; card.y = 0
                    }
                }
            }
    )
    }
}

