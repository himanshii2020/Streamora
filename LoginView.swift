import SwiftUI

struct LoginView: View {

    @ObservedObject private var auth =
        AuthManager.shared

    @State private var username = ""
    @State private var password = ""

    @State private var showPassword = false
    @State private var showSignUp = false
    @State private var showError = false

    var body: some View {

        ZStack {

            Color.black
                .ignoresSafeArea()

            ScrollView(
                .vertical,
                showsIndicators: false
            ) {

                VStack(spacing: 0) {

                    Spacer()
                        .frame(height: 90)


                    // MARK: STREAMORA LOGO

                    VStack(spacing: 8) {

                        HStack(spacing: 2) {

                            Text("STREAM")

                            Image(
                                systemName:
                                    "play.circle.fill"
                            )
                            .foregroundStyle(.purple)

                            Text("RA")
                        }
                        .font(.system(
                            size: 28,
                            weight: .bold
                        ))
                        .tracking(3)
                        .foregroundStyle(.white)

                        Text("Where new stories begin")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundStyle(.purple)
                    }


                    Spacer()
                        .frame(height: 55)


                    // MARK: WELCOME

                    VStack(
                        alignment: .leading,
                        spacing: 8
                    ) {

                        Text("Welcome back")
                            .font(.system(
                                size: 30,
                                weight: .bold
                            ))
                            .foregroundStyle(.white)

                        Text(
                            "Login to continue your Streamora journey."
                        )
                        .font(.subheadline)
                        .foregroundStyle(
                            .white.opacity(0.6)
                        )
                    }
                    .frame(
                        maxWidth: .infinity,
                        alignment: .leading
                    )


                    Spacer()
                        .frame(height: 30)


                    // MARK: USERNAME

                    VStack(
                        alignment: .leading,
                        spacing: 8
                    ) {

                        Text("Username")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)

                        TextField(
                            "Enter your username",
                            text: $username
                        )
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .foregroundStyle(.white)
                        .padding(.horizontal, 16)
                        .frame(height: 52)
                        .background(
                            Color.white.opacity(0.08)
                        )
                        .clipShape(
                            RoundedRectangle(
                                cornerRadius: 12
                            )
                        )
                        .overlay(
                            RoundedRectangle(
                                cornerRadius: 12
                            )
                            .stroke(
                                Color.white.opacity(0.12),
                                lineWidth: 1
                            )
                        )
                    }


                    Spacer()
                        .frame(height: 20)


                    // MARK: PASSWORD

                    VStack(
                        alignment: .leading,
                        spacing: 8
                    ) {

                        Text("Password")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)

                        HStack {

                            if showPassword {

                                TextField(
                                    "Enter your password",
                                    text: $password
                                )
                                .textInputAutocapitalization(.never)
                                .autocorrectionDisabled()

                            } else {

                                SecureField(
                                    "Enter your password",
                                    text: $password
                                )
                            }

                            Button {

                                showPassword.toggle()

                            } label: {

                                Image(
                                    systemName:
                                        showPassword
                                        ? "eye.slash"
                                        : "eye"
                                )
                                .foregroundStyle(
                                    .white.opacity(0.6)
                                )
                            }
                            .buttonStyle(.plain)
                        }
                        .foregroundStyle(.white)
                        .padding(.horizontal, 16)
                        .frame(height: 52)
                        .background(
                            Color.white.opacity(0.08)
                        )
                        .clipShape(
                            RoundedRectangle(
                                cornerRadius: 12
                            )
                        )
                        .overlay(
                            RoundedRectangle(
                                cornerRadius: 12
                            )
                            .stroke(
                                Color.white.opacity(0.12),
                                lineWidth: 1
                            )
                        )
                    }


                    // MARK: ERROR

                    if showError {

                        Text(
                            "Incorrect username or password."
                        )
                        .font(.caption)
                        .foregroundStyle(.red)
                        .frame(
                            maxWidth: .infinity,
                            alignment: .leading
                        )
                        .padding(.top, 12)
                    }


                    Spacer()
                        .frame(height: 28)


                    // MARK: LOGIN BUTTON

                    Button {

                        let success = auth.login(
                            username: username
                                .trimmingCharacters(
                                    in: .whitespacesAndNewlines
                                ),
                            password: password
                        )

                        if !success {
                            showError = true
                        }

                    } label: {

                        Text("Login")
                            .font(.system(
                                size: 17,
                                weight: .semibold
                            ))
                            .foregroundStyle(.white)
                            .frame(
                                maxWidth: .infinity
                            )
                            .frame(height: 54)
                            .background(
                                Color.purple
                            )
                            .clipShape(
                                RoundedRectangle(
                                    cornerRadius: 13
                                )
                            )
                    }
                    .buttonStyle(.plain)


                    Spacer()
                        .frame(height: 24)


                    // MARK: SIGN UP

                    HStack(spacing: 5) {

                        Text("First time on Streamora?")
                            .foregroundStyle(
                                .white.opacity(0.6)
                            )

                        Button {

                            showSignUp = true

                        } label: {

                            Text("Sign Up")
                                .fontWeight(.semibold)
                                .foregroundStyle(.purple)
                        }
                        .buttonStyle(.plain)
                    }
                    .font(.subheadline)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 50)
            }
        }
        .sheet(isPresented: $showSignUp) {
            SignUpView()
        }
        .preferredColorScheme(.dark)
    }
}


#Preview {
    LoginView()
}
