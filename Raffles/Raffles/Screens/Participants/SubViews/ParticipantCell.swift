//
//  ParticipantCell.swift
//  Raffles
//
//  Created by Jack Wong on 5/30/21.
//

import SwiftUI

struct ParticipantCell: View {
    let participant: Participant
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(participant.fullName)
                .font(.title2)
                .fontWeight(.medium)
            
            HStack(spacing: 20) {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 50)
                VStack(alignment: .leading) {
                    Group {
                        Label(
                            title: {
                                Text("\(participant.id)")
                                    .fontWeight(.semibold)
                            },
                            icon: {
                                Image(systemName: "number")
                                    .scaledToFit()
                                    .frame(width: 22)
                            }
                        )
                        
                        Label(
                            title: {
                                Text("\(participant.email)")
                                    .fontWeight(.semibold)
                            },
                            icon: {
                                Image(systemName: "envelope.fill")
                                    .scaledToFit()
                                    .frame(width: 22)
                            }
                        )
                        
                        Label(
                            title: {
                                Text("\(participant.phone ?? "")")
                                    .fontWeight(.semibold)
                            },
                            icon: {
                                Image(systemName: "phone")
                                    .scaledToFit()
                                    .frame(width: 22)
                            }
                        )
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
        .padding()
        .background(
            NeumorphicCard()
        )
    }
}


struct ParticipantsCell_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ParticipantCell(participant: .init(id: 1, raffleId: 8, firstname: "Alejandro", lastname: "Franco", email: "alejandrofranco@pursuit.org", phone: "12345678900", registeredAt: Date()))
            
            ParticipantCell(participant: .init(id: 1, raffleId: 8, firstname: "Alejandro", lastname: "Franco", email: "alejandrofranco@pursuit.org", phone: "12345678900", registeredAt: Date()))
                .preferredColorScheme(.dark)
        }
        .padding()
    }
}
