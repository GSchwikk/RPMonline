class PacksController < ApplicationController
  
  before_action :set_meeting 
  before_action :set_pack, only: [:show, :edit, :update, :destroy]


  # GET /packs
  # GET /packs.json
  def index
    @packs = Pack.all
  end

  # GET /packs/1
  # GET /packs/1.json
  def show
  end

  # GET /packs/new
  def new
    @pack = Pack.new
  end

  # GET /packs/1/edit
  def edit
  end

  # POST /packs
  # POST /packs.json
  def create
    @pack = Pack.new(pack_params)
    @pack.meeting_id = @meeting.id

    respond_to do |format|
      if @pack.save
        format.html { redirect_to @meeting, notice: 'Pack was successfully created.' }
        format.json { render :show, status: :created, location: @pack }
      else
        format.html { render :new }
        format.json { render json: @pack.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /packs/1
  # PATCH/PUT /packs/1.json
  def update
    respond_to do |format|
      if @pack.update(pack_params)
        format.html { redirect_to @pack, notice: 'Pack was successfully updated.' }
        format.json { render :show, status: :ok, location: @pack }
      else
        format.html { render :edit }
        format.json { render json: @pack.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /packs/1
  # DELETE /packs/1.json
  def destroy
    @pack.destroy
    respond_to do |format|
      format.html { redirect_to meetings_path(@meeting), notice: 'Pack was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pack
      @pack = Pack.find(params[:id])
    end

    def set_meeting
       @meeting = Meeting.find(params[:meeting_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pack_params
      params.require(:pack).permit(:title, :status)
    end
end
