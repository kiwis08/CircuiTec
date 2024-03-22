//
//  RouteProgressView.swift
//  CircuiTec
//
//  Created by Santiago Quihui on 20/03/24.
//

import SwiftUI

struct RouteProgressView: View {
    @State private var progress: CGFloat = 0.4
    var orientation: MilestoneProgressView.Orientation
    var color: Color
    var route: Route
    
    var body: some View {
        MilestoneProgressView(progress: $progress, orientation: orientation, stops: route.stops, color: color)
    }
}

struct MilestoneProgressView: View {
    
    enum Orientation {
        case horizontal
        case vertical
    }
    
    @State private var radius: CGFloat = 5
    @State private var lineWidth: CGFloat = 5
    @Binding var progress: CGFloat
    var orientation: Orientation
    var stops: [RouteStop]
    var color: Color
    
    var body: some View {
        GeometryReader { bounds in
            ZStack {
                if orientation == .horizontal {
                    horizontalView(bounds: bounds, color: color)
                } else {
                    HStack {
                        verticalView(bounds: bounds, color: color)
                        Spacer()
                    }
                    ForEach(Array(stops.enumerated()), id: \.offset) { index, stop in
                        StopView(stop: stop)
                            .position(x: bounds.size.width / 2 + radius * 5, y: positionForStop(index: index, totalHeight: bounds.size.height))
                    }
                }
            }
        }
    }
    
    private func positionForStop(index: Int, totalHeight: CGFloat) -> CGFloat {
        let totalSpacing = totalHeight - (CGFloat(stops.count) * radius * 2)
        let spacing = totalSpacing / CGFloat(stops.count - 1)
        return (radius * 2 + spacing) * CGFloat(index) + radius
    }
    
    @ViewBuilder
    private func horizontalView(bounds: GeometryProxy, color: Color) -> some View {
        MilestoneShape(count: Int(stops.count), radius: radius, orientation: orientation)
            .stroke(lineWidth: lineWidth)
            .foregroundColor(color.opacity(0.2))
            .padding(.horizontal, lineWidth/2)
            .frame(height: radius*2)
            .overlay {
                MilestoneShape(count: Int(stops.count), radius: radius, orientation: orientation)
                    .stroke(lineWidth: lineWidth)
                    .foregroundColor(color)
                    .padding(.horizontal, lineWidth/2)
                    .mask(
                        HStack {
                            Rectangle()
                                .frame(width: bounds.size.width * progress, height: 1000, alignment: .leading)
                                .blur(radius: 2)
                            Spacer(minLength: 0)
                        }
                    )
            }
            .padding(.horizontal, lineWidth/2)
    }
    
    @ViewBuilder
    private func verticalView(bounds: GeometryProxy, color: Color) -> some View {
        MilestoneShape(count: Int(stops.count), radius: radius, orientation: orientation)
            .stroke(lineWidth: lineWidth)
            .foregroundColor(.black.opacity(0.3))
            .padding(.vertical, lineWidth/2)
            .frame(width: radius*2)
            .overlay {
                MilestoneShape(count: Int(stops.count), radius: radius, orientation: orientation)
                    .stroke(lineWidth: lineWidth)
                    .foregroundColor(color)
                    .padding(.vertical, lineWidth/2)
                    .mask(
                        VStack {
                            Rectangle()
                                .frame(width: 1000, height: bounds.size.height * progress, alignment: .top)
                                .blur(radius: 2)
                            Spacer(minLength: 0)
                        }
                    )
            }
            .padding(.vertical, lineWidth/2)
    }
    
    struct MilestoneShape: Shape {
        let count: Int
        let radius: CGFloat
        let orientation: Orientation
        
        func path(in rect: CGRect) -> Path {
            var path = Path()
            
            switch orientation {
            case .horizontal:
                path.move(to: CGPoint(x: 0, y: rect.midY))
                
                var maxX: CGFloat = 0
                let remainingSpace: CGFloat = rect.width - (CGFloat(count) * radius * 2)
                let lineLength: CGFloat = remainingSpace / CGFloat(count - 1)
                
                for i in 1...count {
                    path.addEllipse(in: CGRect(origin: CGPoint(x: maxX, y: rect.midY - radius), size: CGSize(width: radius*2, height: radius*2)))
                    maxX += radius*2
                    path.move(to: CGPoint(x: maxX, y: rect.midY))
                    if i != count {
                        maxX += lineLength
                        path.addLine(to: CGPoint(x: maxX, y: rect.midY))
                    }
                }
                
            case .vertical:
                var maxY: CGFloat = radius // Start from the top of the first circle
                let spaceBetweenCircles: CGFloat = (rect.height - (CGFloat(count) * radius * 2)) / CGFloat(count - 1)
                
                for i in 0..<count {
                    let circleCenter = CGPoint(x: rect.midX, y: maxY)
                    path.addEllipse(in: CGRect(x: circleCenter.x - radius, y: circleCenter.y - radius, width: radius * 2, height: radius * 2))
                    
                    if i < count - 1 { // If not the last circle, draw the line to the next
                        let nextCircleTop = circleCenter.y + radius + spaceBetweenCircles
                        path.move(to: CGPoint(x: rect.midX, y: circleCenter.y + radius)) // Move to the bottom of the current circle
                        path.addLine(to: CGPoint(x: rect.midX, y: nextCircleTop)) // Draw the line to the top of the next circle
                        maxY = nextCircleTop + radius // Update maxY to the top of the next circle
                    }
                }
            }
            return path
        }
    }
}

struct StopView: View {
    let stop: RouteStop
    
    var body: some View {
        HStack(alignment: .center) {
            Text("10:32")
                .bold()
                .padding(.leading)
            Text(stop.name)
                .padding(.leading, 5)
                .foregroundColor(.black)
                .font(.caption)
            Spacer()
        }
    }
}

#Preview {
    RouteProgressView(orientation: .horizontal, color: .red, route: ActiveRouteViewModel.sampleRoutes.first!)
}
