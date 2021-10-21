class User < ApplicationRecord
    # before_save { seft.email = email.downcase }
    before_save {email.downcase!}
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

    validates :name, presence: true,length: {maximum: 50}  #presence: true không được để trống
    validates :email, presence: true,length: {maximum: 255},
        format: { with: VALID_EMAIL_REGEX },
        #uniqueness: {case_sensitive: false} #khong phan biet chu hoa va chu thuong
        uniqueness: true
    validates :gender, presence: true,inclusion: {in: %w(Nam Nu N/A),
        message: "%{value} is not a valid gender"}
    has_secure_password
    validates :password, presence: true, length: {minimum: 6}
  
    validates :age, presence: true, numericality: { only_integer: true , greater_than: 18, less_than: 100}
end