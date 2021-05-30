function ChatWidget(pusher){
    
    var self = this;
    
    this.pusher = pusher;
    
    this.channelName = 'chat';
    
    this.chatContainer = $('.chat-widget');
    
    this.messageContainer = $('.chat-messages');
    
    this.chatName = $('.chat-name');
    
    this.chatIdUser = $('.user-id');
    
    this.chatSala = $('.sala-id');
    
    this.chatEntry = $('.chat-entry');
    
    this.channel = this.pusher.subscribe(this.channelName);
    
    this._latestMessages(); 
    
    this.channel.bind('new-message', function(data){
       self._displayMessage(data);
    });
    
    this.chatEntry.keydown(function(e){//Presiona enter
        if(e.keyCode === 13){
            e.preventDefault();
            
            self._sendMessage({
               name: self.chatName.val(),
               id_user: self.chatIdUser.val(),
               id_sala: self.chatSala.val(),
               message: self.chatEntry.val()
            });
            
            self.chatEntry.val("");
        }
    });
    
    
};

ChatWidget.prototype._latestMessages = function(){
    var self = this;
   
    $.ajax({
        url : 'latest_messages',//latest_messages/addSala/agregarSala
        dataType: 'json',
        type: 'get',
        success : function (data){
            
            $.each(data, function(i, message){
                self._displayMessage(message);
            });
            
        }
    });
};

ChatWidget.prototype._displayMessage = function(message){
    
    var m = '<li class="left clearfix"><span class="chat-img pull-left"><img src="https://th.bing.com/th/id/Rb5191f32201ffaa11c934ef5e8336aa6?rik=8jEQlkM7qd2a8A&pid=ImgRaw" width="30" height="30"/></span><div class="chat-body clear-fix"><div class="header"><strong class="primary-font">'+ message.name +'</strong><small class="pull-right text-muted"><span class="glyphicon glyphicon-time"></span>' + message.created_at + '</small></div><p>'+ message.message +'</p></div></li>';
    this.messageContainer.prepend(m);//append si se visualizan en la parte de abajo
    
};

ChatWidget.prototype._sendMessage = function(message){
    
    $.ajax({
        url: 'create',
        type: 'post',
        data: {
            message: message.message,
            name: message.name,
            id_user: message.id_user,
            sala: message.id_sala
        },
        success: function (data) {
            
        }
    });
    
};

