class Cost < ActiveRecord::Base
    validates:item, presence:true
    validates:spendmoney, :presence => true,:numericality => true

end
