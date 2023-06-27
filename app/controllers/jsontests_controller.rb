class JsontestsController < ApplicationController
  before_action :set_jsontest, only: %i[ show edit update destroy ]

  # GET /jsontests or /jsontests.json
  def index
    @jsontests = Jsontest.all
  end

  # GET /jsontests/1 or /jsontests/1.json
  def show
  end

  # GET /jsontests/new
  def new
    @jsontest = Jsontest.new
  end

  # GET /jsontests/1/edit
  def edit
  end

  # POST /jsontests or /jsontests.json
  def create
    @jsontest = Jsontest.new(jsontest_params)

    respond_to do |format|
      if @jsontest.save
        format.html { redirect_to jsontest_url(@jsontest), notice: "Jsontest was successfully created." }
        format.json { render :show, status: :created, location: @jsontest }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @jsontest.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /jsontests/1 or /jsontests/1.json
  def update
    respond_to do |format|
      if @jsontest.update(jsontest_params)
        format.html { redirect_to jsontest_url(@jsontest), notice: "Jsontest was successfully updated." }
        format.json { render :show, status: :ok, location: @jsontest }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @jsontest.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jsontests/1 or /jsontests/1.json
  def destroy
    @jsontest.destroy

    respond_to do |format|
      format.html { redirect_to jsontests_url, notice: "Jsontest was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_jsontest
      @jsontest = Jsontest.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def jsontest_params
      params.require(:jsontest).permit(:config_json)
    end
end
