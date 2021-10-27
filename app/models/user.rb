class User < ApplicationRecord
    attr_accessor :remember_token
    # before_save { seft.email = email.downcase }
    before_save {email.downcase!}
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    # enum genders: { Male: "Male", Female: "Female", NA: "N/A"} 
    enum genders: [ "Male", "Female", "N/A" ] 

    validates :name, presence: true,length: {maximum: 50}  #presence: true không được để trống
    validates :email, presence: true,length: {maximum: 255},
        format: { with: VALID_EMAIL_REGEX },
        #uniqueness: {case_sensitive: false} #khong phan biet chu hoa va chu thuong
        uniqueness: true
    # validates :gender, presence: true,inclusion: {in: genders.keys}
    has_secure_password
    validates :password, presence: true, length: {minimum: 6}
  
    # validates :age, presence: true, numericality: { only_integer: true , greater_than: 18, less_than: 100}
    # validates :age, presence: true
   
    validate :age_limit

    def age_limit 
        if self.age.to_s. != ""
            age = Date.today.year - Date.parse(self.age.to_s).year
            if(age>100 or age<18)
                errors.add :age, "must be between 18 and 100"
            end
        else
            errors.add :age,"can't be blank"
        end
    end

    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
        end
        
    #return random token
    def User.new_token
        SecureRandom.urlsafe_base64
    end

    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end

    def authenticated?(remember_token)
        return false if remember_digest.nil?
        BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end
    def forget
        update_attribute(:remember_digest, nil)
    end
end
