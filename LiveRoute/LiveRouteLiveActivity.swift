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
    var name: String
    var color: RouteColor
}

struct LiveRouteLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: LiveRouteAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text("\(context.state.timeLeft) minutos hasta tu parada")
                        Text("Siguiendo \(context.attributes.name)")
                    }
                }
                RouteProgressView()
                    .frame(height: 20)
                    .padding()
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.status)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.status)")
            } minimal: {
                Text("\(context.state.status)")
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension LiveRouteAttributes {
    fileprivate static var preview: LiveRouteAttributes {
        LiveRouteAttributes(name: "Ruta Revolución", color: .orange)
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
