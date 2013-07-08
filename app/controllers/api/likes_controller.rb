#encoding: utf-8
class Api::LikesController < ApplicationController
  # GET /likes
  # GET /likes.json
  def index
    @likes = Like.where("uid = ?",params[:uid])
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

  # POST /likes
  # POST /likes.json
  def create
    @like = Like.new(:uid => params[:uid], :myjoke_id => params[:myjoke_id])
    #check to make sure this user hasn't liked it before
    likes = Like.where(:uid => @like.uid, :myjoke_id => @like.myjoke_id)
    if likes.size > 0
      if "0" == params[:isLike]
        likes.destroy_all
        render json: { success: true }
      else
        render json: { success: false, reason: "用户已经喜欢" }
      end
    elsif "0" == params[:isLike]
        render json: { success: false, reason: "笑话没有被用户喜欢过" }
    elsif @like.save
      render json: { success: true, myjoke_id: @like.myjoke_id, num_likes: @like.num_likes}
    else
      render json: @like.errors, status: :unprocessable_entity
    end
  end
end
