class MessagesController < ApplicationController
before_action :set_message, only: [:show, :edit, :update, :destroy]
  #before_actionは実行前に前もて動くメソッドを指定できる
  #only: [実行するアクションを宣言する]
  
  def index
    @messages = Message.all
  end

  def show
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
  end

  def update
    if @message.update(message_params)
      flash[:success] = 'Message は正常に更新されました'
      redirect_to @message
    else
      flash.now[:danger] = 'Message は更新されませんでした'
      render :edit
    end
  end

  def destroy
    @message.destroy

    flash[:success] = 'Message は正常に削除されました'
    redirect_to messages_url
    #リダイレクトのときだけ _url を使用
  end

private

   def set_message #以下のコード部分set_messagesに置き換えてまとめられる 
    @message = Message.find(params[:id])
   end
  
   # Strong Parameter セキュリティー上の推奨
  def message_params  #私用メソッド
    params.require(:message).permit(:content)
  end
  #:messageモデルフォームのデータに関するものと明治
  #.permit(:content)必要な絡むだけを選択している

end
