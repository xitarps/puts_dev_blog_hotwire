class Article < ApplicationRecord
  belongs_to :user
  has_many :likes

  after_create_commit { 
    broadcast_prepend_to(
      "home_stream",
      target: 'home_articles_list',
      partial: 'articles/article',
      locals: {
        article: self,
        current_user_tmp: nil
      }
    )
  }
end
