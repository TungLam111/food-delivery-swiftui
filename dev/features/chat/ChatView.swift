// Copyright 2023 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import GoogleGenerativeAI
import MarkdownUI
import SwiftUI
import PhotosUI


struct ConversationScreen: View {

  @StateObject var viewModel: ConversationViewModel

  @State
  private var userPrompt = ""

  enum FocusedField: Hashable {
    case message
  }

  @FocusState
  var focusedField: FocusedField?

  var body: some View {
    VStack {
      ScrollViewReader { scrollViewProxy in
        List {
          ForEach(viewModel.messages) { message in
            MessageView(message: message)
          }
         
        }
        .listStyle(.plain)
        .onChange(of: viewModel.messages, perform: { newValue in
          if viewModel.hasError {
            // wait for a short moment to make sure we can actually scroll to the bottom
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
              withAnimation {
                scrollViewProxy.scrollTo("errorView", anchor: .bottom)
              }
              focusedField = .message
            }
          } else {
            guard let lastMessage = viewModel.messages.last else { return }

            // wait for a short moment to make sure we can actually scroll to the bottom
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
              withAnimation {
                scrollViewProxy.scrollTo(lastMessage.id, anchor: .bottom)
              }
              focusedField = .message
            }
          }
        })
      }
      InputField("Message...", text: $userPrompt) {
        Image(systemName: viewModel.busy ? "stop.circle.fill" : "arrow.up.circle.fill")
          .font(.title)
      }
      .focused($focusedField, equals: .message)
      .onSubmit { sendOrStop() }
    }
    .toolbar {
      ToolbarItem(placement: .primaryAction) {
        Button(action: newChat) {
          Image(systemName: "square.and.pencil")
        }
      }
    }
    .navigationTitle("Chat sample")
    .onAppear {
      focusedField = .message
    }
  }

  private func sendMessage() {
    Task {
      let prompt = userPrompt
      userPrompt = ""
      await viewModel.sendMessage(prompt, streaming: true)
    }
  }

  private func sendOrStop() {
    focusedField = nil

    if viewModel.busy {
      viewModel.stop()
    } else {
      sendMessage()
    }
  }

  private func newChat() {
    viewModel.startNewChat()
  }
}

struct BouncingDots: View {
  @State
  private var dot1YOffset: CGFloat = 0.0

  @State
  private var dot2YOffset: CGFloat = 0.0

  @State
  private var dot3YOffset: CGFloat = 0.0

  let animation = Animation.easeInOut(duration: 0.8)
    .repeatForever(autoreverses: true)

  var body: some View {
    HStack(spacing: 8) {
      Circle()
        .fill(Color.white)
        .frame(width: 10, height: 10)
        .offset(y: dot1YOffset)
        .onAppear {
          withAnimation(self.animation.delay(0.0)) {
            self.dot1YOffset = -5
          }
        }
      Circle()
        .fill(Color.white)
        .frame(width: 10, height: 10)
        .offset(y: dot2YOffset)
        .onAppear {
          withAnimation(self.animation.delay(0.2)) {
            self.dot2YOffset = -5
          }
        }
      Circle()
        .fill(Color.white)
        .frame(width: 10, height: 10)
        .offset(y: dot3YOffset)
        .onAppear {
          withAnimation(self.animation.delay(0.4)) {
            self.dot3YOffset = -5
          }
        }
    }
    .onAppear {
      let baseOffset: CGFloat = -2

      self.dot1YOffset = baseOffset
      self.dot2YOffset = baseOffset
      self.dot3YOffset = baseOffset
    }
  }
}

struct BouncingDots_Previews: PreviewProvider {
  static var previews: some View {
    BouncingDots()
      .frame(width: 200, height: 50)
      .background(.blue)
      .roundedCorner(10, corners: [.allCorners])
  }
}


extension SafetySetting.HarmCategory: CustomStringConvertible {
  public var description: String {
    switch self {
    case .dangerousContent: "Dangerous content"
    case .harassment: "Harassment"
    case .hateSpeech: "Hate speech"
    case .sexuallyExplicit: "Sexually explicit"
    case .unknown: "Unknown"
    case .unspecified: "Unspecified"
    }
  }
}

extension SafetyRating.HarmProbability: CustomStringConvertible {
  public var description: String {
    switch self {
    case .high: "High"
    case .low: "Low"
    case .medium: "Medium"
    case .negligible: "Negligible"
    case .unknown: "Unknown"
    case .unspecified: "Unspecified"
    }
  }
}

private struct SubtitleFormRow: View {
  var title: String
  var value: String

  var body: some View {
    VStack(alignment: .leading) {
      Text(title)
        .font(.subheadline)
      Text(value)
    }
  }
}

private struct SubtitleMarkdownFormRow: View {
  var title: String
  var value: String

  var body: some View {
    VStack(alignment: .leading) {
      Text(title)
        .font(.subheadline)
      Markdown(value)
    }
  }
}

private struct SafetyRatingsSection: View {
  var ratings: [SafetyRating]

  var body: some View {
    Section("Safety ratings") {
      List(ratings, id: \.self) { rating in
        HStack {
          Text("\(String(describing: rating.category))")
            .font(.subheadline)
          Spacer()
          Text("\(String(describing: rating.probability))")
        }
      }
    }
  }
}

struct ErrorDetailsView: View {
  var error: Error

  var body: some View {
    NavigationView {
      Form {
        switch error {
        case let GenerateContentError.internalError(underlying: underlyingError):
          Section("Error Type") {
            Text("Internal error")
          }

          Section("Details") {
            SubtitleFormRow(title: "Error description",
                            value: underlyingError.localizedDescription)
          }

        case let GenerateContentError.promptBlocked(response: generateContentResponse):
          Section("Error Type") {
            Text("Your prompt was blocked")
          }

          Section("Details") {
            if let reason = generateContentResponse.promptFeedback?.blockReason {
              SubtitleFormRow(title: "Reason for blocking", value: reason.rawValue)
            }

            if let text = generateContentResponse.text {
              SubtitleMarkdownFormRow(title: "Last chunk for the response", value: text)
            }
          }

          if let ratings = generateContentResponse.candidates.first?.safetyRatings {
            SafetyRatingsSection(ratings: ratings)
          }

        case let GenerateContentError.responseStoppedEarly(
          reason: finishReason,
          response: generateContentResponse
        ):

          Section("Error Type") {
            Text("Response stopped early")
          }

          Section("Details") {
            SubtitleFormRow(title: "Reason for finishing early", value: finishReason.rawValue)

            if let text = generateContentResponse.text {
              SubtitleMarkdownFormRow(title: "Last chunk for the response", value: text)
            }
          }

          if let ratings = generateContentResponse.candidates.first?.safetyRatings {
            SafetyRatingsSection(ratings: ratings)
          }

        case GenerateContentError.invalidAPIKey:
          Section("Error Type") {
            Text("Invalid API Key")
          }

          Section("Details") {
            SubtitleFormRow(title: "Error description", value: error.localizedDescription)
            SubtitleMarkdownFormRow(
              title: "Help",
              value: """
              Please provide a valid value for `API_KEY` in the `GenerativeAI-Info.plist` file.
              """
            )
          }

        case GenerateContentError.unsupportedUserLocation:
          Section("Error Type") {
            Text("Unsupported User Location")
          }

          Section("Details") {
            SubtitleFormRow(title: "Error description", value: error.localizedDescription)
            SubtitleMarkdownFormRow(
              title: "Help",
              value: """
              The API is unsupported in your location (country / territory); please see the list of
              [available regions](https://ai.google.dev/available_regions#available_regions).
              """
            )
          }

        default:
          Section("Error Type") {
            Text("Some other error")
          }

          Section("Details") {
            SubtitleFormRow(title: "Error description", value: error.localizedDescription)
          }
        }
      }
      .navigationTitle("Error details")
      .navigationBarTitleDisplayMode(.inline)
    }
  }
}

#Preview("Response Stopped Early") {
  let error = GenerateContentError.responseStoppedEarly(
    reason: .maxTokens,
    response: GenerateContentResponse(candidates: [
      CandidateResponse(content: ModelContent(role: "model", [
        """
        A _hypothetical_ model response.
        Cillum ex aliqua amet aliquip labore amet eiusmod consectetur reprehenderit sit commodo.
        """,
      ]),
      safetyRatings: [
        SafetyRating(category: .dangerousContent, probability: .high),
        SafetyRating(category: .harassment, probability: .low),
        SafetyRating(category: .hateSpeech, probability: .low),
        SafetyRating(category: .sexuallyExplicit, probability: .low),
      ],
      finishReason: FinishReason.maxTokens,
      citationMetadata: nil),
    ],
    promptFeedback: nil)
  )

  return ErrorDetailsView(error: error)
}

#Preview("Prompt Blocked") {
  let error = GenerateContentError.promptBlocked(
    response: GenerateContentResponse(candidates: [
      CandidateResponse(content: ModelContent(role: "model", [
        """
        A _hypothetical_ model response.
        Cillum ex aliqua amet aliquip labore amet eiusmod consectetur reprehenderit sit commodo.
        """,
      ]),
      safetyRatings: [
        SafetyRating(category: .dangerousContent, probability: .high),
        SafetyRating(category: .harassment, probability: .low),
        SafetyRating(category: .hateSpeech, probability: .low),
        SafetyRating(category: .sexuallyExplicit, probability: .low),
      ],
      finishReason: FinishReason.other,
      citationMetadata: nil),
    ],
    promptFeedback: nil)
  )

  return ErrorDetailsView(error: error)
}


struct RoundedCorner: Shape {
  var radius: CGFloat = .infinity
  var corners: UIRectCorner = .allCorners

  func path(in rect: CGRect) -> Path {
    let path = UIBezierPath(
      roundedRect: rect,
      byRoundingCorners: corners,
      cornerRadii: CGSize(width: radius, height: radius)
    )
    return Path(path.cgPath)
  }
}

extension View {
  func roundedCorner(_ radius: CGFloat, corners: UIRectCorner) -> some View {
    clipShape(RoundedCorner(radius: radius, corners: corners))
  }
}

struct MessageContentView: View {
  var message: ChatMessage

  var body: some View {
    if message.pending {
      BouncingDots()
    } else {
      Markdown(message.message)
        .markdownTextStyle {
          FontFamilyVariant(.normal)
          FontSize(.em(0.85))
          ForegroundColor(message.participant == .system ? Color(UIColor.label) : .white)
        }
        .markdownBlockStyle(\.codeBlock) { configuration in
          configuration.label
            .relativeLineSpacing(.em(0.25))
            .markdownTextStyle {
              FontFamilyVariant(.monospaced)
              FontSize(.em(0.85))
              ForegroundColor(Color(.label))
            }
            .padding()
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .markdownMargin(top: .zero, bottom: .em(0.8))
        }
    }
  }
}

struct MessageView: View {
  var message: ChatMessage

  var body: some View {
    HStack {
      if message.participant == .user {
        Spacer()
      }
      MessageContentView(message: message)
        .padding(10)
        .background(message.participant == .system
          ? Color(UIColor.systemFill)
          : Color(UIColor.systemBlue))
        .roundedCorner(10,
                       corners: [
                         .topLeft,
                         .topRight,
                         message.participant == .system ? .bottomRight : .bottomLeft,
                       ])
      if message.participant == .system {
        Spacer()
      }
    }
    .listRowSeparator(.hidden)
  }
}


public struct InputField<Label>: View where Label: View {
  @Binding
  private var text: String

  private var title: String?
  private var label: () -> Label

  @Environment(\.submitHandler)
  var submitHandler

  private func submit() {
    if let submitHandler {
      submitHandler()
    }
  }

  public init(_ title: String? = nil, text: Binding<String>,
              @ViewBuilder label: @escaping () -> Label) {
    self.title = title
    _text = text
    self.label = label
  }

  public var body: some View {
    VStack(alignment: .leading) {
      HStack(alignment: .bottom) {
        VStack(alignment: .leading) {
          TextField(
            title ?? "",
            text: $text,
            axis: .vertical
          )
          .padding(.vertical, 4)
          .onSubmit(submit)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .overlay {
          RoundedRectangle(
            cornerRadius: 8,
            style: .continuous
          )
          .stroke(Color(UIColor.systemFill), lineWidth: 1)
        }

        Button(action: submit, label: label)
          .padding(.bottom, 4)
      }
    }
    .padding(8)
  }
}



struct MultimodalInputFieldSubmitHandler: EnvironmentKey {
  static var defaultValue: (() -> Void)?
}

extension EnvironmentValues {
  var submitHandler: (() -> Void)? {
    get { self[MultimodalInputFieldSubmitHandler.self] }
    set { self[MultimodalInputFieldSubmitHandler.self] = newValue }
  }
}

public extension View {
  func onSubmit(submitHandler: @escaping () -> Void) -> some View {
    environment(\.submitHandler, submitHandler)
  }
}

public struct MultimodalInputField: View {
  @Binding public var text: String
  @Binding public var selection: [PhotosPickerItem]

  @Environment(\.submitHandler) var submitHandler

  @State private var selectedImages = [Image]()

  @State private var isChooseAttachmentTypePickerShowing = false
  @State private var isAttachmentPickerShowing = false

  private func showChooseAttachmentTypePicker() {
    isChooseAttachmentTypePickerShowing.toggle()
  }

  private func showAttachmentPicker() {
    isAttachmentPickerShowing.toggle()
  }

  private func submit() {
    if let submitHandler {
      submitHandler()
    }
  }

  public init(text: Binding<String>,
              selection: Binding<[PhotosPickerItem]>) {
    _text = text
    _selection = selection
  }

  public var body: some View {
    VStack(alignment: .leading) {
      HStack(alignment: .top) {
        Button(action: showChooseAttachmentTypePicker) {
          Image(systemName: "plus")
        }
        .padding(.top, 10)

        VStack(alignment: .leading) {
          TextField(
            "Upload an image, and then ask a question about it",
            text: $text,
            axis: .vertical
          )
          .padding(.vertical, 4)
          .onSubmit(submit)

          if selectedImages.count > 0 {
            ScrollView(.horizontal) {
              LazyHStack {
                ForEach(0 ..< selectedImages.count, id: \.self) { i in
                  HStack {
                    selectedImages[i]
                      .resizable()
                      .scaledToFill()
                      .frame(width: 50, height: 50)
                      .cornerRadius(8)
                  }
                }
              }
            }
            .frame(height: 50)
          }
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .overlay {
          RoundedRectangle(
            cornerRadius: 8,
            style: .continuous
          )
          .stroke(Color(UIColor.systemFill), lineWidth: 1)
        }

        Button(action: submit) {
          Text("Go")
        }
        .padding(.top, 8)
      }
    }
    .padding(.horizontal)
    .confirmationDialog(
      "Select an image",
      isPresented: $isChooseAttachmentTypePickerShowing,
      titleVisibility: .hidden
    ) {
      Button(action: showAttachmentPicker) {
        Text("Photo & Video Library")
      }
    }
    .photosPicker(isPresented: $isAttachmentPickerShowing, selection: $selection)
    .onChange(of: selection) { _ in
      Task {
        selectedImages.removeAll()

        for item in selection {
          if let data = try? await item.loadTransferable(type: Data.self) {
            if let uiImage = UIImage(data: data) {
              let image = Image(uiImage: uiImage)
              selectedImages.append(image)
            }
          }
        }
      }
    }
  }
}

#Preview {
  struct Wrapper: View {
    @State var userInput: String = ""
    @State var selectedItems = [PhotosPickerItem]()

    @State private var selectedImages = [Image]()

    var body: some View {
      MultimodalInputField(text: $userInput, selection: $selectedItems)
        .onChange(of: selectedItems) { _ in
          Task {
            selectedImages.removeAll()

            for item in selectedItems {
              if let data = try? await item.loadTransferable(type: Data.self) {
                if let uiImage = UIImage(data: data) {
                  let image = Image(uiImage: uiImage)
                  selectedImages.append(image)
                }
              }
            }
          }
        }

      List {
        ForEach(0 ..< $selectedImages.count, id: \.self) { i in
          HStack {
            selectedImages[i]
              .resizable()
              .scaledToFill()
              .frame(width: .infinity)
              .cornerRadius(8)
          }
        }
      }
    }
  }

  return Wrapper()
}
