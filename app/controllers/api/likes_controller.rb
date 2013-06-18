class Api::LikesController < ApplicationController
  # GET /likes
  # GET /likes.json
  def index
    @likes = Like.where("user_id = ?",params[:user_id])
    myjoke_ids = []
    @likes.each do |like|
      myjoke_ids << like.myjoke_id
    end
    render json: {:likes => Myjoke.find_all_by_id(myjoke_ids)}
  end

  # GET /likes/1
  # GET /likes/1.json
  def show
    @like = Like.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @like }
    end
  end

  # GET /likes/new
  # GET /likes/new.json
  def new
    @like = Like.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @like }
    end
  end

  # GET /likes/1/edit
  def edit
    @like = Like.find(params[:id])
  end

  # POST /likes
  # POST /likes.json
  def create
    @like = Like.new(params[:like])
    if @like.save
      render json: { like: @like}
    else
      render json: @like.errors, status: :unprocessable_entity
    end
  end

  # PUT /likes/1
  # PUT /likes/1.json
  def update
    @like = Like.find(params[:id])

    respond_to do |format|
      if @like.update_attributes(params[:like])
        format.html { redirect_to @like, notice: 'Like was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @like.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /likes/1
  # DELETE /likes/1.json
  def destroy
    @likes = Like.where("user_id = ?",params[:user_id])
    @likes.each do |like|
      like.destroy
    end
    render :json => {:success => true}
  end
end
