class Gossip < ApplicationRecord
    validates :title, length: {in: 3..14}, presence: true
    validates :description, presence: true
    belongs_to :user
    has_many :gossip_tags
    has_many :tags, through: :gossip_tags
    has_many :comments
    has_many :likes
    has_many :liking_users, through: :likes, source: :user

    def like(user)
        self.likes.create(user: user) unless liked_by?(user)
      end

      def unlike(user)
        like = self.likes.find_by(user: user)
        like.destroy if like
      end

      def liked_by?(user)
        self.likes.exists?(user: user)
      end
end
