import SwiftUI

struct NotificationsView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        ZStack {
            
            Color.black
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                
                VStack(alignment: .leading, spacing: 25) {
                    
                    // MARK: - Header
                    HStack {
                        
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundStyle(.white)
                        }
                        .buttonStyle(.plain)
                        
                        Spacer()
                        
                        Text("Notifications")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                        
                        Spacer()
                        
                        // Keeps title centered
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundStyle(.clear)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 15)
                    
                    // MARK: - Notifications
                    
                    VStack(spacing: 14) {
                        
                        NotificationCard(
                            icon: "sparkles",
                            title: "New stories are waiting",
                            message: "Discover fresh movies, series and short films on Streamora."
                        )
                        
                        NotificationCard(
                            icon: "play.rectangle.fill",
                            title: "New content added",
                            message: "Check out the latest stories from independent creators."
                        )
                        
                        NotificationCard(
                            icon: "person.2.fill",
                            title: "Support new creators",
                            message: "Explore original content and discover your next favourite story."
                        )
                    }
                    .padding(.horizontal, 20)
                    
                    // MARK: - Empty State Message
                    
                    VStack(spacing: 10) {
                        
                        Image(systemName: "bell.slash")
                            .font(.system(size: 38))
                            .foregroundStyle(.gray)
                        
                        Text("You're all caught up")
                            .font(.headline)
                            .foregroundStyle(.white)
                        
                        Text("We'll let you know when something new happens.")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top, 25)
                    .padding(.bottom, 100)
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}


// MARK: - Notification Card

struct NotificationCard: View {
    
    let icon: String
    let title: String
    let message: String
    
    var body: some View {
        
        HStack(alignment: .top, spacing: 15) {
            
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundStyle(.purple)
                .frame(width: 42, height: 42)
                .background(
                    Color.purple.opacity(0.15)
                )
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 5) {
                
                Text(title)
                    .font(.headline)
                    .foregroundStyle(.white)
                
                Text(message)
                    .font(.subheadline)
                    .foregroundStyle(
                        .white.opacity(0.65)
                    )
                    .fixedSize(
                        horizontal: false,
                        vertical: true
                    )
            }
            
            Spacer()
        }
        .padding(16)
        .background(
            Color.white.opacity(0.08)
        )
        .clipShape(
            RoundedRectangle(cornerRadius: 16)
        )
    }
}


#Preview {
    NotificationsView()
}
