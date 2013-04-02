class User::PaymentMethod < ActiveRecord::Base

  belongs_to :account, :class_name => 'User::Account'

  validates_presence_of :type, :payment_gateway, :identifier, :account_id, :info

  PAYMENT_GATEWAY_BRAINTREE = "braintree"

  SUPPORTED_PAYMENT_GATEWAYS = [PAYMENT_GATEWAY_BRAINTREE]

  TYPE_CREDIT_CARD = "credit_card"

  SUPPORTED_TYPES = [TYPE_CREDIT_CARD]

  validates_inclusion_of :type, :in => SUPPORTED_TYPES
  validates_inclusion_of :payment_gateway, :in => SUPPORTED_PAYMENT_GATEWAYS

end
