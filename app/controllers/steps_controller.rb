class StepsController < ApplicationController
  before_action :set_pack
  before_action :set_step, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :check_user, only: [:edit, :update, :destroy]

  def check_user
    unless @step.user == current_user || (current_user.admin?)
      redirect_to root_url, alert: "Sorry, this pack belongs to someone else"
    end
  end
 
  def index
    @steps = Step.all
  end


  def show
  end

  def new
    @step = Step.new
  end


  def edit
  end


  def create
    @step = Step.new(step_params)
    @step.user_id = current_user.id
    @step.pack_id = @pack.id    
    respond_to do |format|
      if @step.save
        format.html { redirect_to pack_path(@pack), notice: 'Action was successfully created.' }
        format.json { render :show, status: :created, location: @setp }
      else
        format.html { render :new }
        format.json { render json: @step.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @step.update(params[:step].permit(:description,:status,:due_date))
        format.html { redirect_to pack_path(@pack), notice: 'Pack was successfully updated.' }
        format.json { respond_with_bip(@step)}
      else
        format.html { render :edit }
        format.json { respond_with_bip(@step) }
      end
    end
  end


  def destroy
    @step.destroy
    respond_to do |format|
      format.html { redirect_to pack_path(@pack), notice: 'Action was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_step
      @step = Step.find(params[:id])
    end

    def set_pack
      @pack = Pack.find(params[:pack_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def step_params
      #params.permit(:text, :action_type, :date)
      params.require(:step).permit(:description, :status, :due_date,)
    end

end