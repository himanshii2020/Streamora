import SwiftUI

struct ProfileView: View {
    
    // MARK: - Navigation Callbacks
    
    var onProfileTap: () -> Void = {}
    var onMyUploadsTap: () -> Void = {}
    var onMyListTap: () -> Void = {}
    var onUploadTap: () -> Void = {}
    var onNotificationTap: () -> Void = {}
    
    // MARK: - Authentication
    
    @ObservedObject private var auth = AuthManager.shared
    
    
    var body: some View {
        ZStack {
            
            Color.black
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                
                VStack(spacing: 0) {
                    
                    // MARK: - Streamora Header
                    
                    StreamoraTopHeader(
                        onProfileTap: {
                            onProfileTap()
                        },
                        onNotificationTap: {
                            onNotificationTap()
                        }
                    )
                    
                    
                    // MARK: - Profile Header
                    
                    profileHeader
                    
                    
                    // MARK: - Profile Stats
                    
                    profileStats
                    
                    
                    // MARK: - Account
                    
                    sectionTitle("Account")
                    
                    VStack(spacing: 0) {
                        
                        // My Uploads
                        Button {
                            onMyUploadsTap()
                        } label: {
                            ProfileRowContent(
                                icon: "film.fill",
                                title: "My Uploads",
                                subtitle: "Manage your uploaded content"
                            )
                        }
                        .buttonStyle(.plain)
                        
                        ProfileDivider()
                        
                        // My List
                        Button {
                            onMyListTap()
                        } label: {
                            ProfileRowContent(
                                icon: "heart.fill",
                                title: "My List",
                                subtitle: "Your saved movies and shows"
                            )
                        }
                        .buttonStyle(.plain)
                        
                        ProfileDivider()
                        
                        // Watch History
                        ProfileRow(
                            icon: "clock.arrow.circlepath",
                            title: "Watch History",
                            subtitle: "Recently watched content"
                        )
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 18)
                            .fill(Color.white.opacity(0.06))
                    )
                    .padding(.horizontal, 20)
                    
                    
                    // MARK: - Preferences
                    
                    sectionTitle("Preferences")
                    
                    VStack(spacing: 0) {
                        
                        ProfileRow(
                            icon: "gearshape.fill",
                            title: "Settings",
                            subtitle: "Manage your account preferences"
                        )
                        
                        ProfileDivider()
                        
                        // Notifications
                        Button {
                            onNotificationTap()
                        } label: {
                            ProfileRowContent(
                                icon: "bell.fill",
                                title: "Notifications",
                                subtitle: "Manage notification preferences"
                            )
                        }
                        .buttonStyle(.plain)
                        
                        ProfileDivider()
                        
                        ProfileRow(
                            icon: "moon.fill",
                            title: "Appearance",
                            subtitle: "Dark mode"
                        )
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 18)
                            .fill(Color.white.opacity(0.06))
                    )
                    .padding(.horizontal, 20)
                    
                    
                    // MARK: - Creator
                    
                    sectionTitle("Creator")
                    
                    VStack(spacing: 0) {
                        
                        // Upload Content
                        Button {
                            onUploadTap()
                        } label: {
                            ProfileRowContent(
                                icon: "plus.rectangle.fill",
                                title: "Upload Content",
                                subtitle: "Share your story with Streamora"
                            )
                        }
                        .buttonStyle(.plain)
                        
                        ProfileDivider()
                        
                        ProfileRow(
                            icon: "chart.bar.fill",
                            title: "Creator Analytics",
                            subtitle: "Track your content performance"
                        )
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 18)
                            .fill(Color.white.opacity(0.06))
                    )
                    .padding(.horizontal, 20)
                    
                    
                    // MARK: - Log Out
                    
                    Button {
                        auth.logout()
                    } label: {
                        HStack(spacing: 12) {
                            
                            Image(
                                systemName:
                                    "rectangle.portrait.and.arrow.right"
                            )
                            .font(
                                .system(
                                    size: 18,
                                    weight: .medium
                                )
                            )
                            
                            Text("Log Out")
                                .font(
                                    .system(
                                        size: 16,
                                        weight: .semibold
                                    )
                                )
                        }
                        .foregroundStyle(.red)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.red.opacity(0.08))
                        )
                    }
                    .buttonStyle(.plain)
                    .padding(.horizontal, 20)
                    .padding(.top, 30)
                    
                    
                    // Bottom spacing for navigation bar
                    Spacer()
                        .frame(height: 110)
                }
            }
        }
        .preferredColorScheme(.dark)
    }
    
    
    // MARK: - Profile Header
    
    private var profileHeader: some View {
        
        VStack(spacing: 14) {
            
            ZStack {
                
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [
                                Color.purple,
                                Color.purple.opacity(0.6)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(
                        width: 100,
                        height: 100
                    )
                
                Image(systemName: "person.fill")
                    .font(.system(size: 42))
                    .foregroundStyle(.white)
            }
            .overlay(
                Circle()
                    .stroke(
                        Color.white.opacity(0.15),
                        lineWidth: 2
                    )
            )
            
            
            // Username
            
            Text(
                auth.username.isEmpty
                ? "User"
                : auth.username
            )
            .font(
                .system(
                    size: 26,
                    weight: .bold
                )
            )
            .foregroundStyle(.white)
            
            
            Text("@streamora_user")
                .font(.system(size: 14))
                .foregroundStyle(.gray)
            
            
            // Edit Profile
            
            Button {
                // Edit profile functionality will be added later
            } label: {
                Text("Edit Profile")
                    .font(
                        .system(
                            size: 14,
                            weight: .semibold
                        )
                    )
                    .foregroundStyle(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 9)
                    .background(
                        Capsule()
                            .stroke(
                                Color.white.opacity(0.25),
                                lineWidth: 1
                            )
                    )
            }
            .buttonStyle(.plain)
            .padding(.top, 2)
        }
        .padding(.top, 30)
        .padding(.bottom, 28)
    }
    
    
    // MARK: - Profile Stats
    
    private var profileStats: some View {
        
        HStack(spacing: 0) {
            
            ProfileStat(
                value: "0",
                title: "Uploads"
            )
            
            ProfileStat(
                value: "0",
                title: "Followers"
            )
            
            ProfileStat(
                value: "0",
                title: "Following"
            )
        }
        .padding(.vertical, 18)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color.white.opacity(0.06))
        )
        .padding(.horizontal, 20)
        .padding(.bottom, 8)
    }
    
    
    // MARK: - Section Title
    
    private func sectionTitle(
        _ title: String
    ) -> some View {
        
        HStack {
            
            Text(title)
                .font(
                    .system(
                        size: 18,
                        weight: .bold
                    )
                )
                .foregroundStyle(.white)
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.top, 28)
        .padding(.bottom, 12)
    }
}


// MARK: - Profile Row Content

struct ProfileRowContent: View {
    
    let icon: String
    let title: String
    let subtitle: String
    
    var body: some View {
        
        HStack(spacing: 14) {
            
            ZStack {
                
                RoundedRectangle(cornerRadius: 10)
                    .fill(
                        Color.purple.opacity(0.15)
                    )
                    .frame(
                        width: 42,
                        height: 42
                    )
                
                Image(systemName: icon)
                    .font(
                        .system(
                            size: 18,
                            weight: .medium
                        )
                    )
                    .foregroundStyle(.purple)
            }
            
            
            VStack(
                alignment: .leading,
                spacing: 4
            ) {
                
                Text(title)
                    .font(
                        .system(
                            size: 15,
                            weight: .semibold
                        )
                    )
                    .foregroundStyle(.white)
                
                Text(subtitle)
                    .font(.system(size: 12))
                    .foregroundStyle(.gray)
                    .lineLimit(1)
            }
            
            
            Spacer()
            
            
            Image(systemName: "chevron.right")
                .font(
                    .system(
                        size: 12,
                        weight: .semibold
                    )
                )
                .foregroundStyle(
                    .gray.opacity(0.7)
                )
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
    }
}


// MARK: - Non-clickable Profile Row

struct ProfileRow: View {
    
    let icon: String
    let title: String
    let subtitle: String
    
    var body: some View {
        
        ProfileRowContent(
            icon: icon,
            title: title,
            subtitle: subtitle
        )
    }
}


// MARK: - Divider

struct ProfileDivider: View {
    
    var body: some View {
        
        Divider()
            .overlay(
                Color.white.opacity(0.06)
            )
            .padding(.leading, 72)
    }
}


// MARK: - Profile Stat

struct ProfileStat: View {
    
    let value: String
    let title: String
    
    var body: some View {
        
        VStack(spacing: 5) {
            
            Text(value)
                .font(
                    .system(
                        size: 20,
                        weight: .bold
                    )
                )
                .foregroundStyle(.white)
            
            Text(title)
                .font(.system(size: 12))
                .foregroundStyle(
                    .white.opacity(0.5)
                )
        }
        .frame(
            maxWidth: .infinity
        )
    }
}


// MARK: - Preview

#Preview {
    ProfileView(
        onProfileTap: {
            print("Profile tapped")
        },
        onMyUploadsTap: {
            print("My Uploads tapped")
        },
        onMyListTap: {
            print("My List tapped")
        },
        onUploadTap: {
            print("Upload Content tapped")
        },
        onNotificationTap: {
            print("Notifications tapped")
        }
    )
}
