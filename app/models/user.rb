class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :comments, foreign_key: :author_id, dependent: :destroy
  has_many :posts, foreign_key: :author_id, dependent: :destroy
  has_many :likes, foreign_key: :author_id, dependent: :destroy

  after_initialize :init

  validates :name, presence: true, length: { minimum: 3 }
  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def self.recent_posts(user_id)
    Post.where('author_id = ?', user_id).order(id: :desc).limit(3)
  end

  def self.all_posts(user)
    Post.where('author_id = ?', user.id).order(id: :desc)
  end

  def init
    self.posts_counter ||= 0 # will set the default value only if it's nil
  end
end
