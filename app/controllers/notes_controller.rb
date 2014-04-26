class NotesController < ApplicationController

  def new
    @note = Note.new
    render :text => 'New note'
  end
  
  def index
    # @tag = Tag.find_by_id(params[:tag_id] || 1)
    @notes = Note.all # @tag.notes
  end
  
  def create
    @note = Note.new(note_params)
    @tag = Tag.find(params[:tag_id])
    @note.tags << @tag
    respond_to do |format|
      if @note.save
        format.html { redirect_to notes_tag_path(@tag), notice: 'Nice job on the note!' }
        format.json { render action: 'show', status: :created, location: @note }
      else
        format.html { render action: notes_tag_path(@tag) }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # PATCH/PUT /notes/1
  # PATCH/PUT /notes/1.json
  def update
    @note = Note.find(params[:id])
    respond_to do |format|
      if @note.update(note_params)
        format.html { redirect_to @note, notice: 'note was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  def archive
    @note = Note.find(params[:id])
    @tag = Tag.find(params[:tag_id])
    respond_to do |format|
      if @note.update_attribute(:archived_at, Time.now)
        format.html { redirect_to notes_tag_path(@tag), notice: 'note was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end        

  def tag
    @tag = Tag.find(params[:tag_id])
    @note = Note.find(params[:id])
    if @note.tags.include?(@tag)
      @note.tags.delete(@tag)
    else
      @note.tags << @tag
    end
    respond_to do |format|
      format.json {render json: @note.tags.map(&:name)}
    end
  end
    
  private
  def note_params
    params.require(:note).permit(:content)
  end
end
