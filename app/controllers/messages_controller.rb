class MessagesController < ApplicationController
  def index
    @messages = Message.all
  end

  def show
    @message = Message.find(params[:id])
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params) #←　Strong Parameterの担保 
    if @message.save
      flash[:success] = 'Message が正常に投稿されました'
      redirect_to @message 
      #リンク先を指定してshowへ強制的に飛ばすメソッド
    else
      flash.now[:danger] = 'Message が投稿されませんでした'
      render :new
      #messages/new.html.erb を表示する
    end
  end

  def edit
    @message = Message.find(params[:id])
    #@messageにはあらかじめconntentが入っている
  end

  def update
    @message = Message.find(params[:id])

    if @message.update(message_params)
      flash[:success] = 'Message は正常に更新されました'
      redirect_to @message
    else
      flash.now[:danger] = 'Message は更新されませんでした'
      render :edit
    end
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy

    flash[:success] = 'Message は正常に削除されました'
    redirect_to messages_url
    #リダイレクトのときだけ _url を使用
  end

private

   # Strong Parameter セキュリティー上の推奨
  def message_params  #私用メソッド
    params.require(:message).permit(:content)
  end
  #:messageモデルフォームのデータに関するものと明治
  #.permit(:content)必要な絡むだけを選択している

end
