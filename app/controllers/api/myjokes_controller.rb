#encoding: utf-8
class Api::MyjokesController < ApplicationController
  PER_PAGE = 10

  # GET /myjokes
  # GET /myjokes.json
  def index
    page = params[:page]
    offset = 0
    if not page.nil? or page > 1
      offset = page.to_i * PER_PAGE
    end
    uid = params[:uid]
    @myjokes = Myjoke.order("created_at DESC").limit(PER_PAGE).offset(offset)
    #TODO add islike
    render json: { :myjokes => @myjokes }
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
    #@myjoke = Myjoke.find(params[:id])
  end

  # POST /myjokes
  # POST /myjokes.json
  def create
    if params[:myjoke]
      params[:myjoke][:approved] = 1
    end
    @myjoke = Myjoke.new(params[:myjoke])
    if @myjoke.save
      render :json => { :success => true, :id => @myjoke.id}
    else
      render :json => { :success => false }
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

  # POST /myjokes/audio
  def audio
    #@user = User.where #TODO authentication
    uid = params[:uid]
    filedata = params[:Filedata]
    tmp_file = "#{Rails.root}/tmp/uploaded-#{uid}-#{Time.now.to_i}.jpg"
    File.open(tmp_file, 'wb') do |f|
      f.write filedata.read
    end
    render :json => { :success => true, :url => "http://www.magnac.com/sounds/edensmall.mp3"}
  end

  # POST /myjokes/photo
  def photo
    uid = params[:uid]
    filedata = params.first.first #params[:Filedata]
    tmp_file = "#{Rails.root}/tmp/uploaded-#{uid}-#{Time.now.to_i}.jpg"
    File.open(tmp_file, 'wb') do |f|
      filedata.bytes.each do |b|
        f.write b
      end
    end
    logger.debug tmp_file
    render :json => { :success => true, :url => "http://railscasts.com/static/episodes/stills/134-paperclip.png"}
  end

end
