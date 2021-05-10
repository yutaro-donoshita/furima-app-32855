require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録がうまくいくとき' do
      it 'nickname, email, password, password_confirmation, 姓名とそのフリガナ, 誕生日があれば登録できる' do
        @user
        expect(@user).to be_valid
      end
      it 'メールアドレスに@が含まれれば登録できる' do
        @user.email = 'test@com'
        expect(@user).to be_valid
      end
      it 'パスワードが6文字以上で英数字混合であれば登録できる' do
        @user.password = '123qwe456qwe'
        @user.password_confirmation = @user.password
        expect(@user).to be_valid
      end
    end

    context '新規登録がうまくいかないとき' do
      # まずはpresence: trueのvalidationをチェック
      context '空欄が原因でうまくいかないとき' do
        it 'nicknameが空欄では登録できない' do
          @user.nickname = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Nicknameを入力してください")
        end
        it 'emailが空欄では登録できない' do
          @user.email = ''
          @user.valid?
          expect(@user.errors.full_messages).to include('Eメールを入力してください')
        end
        it 'passwordが空欄では登録できない' do
          @user.password = ''
          @user.valid?
          expect(@user.errors.full_messages).to include('パスワードを入力してください')
        end
        it 'password_confirmationが空欄では登録できない' do
          @user.password_confirmation = ''
          @user.valid?
          expect(@user.errors.full_messages).to include('パスワード（確認用）とパスワードの入力が一致しません')
        end
        it 'first_nameが空欄では登録できない' do
          @user.first_name = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("First nameを入力してください")
        end
        it 'first_name_kanaが空欄では登録できない' do
          @user.first_name_kana = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("First name kanaを入力してください")
        end
        it 'last_nameが空欄では登録できない' do
          @user.last_name = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Last nameを入力してください")
        end
        it 'last_name_kanaが空欄では登録できない' do
          @user.last_name_kana = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Last name kanaを入力してください")
        end
        it 'birth_dateが空欄では登録できない' do
          @user.birth_date = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Birth dateを入力してください")
        end
      end

      # 空欄以外のvalidation
      context '空欄以外が原因でうまくいかないとき' do
        context 'ユーザー情報が原因のとき' do
          it 'メールアドレスが一意でなければ登録できない' do
            @user.save
            @another_user = FactoryBot.build(:user)
            @another_user.email = @user.email
            @another_user.valid?
            expect(@another_user.errors.full_messages).to include('Eメールはすでに存在します')
          end
          it 'メールアドレスが@を含まなければ登録できない' do
            @user.email = 'EmailAddressWithoutAtSign'
            @user.valid?
            expect(@user.errors.full_messages).to include('Eメールには@を含めて設定してください')
          end
          it 'パスワードが6文字未満では登録できない' do
            @user.password = 'abc12'
            @user.password_confirmation = @user.password
            @user.valid?
            expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
          end
          it 'パスワードに半角英数字以外が含まれると登録できない' do
            @user.password = 'どうでしょう'
            @user.password_confirmation = @user.password
            @user.valid?
            expect(@user.errors.full_messages).to include('パスワードは半角英数字混合で設定してください')
          end
          it 'パスワードが半角英字だけでは登録できない' do
            @user.password = 'abcdefg'
            @user.password_confirmation = @user.password
            @user.valid?
            expect(@user.errors.full_messages).to include('パスワードは半角英数字混合で設定してください')
          end
          it 'パスワードが半角数字だけでは登録できない' do
            @user.password = '123456789'
            @user.password_confirmation = @user.password
            @user.valid?
            expect(@user.errors.full_messages).to include('パスワードは半角英数字混合で設定してください')
          end
          it 'パスワード（確認用）がパスワードと一致しなければ登録できない' do
            @user.password_confirmation += 'notequal'
            @user.valid?
            expect(@user.errors.full_messages).to include('パスワード（確認用）とパスワードの入力が一致しません')
          end
        end
        context '本人確認が原因のとき' do
          it '姓に半角文字が含まれると登録できない' do
            @user.first_name += 'ﾜﾚﾜﾚﾊｳﾁｭｳｼﾞﾝﾀﾞ'
            @user.valid?
            expect(@user.errors.full_messages).to include("First nameには全角文字を使用してください")
          end
          it '姓（フリガナ）半角文字が含まれると登録できない' do
            @user.first_name_kana += 'ﾜﾚﾜﾚﾊｳﾁｭｳｼﾞﾝﾀﾞ'
            @user.valid?
            expect(@user.errors.full_messages).to include("First name kanaには全角カタカナを使用してください")
          end
          it '姓（フリガナ）にカタカナ以外が含まれると登録できない' do
            @user.first_name_kana += 'これこれ'
            @user.valid?
            expect(@user.errors.full_messages).to include("First name kanaには全角カタカナを使用してください")
          end
          it '名に半角文字が含まれると登録できない' do
            @user.last_name += 'ﾜﾚﾜﾚﾊｳﾁｭｳｼﾞﾝﾀﾞ'
            @user.valid?
            expect(@user.errors.full_messages).to include("Last nameには全角文字を使用してください")
          end
          it '名（フリガナ）に半角文字が含まれると登録できない' do
            @user.last_name_kana += 'ﾜﾚﾜﾚﾊｳﾁｭｳｼﾞﾝﾀﾞ'
            @user.valid?
            expect(@user.errors.full_messages).to include("Last name kanaには全角カタカナを使用してください")
          end
          it '名（フリガナ）にカタカナ以外が含まれると登録できない' do
            @user.last_name_kana += 'これこれ'
            @user.valid?
            expect(@user.errors.full_messages).to include("Last name kanaには全角カタカナを使用してください")
          end
        end
      end
    end
  end
end