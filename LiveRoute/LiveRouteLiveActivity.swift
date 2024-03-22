//
//  LiveRouteLiveActivity.swift
//  LiveRoute
//
//  Created by Santiago Quihui on 20/03/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct LiveRouteAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var status: CGFloat
        var timeLeft: Int
    }
    
    // Fixed non-changing properties about your activity go here!
    var route: Route
}

struct LiveRouteLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: LiveRouteAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text("\(context.state.timeLeft) minutos hasta tu parada")
                        Text("Siguiendo \(context.attributes.route.name)")
                    }
                    Image("BusIcon\(context.attributes.route.color.rawValue.capitalized)")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding()
                }
                
                RouteProgressView(orientation: .horizontal, color: Color("Bus\(context.attributes.route.color.rawValue.capitalized)"), route: context.attributes.route)
                    .frame(height: 10)
                    .padding()
            }
            .padding()
//            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)
            
        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Image("BusIcon\(context.attributes.route.color.rawValue.capitalized)")
                }
                DynamicIslandExpandedRegion(.trailing) {
//                    Image("BusIcon\(context.attributes.route.color.rawValue.capitalized)")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    VStack {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("\(context.state.timeLeft) minutos hasta tu parada")
                                Text("Siguiendo \(context.attributes.route.name)")
                            }
                        }
                        
                        RouteProgressView(orientation: .horizontal, color: Color("Bus\(context.attributes.route.color.rawValue.capitalized)"), route: context.attributes.route)
                            .frame(height: 10)
                            .padding()
                    }
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.status)")
            } minimal: {
                Text("\(context.state.status)")
            }
//            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension LiveRouteAttributes {
    fileprivate static var preview: LiveRouteAttributes {
        LiveRouteAttributes(route: ActiveRouteViewModel.sampleRoutes.first!)
    }
}

extension LiveRouteAttributes.ContentState {
    fileprivate static var smiley: LiveRouteAttributes.ContentState {
        LiveRouteAttributes.ContentState(status: 0.5, timeLeft: 15)
    }
    
    fileprivate static var starEyes: LiveRouteAttributes.ContentState {
        LiveRouteAttributes.ContentState(status: 0.9, timeLeft: 15)
    }
}

#Preview("Notification", as: .content, using: LiveRouteAttributes.preview) {
    LiveRouteLiveActivity()
} contentStates: {
    LiveRouteAttributes.ContentState.smiley
    LiveRouteAttributes.ContentState.starEyes
}
