class Message < ApplicationRecord 
    validates :content, presence: true, length: { maximum: 255 }
    #validates :content 文字をもたせる
    #presence: true (カラを許さない)と length: { maximum: 255 } (255文字以内)
end
