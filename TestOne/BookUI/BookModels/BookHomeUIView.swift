//
//  BookHomeUIView.swift
//  TestOne
//
//  Created by Emmanuel Nollase on 3/16/23.
//

import SwiftUI

struct BookHomeUIView: View {
    
    @State private var activeTag: String = "Biography"
    @Namespace private var animation
    
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                Text("Browse").font(.largeTitle.bold())
                Text("Recommended").fontWeight(.semibold).padding(.leading, 15)
                    .foregroundColor(.gray).offset(y: 2)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 15)
            
            TagsView()
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 35) {
                    ForEach(sampleBooks) { book in
                        BookCardView(book)
                    }
                }
                .padding(.horizontal, 15)
                .padding(.vertical, 20)
            }
            .coordinateSpace(name: "SCROLLVIEW")
        }
    }
    
    @ViewBuilder
    func BookCardView(_ book: Book) -> some View {
        GeometryReader {
            let size = $0.size
             let rect = $0.frame(in: .named("SCROLLVIEW"))
            
            HStack(spacing: -25) {
                // Book detail card
                VStack(alignment: .leading, spacing: 6) {
                    Text(book.title).font(.title3).fontWeight(.semibold)
                    Text(book.author).font(.caption).foregroundColor(.gray)
                    
                    RatingView(rating: book.rating).padding(.top, 10)
                    Spacer(minLength: 10)
                    HStack(spacing: 4) {
                        Text("\(book.bookView)").font(.caption).fontWeight(.semibold).foregroundColor(.blue)
                        Text("Views").font(.caption).foregroundColor(.gray)
                        Spacer(minLength: 0)
                        Image(systemName: "chevron.right").font(.caption).foregroundColor(.gray)
                    }
                }
                .padding(20)
                .frame(width: size.width / 2, height: size.height * 0.8)
                .background(
                    RoundedRectangle(cornerRadius: 10, style: .continuous).fill(.white)
                        .shadow(color: .black.opacity(0.08), radius: 8, x: 5, y: 5)
                        .shadow(color: .black.opacity(0.08), radius: 8, x: -5, y: -5)
                )
                .zIndex(1)
                /// book cover image
                ZStack {
                    Image(book.imageName).resizable().aspectRatio(contentMode: .fill)
                        .frame(width: size.width / 2, height: size.height)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
                        .shadow(color: .black.opacity(0.1), radius: 5, x: -5, y: -5)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(width: size.width)
        }
        .frame(height: 220)
    }
    
    @ViewBuilder
    func TagsView() -> some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack(spacing: 10) {
                ForEach(tags, id: \.self) { tag in
                    Text(tag).font(.caption).padding(.horizontal, 12).padding(.vertical, 5)
                        .background {
                            if activeTag == tag {
                                Capsule().fill(Color.blue).matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                            } else {
                                Capsule().fill(.gray.opacity(0.2))
                            }
                        }
                        .foregroundColor(activeTag == tag ? .white : .gray)
                        .onTapGesture {
                            withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.7)) {
                                activeTag = tag
                            }
                        }
                }
            }
            .padding(.horizontal, 15)
        }
    }
}

var tags: [String] = [
    "History","Classical","Biography","Cartoon","Adventure","Fairy Tales", "Fantasy"
]

struct RatingView: View {
    
    let rating: Int
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(1...5, id: \.self) { index in
                Image(systemName: "star.fill").font(.caption2)
                    .foregroundColor(index <= rating ? .yellow : .gray.opacity(0.5))
            }
            
            Text("(\(rating))").font(.caption).fontWeight(.semibold).foregroundColor(.yellow).padding(.leading, 5)
        }
    }
}

struct BookHomeUIView_Previews: PreviewProvider {
    static var previews: some View {
        BookHomeUIView()
    }
}
