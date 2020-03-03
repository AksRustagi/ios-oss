import Foundation
import Library
import Prelude

final class CategorySelectionHeaderView: UIView {
  // MARK: - Properties

  private lazy var imageView = { UIImageView(frame: .zero)
    |> \.translatesAutoresizingMaskIntoConstraints .~ false
  }()

  private lazy var rootStackView = {
    UIStackView(frame: .zero)
      |> \.translatesAutoresizingMaskIntoConstraints .~ false
  }()

  private lazy var stepLabel = { UILabel(frame: .zero) }()
  private lazy var subtitleLabel = { UILabel(frame: .zero) }()
  private lazy var titleLabel = { UILabel(frame: .zero) }()

  init(frame: CGRect, context: HeaderViewContext) {
    super.init(frame: frame)

    self.setupViews()
    self.bindStyles()
  }

  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func bindStyles() {
    super.bindStyles()

    _ = self
      |> \.backgroundColor .~ UIColor.ksr_trust_700

    _ = self.rootStackView
      |> rootStackViewStyle

    _ = self.titleLabel
      |> titleLabelStyle

    _ = self.subtitleLabel
      |> subtitleLabelStyle

    _ = self.stepLabel
      |> stepLabelStyle

    _ = self.imageView
      |> imageViewStyle
  }

  private func setupViews() {
    _ = (self.rootStackView, self)
      |> ksr_addSubviewToParent()

    _ = ([stepLabel, titleLabel, subtitleLabel], self.rootStackView)
      |> ksr_addArrangedSubviewsToStackView()

    _ = (self.imageView, self)
      |> ksr_addSubviewToParent()

    NSLayoutConstraint.activate([
      self.rootStackView.leftAnchor.constraint(equalTo: self.leftAnchor),
      self.rootStackView.rightAnchor.constraint(equalTo: self.rightAnchor),
      self.rootStackView.topAnchor.constraint(equalTo: self.topAnchor),
      self.imageView.leftAnchor.constraint(equalTo: self.leftAnchor),
      self.imageView.rightAnchor.constraint(equalTo: self.rightAnchor),
      self.imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      self.imageView.topAnchor.constraint(equalTo: self.rootStackView.bottomAnchor)
    ])

    _ = (self.stepLabel, self.rootStackView)
      |> ksr_setCustomSpacing(Styles.grid(1))
  }
}

// MARK: - Styles

private let rootStackViewStyle: StackViewStyle = { stackView in
  stackView
    |> verticalStackViewStyle
    |> \.distribution .~ .fill
    |> \.alignment .~ .fill
    |> \.spacing .~ Styles.grid(2)
    |> \.isLayoutMarginsRelativeArrangement .~ true
    |> \.layoutMargins .~ .init(topBottom: Styles.grid(0), leftRight: Styles.grid(3))
}

private let titleLabelStyle: LabelStyle = { label in
  label
    |> \.font .~ UIFont.ksr_title3().bolded
    |> \.textColor .~ .white
    |> \.lineBreakMode .~ .byTruncatingTail
    |> \.numberOfLines .~ 2
    |> \.text %~ { _ in Strings.Which_categories_interest_you() }
}

private let subtitleLabelStyle: LabelStyle = { label in
  label
    |> \.font .~ UIFont.ksr_subhead()
    |> \.textColor .~ .white
    |> \.lineBreakMode .~ .byTruncatingTail
    |> \.numberOfLines .~ 2
    |> \.text %~ { _ in Strings.Select_up_to_five() }
}

private let stepLabelStyle: LabelStyle = { label in
  label
    |> \.font .~ UIFont.ksr_footnote()
    |> \.textColor .~ .white
    |> \.lineBreakMode .~ .byTruncatingTail
    |> \.numberOfLines .~ 1
    |> \.text %~ { _ in Strings.Step_number(current_step: "1", total_steps: "2") }
}

private let imageViewStyle: ImageViewStyle = { imageView in
  imageView
    |> UIImageView.lens.contentMode .~ .scaleAspectFill
    |> UIImageView.lens.image .~ image(named: "shapes")
}
