#encoding: utf-8
class Api::FeedbacksController < ApplicationController
  # GET /feedbacks
  # GET /feedbacks.json
  def index
    @feedbacks = Feedback.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @feedbacks }
    end
  end

  # GET /feedbacks/1
  # GET /feedbacks/1.json
  def show
    @feedback = Feedback.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @feedback }
    end
  end

  # GET /feedbacks/new
  # GET /feedbacks/new.json
  def new
    redirect_to :root
    return
    @feedback = Feedback.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @feedback }
    end
  end

  # GET /feedbacks/1/edit
  def edit
    redirect_to :root
    return
    @feedback = Feedback.find(params[:id])
  end

  # POST /feedbacks
  # POST /feedbacks.json
  def create
    @feedback = Feedback.new(params[:feedback])
    @feedback.url = File.open(createFeedbackAudio(params[:feedbackFileData], params[:feedback][:uid]))

    if @feedback.save
      render :json => { :success => true, :id => @feedback.id}
    else
      render :json => { :success => false }
    end
  end

  def createFeedbackAudio(file, uid)
    filename = "/feedback/feedback-#{uid}-#{Time.now.to_i}.mp3"
    writeFile(file, filename)
  end

  def writeFile(file, filename)
    filename = "#{Rails.root}/public#{filename}"
    File.open(filename, 'wb') do |f|
      f.write file
    end
    filename
  end

  # PUT /feedbacks/1
  # PUT /feedbacks/1.json
  def update
    redirect_to :root
    return
    @feedback = Feedback.find(params[:id])

    respond_to do |format|
      if @feedback.update_attributes(params[:feedback])
        format.html { redirect_to @feedback, notice: 'Feedback was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @feedback.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /feedbacks/1
  # DELETE /feedbacks/1.json
  def destroy
    redirect_to :root
    return
    @feedback = Feedback.find(params[:id])
    @feedback.destroy

    respond_to do |format|
      format.html { redirect_to feedbacks_url }
      format.json { head :no_content }
    end
  end
end
