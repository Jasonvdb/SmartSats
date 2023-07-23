//
//  TxListItem.swift
//  SmartSats
//
//  Created by Jason van den Berg on 2023/07/23.
//

import SwiftUI

struct TxListItem: View {
    var payment = dummyPayment
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            image
            VStack(alignment: .leading, spacing: 8) {
                title
                Text(payment.displayTime)
                    .font(.caption.weight(.medium))
                    .foregroundStyle(Color.brandTextSecondary)
            }
            Spacer()
            amount
        }
        .contentShape(Rectangle()) //Allows whole area to be tapped
        .padding(8)
        .background(.ultraThinMaterial)
        .backgroundColor(opacity: 0.2, cornerRadius: 20)
        .backgroundStyle(cornerRadius: 20)
        .modifier(OutlineModifier(cornerRadius: 20))
    }
    
    var image: some View {
        var systemName = ""
        var color = Color.blue
        switch payment.paymentType {
        case .received:
            systemName = "arrow.down.forward"
            color = .green
            break
        case .sent:
            systemName = "arrow.up.forward"
            color = .red
            break
        case .closedChannel:
            systemName = "checkmark"
            break
        }
        
        return Image(systemName: systemName)
            .resizable()
            .scaledToFit()
            .foregroundColor(color)
            .padding(6)
            .frame(width: 26, height: 26)
            .mask(Circle())
            .padding(12)
            .background(Color(UIColor.systemBackground).opacity(0.3))
            .mask(Circle())
    }
   
    var title: some View {
        var title = payment.description ?? ""
        if title == "" {
            switch payment.paymentType {
            case .received:
                title = "Received"
                break
            case .sent:
                title = "Paid"
                break
            case .closedChannel:
                title = "Closed channel"
                break
            }
        }
        
        return Text(title)
            .fontWeight(.semibold)
    }
    
    var amount: some View {
        VStack(alignment: .trailing) {
            Text("\(payment.amountMsat.sats) sats")
                .foregroundStyle(Color.brandTextPrimary)
            Text("Fee: \(payment.feeMsat.sats)")
                .font(.caption.weight(.light))
                .foregroundStyle(Color.brandTextSecondary)
        }
    }
}

struct TxListItem_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            TxListItem(payment: dummyPayment)
        }
        .padding()
        .background(Color.brandBackground1)
    }
}
