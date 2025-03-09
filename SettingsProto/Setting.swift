import SwiftUI

enum IconPresentationStyle: Equatable {
    case inlineRoundedSquare(Color)
    case largeCircle
    case inlineCustom
}

enum SettingDisplayStyle {
    case verticalLeadingAlignedText
    case horizontalSpacedAlignedText
}

enum SettingSubContent {
    case text(String)
    case badge(String)
    case `switch`(Bool)
    
    var id: String {
        switch self {
        case let .text(text): "text-\(text)"
        case let .badge(text): "badge-\(text)"
        case let .switch(isActive): "switch-\(isActive)"
        }
    }
}

struct SettingIcon {
    var icon: Image
    var presentationStyle: IconPresentationStyle
}

struct Setting: Identifiable {
    var title: String
    var subcontent: SettingSubContent?
    var icon: SettingIcon?
    var displayStyle: SettingDisplayStyle = .horizontalSpacedAlignedText
    var detailSettings: [SettingsGroup] = []
    
    var hasDetailContent: Bool {
        !detailSettings.isEmpty
    }
    
    var id: String { title + (subcontent?.id ?? "") }
    
    static let topLevelSettings = [
        SettingsGroup(settings: [
            Setting(title: "Jordan Christensen", subtitle: "Apple ID, iCloud+, Media & Purchases", icon: Image("jordan-icon"), iconPresentationStyle: .largeCircle, displayStyle: .verticalLeadingAlignedText),
            Setting(title: "Family", icon: Image("family"), iconPresentationStyle: .inlineCustom),
            Setting(title: "Apple News+ Free for 3 Months")
        ]),
        SettingsGroup(settings: [
            Setting(title: "Software Update Available", badgeLabel: "1", displayStyle: .horizontalSpacedAlignedText, detailSettings: [SettingsGroup(settings: [
                Setting(title: "Hi")
            ])])
        ]),
        SettingsGroup(settings: [
            Setting(title: "Airplane Mode", subcontent: .switch(false), icon: SettingIcon(icon: Image(systemName: "airplane"), presentationStyle: .inlineRoundedSquare(.orange)), displayStyle: .horizontalSpacedAlignedText, detailSettings: []),
            Setting(title: "Wi-Fi", subtitle: "Christensens", icon: Image(systemName: "wifi"), iconPresentationStyle: .inlineRoundedSquare(.blue)),
            Setting(title: "Bluetooth", subtitle: "On", icon: Image(systemName: "link.icloud.fill"), iconPresentationStyle: .inlineRoundedSquare(.blue)),
            Setting(title: "Cellular", icon: Image(systemName: "antenna.radiowaves.left.and.right"), iconPresentationStyle: .inlineRoundedSquare(.green)),
            Setting(title: "Personal Hotspot", icon: Image(systemName: "personalhotspot"), iconPresentationStyle: .inlineRoundedSquare(.green))
        ]),
        SettingsGroup(settings: [
            Setting(title: "Notifications", icon: Image(systemName: "bell.badge.fill"), iconPresentationStyle: .inlineRoundedSquare(.red)),
            Setting(title: "Sounds & Haptics", icon: Image(systemName: "speaker.wave.3.fill"), iconPresentationStyle: .inlineRoundedSquare(.red)),
            Setting(title: "Focus", icon: Image(systemName: "moon.fill"), iconPresentationStyle: .inlineRoundedSquare(.purple)),
            Setting(title: "Screen Time", icon: Image(systemName: "hourglass"), iconPresentationStyle: .inlineRoundedSquare(.purple)),
        ])
    ]
}

extension Setting {
    init(title: String, subtitle: String, icon: SettingIcon? = nil, displayStyle: SettingDisplayStyle = .horizontalSpacedAlignedText, detailSettings: [SettingsGroup] = []) {
        self.init(title: title, subcontent: .text(subtitle), icon: icon, displayStyle: displayStyle, detailSettings: detailSettings)
    }
    
    init(title: String, subtitle: String, icon: Image, iconPresentationStyle: IconPresentationStyle, displayStyle: SettingDisplayStyle = .horizontalSpacedAlignedText, detailSettings: [SettingsGroup] = []) {
        self.init(title: title, subtitle: subtitle, icon: SettingIcon(icon: icon, presentationStyle: iconPresentationStyle), displayStyle: displayStyle, detailSettings: detailSettings)
    }
    
    init(title: String, badgeLabel: String, icon: SettingIcon? = nil, displayStyle: SettingDisplayStyle = .horizontalSpacedAlignedText, detailSettings: [SettingsGroup] = []) {
        self.init(title: title, subcontent: .badge(badgeLabel), icon: icon, displayStyle: displayStyle, detailSettings: detailSettings)
    }
    
    init(title: String, badgeLabel: String, icon: Image, iconPresentationStyle: IconPresentationStyle, displayStyle: SettingDisplayStyle = .horizontalSpacedAlignedText, detailSettings: [SettingsGroup] = []) {
        self.init(title: title, subcontent: .badge(badgeLabel), icon: SettingIcon(icon: icon, presentationStyle: iconPresentationStyle), displayStyle: displayStyle, detailSettings: detailSettings)
    }
    
    init(title: String, icon: Image, iconPresentationStyle: IconPresentationStyle, displayStyle: SettingDisplayStyle = .horizontalSpacedAlignedText, detailSettings: [SettingsGroup] = []) {
        self.init(title: title, icon: SettingIcon(icon: icon, presentationStyle: iconPresentationStyle), displayStyle: displayStyle, detailSettings: detailSettings)
    }
}

struct SettingsGroup: Identifiable {
    var settings: [Setting]
    var name: String? = nil
    let id = UUID()
}

#Preview {
    SettingsView(settings: Setting.topLevelSettings)
}
