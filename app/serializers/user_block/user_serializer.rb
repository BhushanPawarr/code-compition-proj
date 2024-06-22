class UserBlock::UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :email, :role, :mobile_number
end
