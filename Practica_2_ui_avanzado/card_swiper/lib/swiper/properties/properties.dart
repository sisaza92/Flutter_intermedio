/// Class to define the direction in which the widget can be swiped
class AllowedSwipeDirection {
  /// Allow the card to be swiped in both the left and right directions
  const AllowedSwipeDirection.all()
      : right = true,
        left = true;

  /// Does not allow the card to be swiped in any direction
  const AllowedSwipeDirection.none()
      : right = false,
        left = false;

  /// Allow the card to be swiped in only the specified directions
  const AllowedSwipeDirection.only({
    this.left = false,
    this.right = false,
  });

  /// Set to true to allow the card to be swiped in the left direction
  final bool left;

  /// Set to true to allow the card to be swiped in the right direction
  final bool right;
}
