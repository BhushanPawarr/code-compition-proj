module TwilioServices
    def send_otp(otp, mobile_number)
      @client = Twilio::REST::Client.new(ENV['ACCOUNT_SID'], ENV['AUTH_TOKEN'])
      message = @client.messages.create(
        body: "your otp password is #{otp}",
        from: ENV['SENDER_NUMBER'],
        to: mobile_number
      )
      render json: { message: "OTP sent to your registered mobile number" }
    end
end