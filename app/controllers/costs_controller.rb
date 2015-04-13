class CostsController < ApplicationController
  before_action :set_cost, only: [:show, :edit, :update, :destroy]

  # GET /costs
  # GET /costs.json
  def index
    @costs = Cost.all
    @grouped_months = @costs.group_by { |r| r.buyday.beginning_of_month}
    @grouped_totals = @costs.sum(:spendmoney)
   
    @march_costs = Cost.where(['buyday between ? and ?','2015-03-01','2015-03-31' ]).order('buyday desc')
    @march_total = Cost.where(["date_part('month',buyday) = ?" ,3]).sum(:spendmoney)
    @month_num = ['1','2','3','4','5','6','7','8','9','10','11','12']
    @month_details = []
    @month_costs = []
     (0..11).each do |i|
       @month_details[i] = Cost.where(["date_part('month',buyday) = ? and date_part('year',buyday) = ?" , @month_num[i],2015]).order('buyday desc')
       @month_costs[i] = Cost.where(["date_part('month',buyday) = ? and date_part('year',buyday) = ?" , @month_num[i],2015]).sum(:spendmoney)
     end
  end

  # GET /costs/1
  # GET /costs/1.json
  def show
  end

  # GET /costs/new
  def new
    @cost = Cost.new
  end

  # GET /costs/1/edit
  def edit
  end

  # POST /costs
  # POST /costs.json
  def create
    @cost = Cost.new(cost_params)

    respond_to do |format|
      if @cost.save
        #@new_num = params[:cost.buyday]
        format.html { redirect_to costs_path, notice: 'Cost was successfully created.' }
        #format.html { redirect_to costs_path, }
        # render :text => params[:cost.buyday]
        #format.json { render :show, status: :created, location: @cost }
      else
        format.html { render :new }
        format.json { render json: @cost.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /costs/1
  # PATCH/PUT /costs/1.json
  def update
    respond_to do |format|
      if @cost.update(cost_params)
        format.html { redirect_to @cost, notice: 'Cost was successfully updated.' }
        format.json { render :show, status: :ok, location: @cost }
      else
        format.html { render :edit }
        format.json { render json: @cost.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /costs/1
  # DELETE /costs/1.json
  def destroy
    @cost.destroy
    respond_to do |format|
      format.html { redirect_to costs_url, notice: 'Cost was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cost
      @cost = Cost.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cost_params
      params.require(:cost).permit(:buyday, :item, :spendmoney)
    end
end
