class StashesController < ApplicationController
  def index
    @stashes = Stash.stashes
  end

  def create_stash
    attributes = {:description => "Manual stash creation", :owner => current_user.email, :timestamp => Time.now.to_i }
    unless params[:date].empty? || params[:time].empty?
      attributes.merge!({:expire_at => Time.parse("#{params[:date]} #{params[:time]}")})
    end
    if params[:description].empty?
      attributes.merge!({:description => "Manual stash creation"})
    else
      attributes.merge!({:description => params[:description]})
    end
    resp = Stash.create_stash(params[:key], attributes)
    respond_to do |format|
      format.json { render :json => resp.to_s }
    end
  end

  def delete_stash
    resp = Stash.delete_stash(params[:key])
    respond_to do |format|
      format.json { render :json => resp.to_s }
    end
  end

  def delete_all_stashes
    resp = Stash.delete_all_stashes
    respond_to do |format|
      format.json { render :json => resp.to_s }
    end
  end
end
