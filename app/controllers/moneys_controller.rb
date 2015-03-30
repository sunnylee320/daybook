class MoneysController < ApplicationController
    def index
       @moneys = Money.all  
    end
    def new
       @money = Money.new 
    end
end
