//
//  SwipeView.swift
//  FilmNite
//
//  Created by Sarah O'Brien on 11/25/20.
//

import SwiftUI

struct SwipeView: View {
    //@ObservedObject
    private var model = Card(name: "", imageName: "", released: "0", bio: "")
    var body: some View {
        VStack{
            //Top Stack
            HStack{
            }
            //Card
            ZStack{
                ForEach(Card.data) { card in
                    CardView(card: card).padding(8)
                }
            }
            }.zIndex(1.0)
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
        RoundedRectangle(cornerRadius:4.0)
            .fill(Color.black)
        VStack{
            VStack(alignment: .leading){
                Text("Released " + String(card.released)).font(.headline).foregroundColor(.white)
        }
        VStack{
            RemoteImage(url: card.imageName).aspectRatio(contentMode: .fit)
                Text(card.bio).foregroundColor(.white)
            }
        }
        .padding()
        .foregroundColor(.black)
   
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
                            //addUserMovie(movieTitle: card.name)
                        case (-100)...(-1):
                            card.x = 0; card.degree = 0; card.y = 0;
                        case let x where x < -100:
                            card.x = -500; card.degree = -12
                            updateSessionMovies(movieTitle: card.name)
                        default: card.x = 0; card.y = 0
                    }
                }
            }
    )
    }
}
