class CommentsController < ApplicationController
  before_action :set_article_for_comment, only: %i[ create ]

  # POST /articles/<:article_id>/comments
  def create
    @comment = @article.comments.create(comment_params)
    redirect_to article_path(@article)
  end

  private
  def set_article_for_comment
    @article = Article.find(params[:article_id])
  end

  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end

end
