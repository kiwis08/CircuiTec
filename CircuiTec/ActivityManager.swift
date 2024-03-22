//
//  ActivityManager.swift
//  CircuiTec
//
//  Created by Santiago Quihui on 22/03/24.
//

import ActivityKit
import Combine
import Foundation

final class ActivityManager: ObservableObject {
    @MainActor @Published private(set) var activityID: String?
    @MainActor @Published private(set) var activityToken: String?
    
    static let shared = ActivityManager()
    
    func start(route: Route) async {
        await endActivity()
        await startNewLiveActivity(route: route)
    }
    
    private func startNewLiveActivity(route: Route) async {
        let attributes = LiveRouteAttributes(route: route)
        
        let initialContentState = ActivityContent(state: LiveRouteAttributes.ContentState(status: 0, timeLeft: 15),
                                                  staleDate: nil)
        
        do {
            let activity = try Activity.request(
                attributes: attributes,
                content: initialContentState,
                pushType: .token
            )
            
            await MainActor.run { activityID = activity.id }
            
            for await data in activity.pushTokenUpdates {
                let token = data.map {String(format: "%02x", $0)}.joined()
                print("Activity token: \(token)")
                await MainActor.run { activityToken = token }
                // HERE SEND THE TOKEN TO THE SERVER
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func updateActivityRandomly() async {
        guard let activityID = await activityID,
              let runningActivity = Activity<LiveRouteAttributes>.activities.first(where: { $0.id == activityID }) else {
            return
        }
        let newRandomContentState = LiveRouteAttributes.ContentState(status: 0.7, timeLeft: 2)
        await runningActivity.update(using: newRandomContentState)
    }
    
    func endActivity() async {
        guard let activityID = await activityID,
              let runningActivity = Activity<LiveRouteAttributes>.activities.first(where: { $0.id == activityID }) else {
            return
        }
        let initialContentState = LiveRouteAttributes.ContentState(status: 1, timeLeft: 0)

        await runningActivity.end(
            ActivityContent(state: initialContentState, staleDate: Date.distantFuture),
            dismissalPolicy: .immediate
        )
        
        await MainActor.run {
            self.activityID = nil
            self.activityToken = nil
        }
    }
    
    func cancelAllRunningActivities() async {
        for activity in Activity<LiveRouteAttributes>.activities {
            let initialContentState = LiveRouteAttributes.ContentState(status: 1, timeLeft: 0)
            
            await activity.end(
                ActivityContent(state: initialContentState, staleDate: Date()),
                dismissalPolicy: .immediate
            )
        }
        
        await MainActor.run {
            activityID = nil
            activityToken = nil
        }
    }
    
}
