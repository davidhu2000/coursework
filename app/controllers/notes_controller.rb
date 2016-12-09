class NotesController < ApplicationController
  def create
    @note = Note.new(note_params)
    if @note.save
      flash[:success] = ['Note created']
    else
      flash.now[:danger] = @note.errors.full_messages
    end
    redirect_to track_url(@note.track)
  end

  private

  def note_params
    params.require(:note).permit(:user_id, :track_id, :body)
  end
end
