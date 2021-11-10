class User < ApplicationRecord
    attr_accessor :remember_token, :activation_token
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    enum genders: [ "Male", "Female", "N/A" ]
    enum status: [:deactive, :active ]
    enum user_type: [:user, :admin]

    validates :name, presence: true,length: {maximum: Settings.name_maximum}  #presence: true không được để trống
    validates :age, presence: true
    validate :age_limit
    validates :email, presence: true,length: {maximum: Settings.email_maximum},
        format: { with: VALID_EMAIL_REGEX },
        #uniqueness: {case_sensitive: false} #khong phan biet chu hoa va chu thuong
        uniqueness: true
    validates :password, length: {minimum: Settings.password_minimum}, allow_nil: true
    has_secure_password
    
    before_save :downcase_email
    before_create :create_activation_digest

    class << self
        def digest(string)
            cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                        BCrypt::Engine.cost
            BCrypt::Password.create(string, cost: cost)
        end

        def new_token
            SecureRandom.urlsafe_base64
        end
    end

    #return random token
   

    def remember
        self.remember_token = User.new_token
        update remember_digest: User.digest(remember_token)
    end

    def authenticated?(attribute, token)
        digest = send("#{attribute}_digest")
        return false if digest.nil? 
        BCrypt::Password.new(digest).is_password?(token)
    end

    def forget
        update remember_digest: nil
    end

    def update_status
        self.active!
        update activated_at: Time.zone.now
    end

    def send_activation_email
        UserMailer.account_activation(self).deliver_now
    end

    def current_user?(current_user) 
        self && self == current_user
    end

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

        def create_activation_digest
            self.activation_token = User.new_token
            self.activation_digest = User.digest(activation_token)
        end

end
