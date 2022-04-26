//
//  ContentView.swift
//  Shared
//
//  Created by Alessa De Leon Chavez on 2022-04-01.
//

import SwiftUI
import AVFoundation

struct MeetingView: View {
    @Binding var scrum: DailyScrum
    @StateObject var scrumTimer = ScrumTimer()
    @StateObject var speechRecognizer = SpeechRecognizer()
    @State private var isRecording = false
     ///Audio
    private var player: AVPlayer { AVPlayer.sharedDingPlayer }
    
    var body: some View{
        ZStack {
            RoundedRectangle(cornerRadius: 16.0)
                .fill(scrum.theme.mainColor)
        VStack{
            MeetingHeaderView(secondsElapsed: scrumTimer.secondsElapsed, secondsRemaining: scrumTimer.secondsRemaining, theme: scrum.theme)
            MeetingTimerView(speakers: scrumTimer.speakers, isRecording: isRecording, theme: scrum.theme)
 Circle()
                .strokeBorder(lineWidth:24, antialiased: true)
            MeetingFooterView(speakers: scrumTimer.speakers, skipAction: scrumTimer.skipSpeaker)
        }
        }
        .padding()
        .foregroundColor(scrum.theme.accentColor)
        //.navigationBarTitleDisplayMode(.inline)
        .onAppear {
            scrumTimer.reset(lengthInMinutes: scrum.lengthInMinutes, attendees: scrum.attendees)
            scrumTimer.speakerChangeAction = {
                player.seek(to: .zero)
                player.play()
            }
            speechRecognizer.reset()
            speechRecognizer.transcribe()
            isRecording = true
            scrumTimer.startScrum()
        }
                    .onDisappear {
                        scrumTimer.stopScrum()
                        speechRecognizer.stopTranscribing()
                        isRecording = false
                        let newHistory = History(attendees: scrum.attendees, lengthInMinutes: scrum.timer.secondsElapsed / 60, transcript: speechRecognizer.transcript)
                        scrum.history.insert(newHistory, at: 0)
                    }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MeetingView_Previews: PreviewProvider{
    static var previews: some View{
        MeetingView(scrum: .constant(DailyScrum.sampleData[0]))
    }
}
    
