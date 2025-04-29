//
//  PDFViewScreen.swift
//  GoogleSignInApp
//
//  Created by apple on 29/04/25.
//

import SwiftUI
import PDFKit

struct PDFViewScreen: View {
    let pdfURL = URL(string: "https://fssservices.bookxpert.co/GeneratedPDF/Companies/nadc/2024-2025/BalanceSheet.pdf")!

    var body: some View {
        PDFKitView(url: pdfURL)
    }
}

struct PDFKitView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.autoScales = true
        if let document = PDFDocument(url: url) {
            pdfView.document = document
        }
        return pdfView
    }

    func updateUIView(_ uiView: PDFView, context: Context) {}
}


#Preview {
    PDFViewScreen()
}
