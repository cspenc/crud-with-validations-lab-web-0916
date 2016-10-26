class Song < ActiveRecord::Base
  validates :title, presence: true
  validates :title, uniqueness: {
    scope: [:release_year, :artist_name],
    message: 'Cannot release the same song multiple times in one year.'
  }
  validates :released, inclusion: {in: [true, false]}
  validates :artist_name, presence: true
  validates :genre, presence: true
  validate :optional_release
  validate :no_future_release

  def optional_release
    if released == true && !release_year
      errors.add(:release_year, "Must have release year if song has been released")
    end
  end

  def no_future_release
    if release_year && release_year > Time.now.year
      errors.add(:release_year, "Release year cannot be in the future")
    end
  end

end
