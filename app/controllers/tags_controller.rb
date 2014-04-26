class TagsController < ApplicationController

  def new
    @tag = tag.new
  end
  
  def notes
    @tag = Tag.find(params[:id])
    @notes = @tag.notes
  end
  
  def create
    @tag = Tag.new(tag_params)
    respond_to do |format|
      if @tag.save
        
        format.html { redirect_to notes_tag_path(@tag), notice: 'Nice job on the tag!' }
        format.json { render action: 'show', status: :created, location: @tag }
      else
        format.html { render action: '/' }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # PATCH/PUT /tags/1
  # PATCH/PUT /tags/1.json
  def update
    @tag = tag.find(params[:id])
    respond_to do |format|
      if @tag.update(tag_params)
        format.html { redirect_to @tag, notice: 'tag was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  def archive
    @tag = tag.find(params[:id])
    respond_to do |format|
      if @tag.update_attribute(:archived_at, Time.now)
        format.html { redirect_to @tag, notice: 'tag was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end        

  def tag
    @tag = tag.find(params[:id])
  end

  private
  def tag_params
    params.require(:tag).permit(:name)
  end
end
