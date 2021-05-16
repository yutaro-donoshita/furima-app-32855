class Item < ApplicationRecord
  belongs_to :user
  has_one :order
  has_one_attached :item_image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :delivery_fee
  belongs_to :prefecture
  belongs_to :shipment_date

  with_options presence: true do
    validates :item_name
    validates :item_text
    validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
    validates :item_image

    with_options numericality: { other_than: 1 } do
      validates :category_id
      validates :status_id
      validates :delivery_fee_id
      validates :prefecture_id
      validates :shipment_date_id
    end
  end
end

