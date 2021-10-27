class User < ApplicationRecord
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    enum genders: [ "Male", "Female", "N/A" ] 

    validates :name, presence: true,length: {maximum: 50}  #presence: true không được để trống
    validates :email, presence: true,length: {maximum: 255},
        format: { with: VALID_EMAIL_REGEX },
        #uniqueness: {case_sensitive: false} #khong phan biet chu hoa va chu thuong
        uniqueness: true
    
    validates :password, presence: true, length: {minimum: 6}
    validates :age, presence: true
    validate :age_limit

    before_save :downcase_email

    has_secure_password

    private

        def age_limit 
            if self.age
                age = Date.today.year - self.age.year
                if(age>100 || age<18)
                    errors.add :age, "must be between 18 and 100"
                end
            end
        end
end
