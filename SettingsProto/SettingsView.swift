import SwiftUI

struct SettingTag: Hashable {
    var id: String
    var groupId: UUID
}

struct SettingsView: View {
    @State private var selectionDetails: SettingTag?
    @ScaledMetric private var subcontentSize = 28.0
    
    private let settings: [SettingsGroup]
    
    init(settings: [SettingsGroup]) {
        self.settings = settings
    }
    
    var body: some View {
        NavigationSplitView {
            List(selection: $selectionDetails) {
                ForEach(settings) { settingsGroup in
                    Section(settingsGroup.name ?? "") {
                        ForEach(settingsGroup.settings) { setting in
                            let subcontent = setting.subcontent.map { resolvedSubcontent($0) }
                            
                            LabeledContent {
                                if let subcontent,
                                   setting.displayStyle == .horizontalSpacedAlignedText {
                                    subcontent
                                }
                            } label: {
                                HStack {
                                    if let icon = setting.icon {
                                        if case let .inlineRoundedSquare(color) = icon.presentationStyle {
                                            RoundedRectangle(cornerRadius: 8, style: .circular)
                                                .fill(color)
                                                .aspectRatio(1, contentMode: .fit)
                                                .frame(width: subcontentSize)
                                                .overlay {
                                                    icon.icon
                                                        .resizable()
                                                        .scaledToFit()
                                                        .foregroundStyle(.white)
                                                        .padding(5)
                                                }
                                        } else if case .largeCircle = icon.presentationStyle {
                                            icon.icon
                                                .resizable()
                                                .scaledToFit()
                                                .clipShape(Circle())
                                                .frame(width: subcontentSize * 2)
                                                .padding(.horizontal, subcontentSize * 0.1 + 4)
                                        } else if case .inlineCustom = icon.presentationStyle {
                                            icon.icon
                                                .resizable()
                                                .scaledToFit()
                                                .padding(-4)
                                                .frame(height: subcontentSize)
                                        }
                                    }
                                    
                                    VStack(alignment: setting.displayStyle == .verticalLeadingAlignedText ? .leading : .center) {
                                        Text(setting.title)
                                            .font((setting.icon?.presentationStyle == .largeCircle) ? .title3 : nil)
                                        
                                        if let subcontent,
                                           setting.displayStyle == .verticalLeadingAlignedText {
                                            subcontent
                                                .font(.caption)
                                        }
                                    }
                                }
                                .padding(.leading, -8)
                            }
                            .tag(setting.hasDetailContent ? SettingTag(id: setting.id, groupId: settingsGroup.id) : nil)
                        }
                    }
                }
            }
            .padding(.top, -16)
            .listSectionSpacing(.custom(-4))
            .searchable(text: .constant(""), placement: .navigationBarDrawer)
            .navigationTitle("Settings")
        } detail: {
            if let selection, selection.hasDetailContent {
                SettingsView(settings: selection.detailSettings)
            }
        }
    }
    
    // MARK: - View Builders
    
    @ViewBuilder
    private func resolvedSubcontent(_ subcontent: SettingSubContent) -> some View {
        switch subcontent {
        case let .text(text):
            Text(text)
        case let .switch(isActive):
            Toggle("", isOn: .constant(isActive))
        case let .badge(content):
            Text(content)
                .foregroundStyle(.white)
                .padding(6)
                .background {
                    Circle().fill(Color.red)
                }
        }
    }
    
    // MARK: - Computed Variables
    
    private var selection: Setting? {
        guard let selectionDetails,
              let group = settings.first(where: {
                  $0.id == selectionDetails.groupId
              })
        else { return nil }
        
        return group.settings.first(where: {
            $0.id == selectionDetails.id
        })
    }
}

#Preview {
    SettingsView(settings: Setting.topLevelSettings)
}
