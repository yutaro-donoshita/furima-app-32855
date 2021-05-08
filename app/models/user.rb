class User < ApplicationRecord
  has_many :items
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # 全カラム必須とする
  with_options presence: true do
    validates :nickname
    validates :email
    validates :password
    validates :first_name
    validates :first_name_kana
    validates :last_name
    validates :last_name_kana
    validates :birth_date
  end

  # ユーザー情報のvalidation
  EMAIL_REGEX = /.+@.+/.freeze
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze

  validates_format_of :email, with: EMAIL_REGEX, message: 'には@を含めて設定してください'
  validates_format_of :password, with: PASSWORD_REGEX, message: 'は半角英数字混合で設定してください'
  validates :password, length: { minimum: 6 }

  # 本人情報確認のvalidation
  REALNAME_REGEX = /\A[ぁ-んァ-ン一-龥]+\z/.freeze
  KANA_REGEX = /\A[ァ-ン]+\z/.freeze

  with_options format: { with: REALNAME_REGEX, message: 'には全角文字を使用してください' } do
    validates :first_name
    validates :last_name
  end

  with_options format: { with: KANA_REGEX, message: 'には全角カタカナを使用してください' } do
    validates :first_name_kana
    validates :last_name_kana
  end
end