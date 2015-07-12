class CommentsController < ApplicationController
  def create

    @blog = Blog.find(params[:blog_id])
    @comment = Comment.new(comment_params)
    @comments = @blog.comments.all

    #if verify_recaptcha
      if @comment.save
        @blog.comments.push(@comment)
        flash[:notice] = "Comment added!"

        respond_to do |format|
          #format.html { redirect_to :back }
          format.js { render "blogs/create" }
        end
      else
        render "blogs/show"
      end
    # else
    #   render "blogs/show"
    # end
  end

  def destroy
    @blog    = Blog.find(params[:blog_id])
    @comment = @blog.comments.find(params[:id])
    @comment.destroy
    redirect_to :back
  end

  private

  def comment_params
    params.require(:comment).permit(:text, :author)
  end
end
