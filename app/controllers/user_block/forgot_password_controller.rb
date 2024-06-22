module UserBlock
  class ForgotPasswordController < ApplicationController
    include TwilioServices

    def forgot
      account = UserBlock::User.where("LOWER(email) = ? OR mobile_number = ?", params[:email]&.downcase, params[:mobile_number])&.first
      if account.present?
        otp = generate_otp(account)
        render_response(data: { otp_number: otp, mobile_number: account.mobile_number }, errors: 'nil', message: "Otp sent successfully...", status: :ok)
      else
        render_response(data: nil, errors: 'Invalid email or mobile_number!', message: "Account not found", status:422)
      end
    end

    def verify_otp
      user = UserBlock::User.where("LOWER(email) = ? OR mobile_number = ?", params[:email]&.downcase, params[:mobile_number]).first if params.present?
      return render json: { message: "Invalid mobile_number or email!" } unless user

      otp_record = Otp.find_by(otp_number: params[:otp], user_id: user&.id)
      return render_response(data: nil, errors: 'Invalid otp number!',status:422) unless otp_record

      if otp_record && otp_record.expires_at > Time.now
        UserBlock::User.update(is_verified: true)
        render_response(data: nil, errors: 'nil', message: "Otp verified successfully...", status: :ok)
      else
        return render_response(data: nil, errors: 'Your otp has expired!', status:422)
      end
    end

    def update_password
      user = UserBlock::User.where("LOWER(email) = ? OR mobile_number = ?", params[:email]&.downcase, params[:mobile_number]).first
      return render json: { message: 'Invalid email or mobile_number' }, status: 422 unless user
      return render json: { message: "Your otp is not verified" } if user.is_verified == false

      if user.update(password: params[:password])
        render json: { message: 'Your password updated successfully...' }, status: 200
      else
        render json: { errors: user.errors.full_messages, message: 'Your password update failed' }, status: 422
      end
    end

    private

    def generate_otp(user)
      otp = rand(1000..9999).to_s
      expires_at = Time.now + 5.minutes
      otp_record = Otp.find_by(user_id: user.id)
      UserBlock::User.update(is_verified: false)

      if otp_record
        otp_record.update(otp_number: otp, expires_at: expires_at)
      else
        Otp.create(otp_number: otp, user_id: user.id, expires_at: expires_at)
      end
      otp
      # send_otp(otp, user.mobile_number)
    end
  end
end
