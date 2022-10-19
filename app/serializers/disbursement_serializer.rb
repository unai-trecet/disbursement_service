class DisbursementSerializer <  ActiveModel::Serializer
  attributes :id, :merchant, :order, :amount
end