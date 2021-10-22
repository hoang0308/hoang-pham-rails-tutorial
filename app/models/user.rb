class User < ApplicationRecord
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
end
