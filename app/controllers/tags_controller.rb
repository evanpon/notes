class TagsController < ApplicationController

  def index
    tag = Tag.first
    if tag.nil?
      tag = Tag.create(name: 'Important')
    end
    redirect_to(notes_tag_path(tag))
  end
    
  def notes
    # url = 'https://www.googleapis.com/identitytoolkit/v1/relyingparty/createAuthUrl'
    # params = {identifier: 'evanpon@gmail.com', continueUrl: 'http://localhost:3000/continue'}
    # response = RestClient.post(url)#, params
    # puts response
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

  def destroy
    @tag = Tag.find(params[:id])
    respond_to do |format|
      if @tag.destroy
        # Return a status 303 so it won't redirect with a DELETE verb
        format.html { redirect_to '/', status: 303 }
        format.json { head :no_content }
      else
        format.html { redirect_to @tag }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end        

  private
  def tag_params
    params.require(:tag).permit(:name)
  end
end
