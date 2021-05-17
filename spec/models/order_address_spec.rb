require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  describe '商品購入' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @order_address = FactoryBot.build(:order_address, user_id: user.id, item_id: item.id)
      sleep 0.1 # 0.1秒待機
    end

    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば購入できること' do
        @order_address
        expect(@order_address).to be_valid
      end
      it '建物名は空でも購入できること' do
        @order_address.building = ''
        expect(@order_address).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'tokenが空では購入できないこと' do
        @order_address.token = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Tokenを入力してください")
      end
      it 'user_idが空では購入できないこと' do
        @order_address.user_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Userを入力してください")
      end
      it 'item_idが空では購入できないこと' do
        @order_address.item_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Itemを入力してください")
      end
      it 'postal_codeが空だと購入できないこと' do
        @order_address.postal_code = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal codeを入力してください")
      end
      it 'postal_codeが半角のハイフンを含んだ正しい形式でないと購入できないこと' do
        @order_address.postal_code = '1234567'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal codeis invalid. Include hyphen(-)")
      end
      it 'prefectureを選択していないと購入できないこと' do
        @order_address.prefecture_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Prefectureを入力してください")
      end
      it 'prefectureが1だと購入できないこと' do
        @order_address.prefecture_id = 1
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Prefectureは1以外の値にしてください")
      end
      it 'cityは空だと購入できないこと' do
        @order_address.city = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Cityを入力してください")
      end
      it 'addressは空だと購入できないこと' do
        @order_address.address = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Addressを入力してください")
      end
      it '電話番号は空だと購入できないこと' do
        @order_address.phone_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone numberを入力してください")
      end
      it '電話番号は英語だと購入できないこと' do
        @order_address.phone_number = 'abcdefghijk'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone numberは不正な値です")
      end
      it '電話番号はハイフンがあると購入できないこと' do
        @order_address.phone_number = '090-1234-5678'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone numberは不正な値です")
      end
      it '電話番号は全角だと購入できないこと' do
        @order_address.phone_number = '０９０１２３４５６７８'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone numberは不正な値です")
      end
      it '電話番号は12桁より大きいと購入できないこと' do
        @order_address.phone_number = '090123456789'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone numberは不正な値です")
      end
    end
  end
end