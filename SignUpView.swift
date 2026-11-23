import SwiftUI

struct SignUpView: View {

    @Environment(\.dismiss) private var dismiss

    @ObservedObject private var auth =
        AuthManager.shared

    @State private var username = ""
    @State private var password = ""
    @State private var confirmPassword = ""

    @State private var showPassword = false
    @State private var showConfirmPassword = false

    @State private var errorMessage = ""

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
                        .frame(height: 45)


                    // MARK: HEADER

                    HStack {

                        Button {

                            dismiss()

                        } label: {

                            Image(
                                systemName:
                                    "chevron.left"
                            )
                            .font(.system(
                                size: 20,
                                weight: .semibold
                            ))
                            .foregroundStyle(.white)
                        }
                        .buttonStyle(.plain)

                        Spacer()
                    }


                    Spacer()
                        .frame(height: 30)


                    VStack(
                        alignment: .leading,
                        spacing: 8
                    ) {

                        Text("Create your account")
                            .font(.system(
                                size: 30,
                                weight: .bold
                            ))
                            .foregroundStyle(.white)

                        Text(
                            "Choose a username and password to get started."
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
                            "Choose a username",
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

                        Text("Set Password")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)

                        HStack {

                            if showPassword {

                                TextField(
                                    "Create a password",
                                    text: $password
                                )
                                .textInputAutocapitalization(.never)
                                .autocorrectionDisabled()

                            } else {

                                SecureField(
                                    "Create a password",
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


                    Spacer()
                        .frame(height: 20)


                    // MARK: CONFIRM PASSWORD

                    VStack(
                        alignment: .leading,
                        spacing: 8
                    ) {

                        Text("Confirm Password")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)

                        HStack {

                            if showConfirmPassword {

                                TextField(
                                    "Confirm your password",
                                    text: $confirmPassword
                                )
                                .textInputAutocapitalization(.never)
                                .autocorrectionDisabled()

                            } else {

                                SecureField(
                                    "Confirm your password",
                                    text: $confirmPassword
                                )
                            }

                            Button {

                                showConfirmPassword.toggle()

                            } label: {

                                Image(
                                    systemName:
                                        showConfirmPassword
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

                    if !errorMessage.isEmpty {

                        Text(errorMessage)
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


                    // MARK: SIGN UP BUTTON

                    Button {

                        createAccount()

                    } label: {

                        Text("Create Account")
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
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 50)
            }
        }
        .preferredColorScheme(.dark)
    }


    // MARK: - CREATE ACCOUNT

    private func createAccount() {

        let cleanUsername =
            username.trimmingCharacters(
                in: .whitespacesAndNewlines
            )

        if cleanUsername.isEmpty {

            errorMessage =
                "Please enter a username."

            return
        }

        if password.isEmpty {

            errorMessage =
                "Please create a password."

            return
        }

        if password.count < 6 {

            errorMessage =
                "Password must contain at least 6 characters."

            return
        }

        if password != confirmPassword {

            errorMessage =
                "Passwords do not match."

            return
        }

        auth.signUp(
            username: cleanUsername,
            password: password
        )

        dismiss()
    }
}


#Preview {
    SignUpView()
}
