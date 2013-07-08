class MyjokesController < ApplicationController
  # GET /myjokes
  # GET /myjokes.json
  def index
    @myjokes = Myjoke.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @myjokes }
    end
  end

  # GET /myjokes/1
  # GET /myjokes/1.json
  def show
    @myjoke = Myjoke.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @myjoke }
    end
  end

  # GET /myjokes/new
  # GET /myjokes/new.json
  def new
    @myjoke = Myjoke.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @myjoke }
    end
  end

  # GET /myjokes/1/edit
  def edit
    @myjoke = Myjoke.find(params[:id])
  end

  # POST /myjokes
  # POST /myjokes.json
  def create
    @myjoke = Myjoke.new(params[:myjoke])
    respond_to do |format|
      if @myjoke.save
        format.html { redirect_to @myjoke, notice: 'Myjoke was successfully created.' }
        format.json { render json: @myjoke, status: :created, location: @myjoke }
      else
        format.html { render action: "new" }
        format.json { render json: @myjoke.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /myjokes/1
  # PUT /myjokes/1.json
  def update
    @myjoke = Myjoke.find(params[:id])

    respond_to do |format|
      if @myjoke.update_attributes(params[:myjoke])
        format.html { redirect_to @myjoke, notice: 'Myjoke was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @myjoke.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /myjokes/1
  # DELETE /myjokes/1.json
  def destroy
    @myjoke = Myjoke.find(params[:id])
    @myjoke.destroy

    respond_to do |format|
      format.html { redirect_to myjokes_url }
      format.json { head :no_content }
    end
  end
end
