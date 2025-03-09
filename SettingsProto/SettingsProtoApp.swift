import SwiftUI

@main
struct SettingsProtoApp: App {
    func viewWithLabel(_ label: String) -> some View {
        Text(label.uppercased())
            .bold()
            .padding(8)
            .foregroundStyle(.white)
            .background {
                Circle()
                    .fill(LinearGradient(colors: [Color(red: 0.65, green: 0.67, blue: 0.72), Color(red: 0.53, green: 0.55, blue: 0.59)], startPoint: .top, endPoint: .bottom))
                    .stroke(Color(red: 0.11, green: 0.11, blue: 0.12), lineWidth: 2)
            }
    }
    
    var body: some Scene {
        WindowGroup {
//            ViewToImage {
//                ZStack {
//                    viewWithLabel("DC")
//                        .offset(x: -24)
//                    viewWithLabel("CG")
//                        .offset(x: -8)
//                    viewWithLabel("MC")
//                        .offset(x: 8)
//                    viewWithLabel("MC")
//                        .offset(x: 24)
//                }
//                .frame(width: 88, height: 40)
//            }
            SettingsView(settings: Setting.topLevelSettings)
        }
    }
}
