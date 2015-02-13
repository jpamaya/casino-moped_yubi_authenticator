require 'casino/moped_authenticator'

class CASino::MopedYubiAuthenticator < CASino::MopedAuthenticator
  def validate(username, password, yubi_key)
    return false unless user = collection.find(@options[:username_column] => username).first
    password_from_database = user[@options[:password_column]]
    registered_yubi_key_from_database = user[@options[:yubi_key_column]]

    # Validate password from database
    if valid_password?(password, password_from_database)
      # Validate yubi key
      if valid_yubi_key?(yubi_key, registered_yubi_key_from_database)
        return { username: user[@options[:username_column]], extra_attributes: extra_attributes(user) }
      else
        return false
      end
    else
      return false
    end
  end

  def valid_yubi_key?(yubi_key, registered_yubi_key)
    registered_yubi_key == yubi_key[0..11] && valid_yubi_api_key?(yubi_key)
  end

  def valid_yubi_api_key?(yubi_key)
    return true if Rails.env.development?
    begin
      otp = Yubikey::OTP::Verify.new( :api_id => APP_CONFIG['yubi_api_id'],
                                      :api_key => APP_CONFIG['yubi_api_key'],
                                      :otp => yubi_key )

      if otp.valid?
        return true
      else
        return false
      end
    rescue Yubikey::OTP::InvalidOTPError
      return false
    end
  end

end
