#encoding: utf-8
class Api::MyjokesController < ApplicationController
  PER_PAGE = 10

  # GET /myjokes
  # GET /myjokes.json
  def index
   #page = params[:page]
   #offset  = 0
   #if page.nil?
   #  offset = 0
   #elsif page.to_i > 1
   #  offset = (page.to_i - 1) * PER_PAGE
   #end
   #uid = params[:uid]
   #if params[:date] 
   #  date_limit = DateTime.parse(params[:date])
   #  @myjokes = Myjoke.where("created_at > '#{date_limit.yesterday}' AND created_at < '#{date_limit.tomorrow}'")
   #    .limit(PER_PAGE).offset(offset)
   #else
   #  @myjokes = Myjoke.order("created_at DESC").limit(PER_PAGE).offset(offset)
   #end
    render json: { :myjokes => Myjoke.getJokes(params[:uid], params[:page], params[:date], params[:dir]) }
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
    uid = params[:myjoke][:uid]
    params[:myjoke][:approved] = 0
    
    @myjoke = Myjoke.new(params[:myjoke])
    if params[:imageFileData]
      #@file.original_filename = 'photo.jpg'
      @myjoke.picture_url = File.open(createPhoto(params[:imageFileData], uid))
    end
    @myjoke.audio_url = File.open(createAudioFile(params[:audioFileData], uid))

    if @myjoke.save
      render :json => { :success => true, :id => @myjoke.id}
     @myjoke.set_full_url
     @myjoke.set_file_size
     @myjoke.set_audio_length
     @myjoke.save!
    else
      render :json => { :success => false }
    end
  end

  # POST /myjokes/play.json
  def play
    if params[:uid].nil?
      render :json => { :success => false }
      return
    end
    @myjoke = Myjoke.find(params[:id])
    @myjoke.update_attribute(:num_plays, (@myjoke.num_plays + 1))
    if @myjoke.save
      render :json => { :success => true, :id => @myjoke.id, :num_plays => @myjoke.num_plays}
    else 
      render :json => { :success => false, :errors => @myjoke.errors }
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

  # GET /myjokes/checkVersion
  def checkVersion
    version = "1.0"
    name = "YitingDaodi.apk"
    render :json => { :current_version => version, :url => "/versions/#{name}" }
  end

  def createPhoto(file, uid)
    filename = "/pictures/image-#{uid}-#{Time.now.to_i}.jpg"
    writeFile(file, filename)
    #filename
    #URI.join(root_url, filename).to_s
  end

  def createAudioFile(file, uid)
    filename = "/audios/audio-#{uid}-#{Time.now.to_i}.mp3"
    writeFile(file, filename)
    #filename
    #URI.join(root_url, filename).to_s
  end

  def writeFile(file, filename)
    filename = "#{Rails.root}/public#{filename}"
    File.open(filename, 'wb') do |f|
      f.write file
    end
    filename
    #logger.debug filename
  end


end
