require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品情報の保存' do
    context '商品が登録できる場合' do
      it '商品名、商品説明、商品画像、カテゴリ、状態、配送料、発送元、発送までの日数、価格の入力があれば投稿できる' do
        @item
        expect(@item).to be_valid
      end
    end
    context '商品が登録できない場合' do
      it 'ユーザーが紐付いていなければ投稿できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end
      it '商品名が空では投稿できない' do
        @item.item_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Item name can't be blank"
      end
      it '商品説明が空では投稿できない' do
        @item.item_text = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Item text can't be blank"
      end
      it '商品画像が空では投稿できない' do
        @item.item_image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include "Item image can't be blank"
      end
      it 'カテゴリが空では投稿できない' do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Category can't be blank"
      end
      it 'カテゴリが1では投稿できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include 'Category must be other than 1'
      end
      it 'ステータスが空では投稿できない' do
        @item.status_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Status can't be blank"
      end
      it 'ステータスが1では投稿できない' do
        @item.status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include 'Status must be other than 1'
      end
      it '配送料が空では投稿できない' do
        @item.delivery_fee_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Delivery fee can't be blank"
      end
      it '配送料が1では投稿できない' do
        @item.delivery_fee_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include 'Delivery fee must be other than 1'
      end
      it '発送元が空では投稿できない' do
        @item.prefecture_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Prefecture can't be blank"
      end
      it '発送元が1では投稿できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include 'Prefecture must be other than 1'
      end
      it '発送日数が空では投稿できない' do
        @item.shipment_date_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Shipment date can't be blank"
      end
      it '発送日数が1では投稿できない' do
        @item.shipment_date_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include 'Shipment date must be other than 1'
      end
      it '価格が空では投稿できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Price can't be blank"
      end
      it '価格が全角数字では投稿できない' do
        @item.price = '３００'
        @item.valid?
        expect(@item.errors.full_messages).to include 'Price is not a number'
      end
      it '価格が半角英数混合では投稿できない' do
        @item.price = 'abc123'
        @item.valid?
        expect(@item.errors.full_messages).to include 'Price is not a number'
      end
      it '価格が半角英語では投稿できない' do
        @item.price = 'abc'
        @item.valid?
        expect(@item.errors.full_messages).to include 'Price is not a number'
      end
      it '価格が300未満では投稿できない' do
        @item.price = rand(1..299)
        @item.valid?
        expect(@item.errors.full_messages).to include 'Price must be greater than or equal to 300'
      end
      it '価格が10000000以上では投稿できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include 'Price must be less than or equal to 9999999'
      end
    end
  end
end