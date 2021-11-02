class User < ApplicationRecord
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    enum genders: [ "Male", "Female", "N/A" ]

    validates :name, presence: true,length: {maximum: Settings.name_maximum}  #presence: true không được để trống
    validates :age, presence: true
    validate :age_limit
    validates :email, presence: true,length: {maximum: Settings.email_maximum},
        format: { with: VALID_EMAIL_REGEX },
        #uniqueness: {case_sensitive: false} #khong phan biet chu hoa va chu thuong
        uniqueness: true
    validates :password, length: {minimum: Settings.password_minimum}
    has_secure_password
    
    before_save :downcase_email

    private

        def age_limit
            if self.age
                age = Date.today.year - self.age.year
                if(age>100 || age<18)
                    errors.add :age, "must be between 18 and 100"
                end
            end
        end

        def downcase_email
            self.email.downcase
        end

end
