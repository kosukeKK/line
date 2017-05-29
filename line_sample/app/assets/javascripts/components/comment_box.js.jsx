var CommentBox = React.createClass({
  loadCommentsFromServer: function() {
    $.ajax({
      url: this.props.url,
      dataType: 'json',
      success: function(result) {
        this.setState({data: result.data});
        this.setState({current_user: this.props.current_user})
      }.bind(this),
      error: function(xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  },
  getInitialState: function() {
    return {
      data: [],
      current_user: ""
    };
  },
  componentDidMount: function() {
    this.loadCommentsFromServer();
    setInterval(this.loadCommentsFromServer, this.props.pollInterval);
  },
  handleCommentSubmit: function(comment) {
    $.ajax({
      url: this.props.url,
      dataType: 'json',
      type: 'POST',
      data: comment,
      success: function(data) {
        this.setState({data: this.state.data.concat([data])});
        {
          //スクロールするだけ
          $('html, body').animate({
            scrollTop: $(document).height()
          },1500);
          return false;
        }
      }.bind(this),
      error: function(xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  },
  render: function() {
    return (
      <div className="commentBox">
        <CommentList data={this.state.data} current_user={this.props.current_user} />
        <CommentForm onCommentSubmit={this.handleCommentSubmit} current_user={this.props.current_user}/>
      </div>
    );
  }
});


var CommentList = React.createClass({
  render: function() {
    var current_user_id = this.props.current_user._id.$oid;
    var commentNodes = this.props.data.map(function (comment, index, arr) {
      var comment_owner_is_current_user = current_user_id == comment.user_id.$oid ? true : false;
      var user = comment_owner_is_current_user ? "あなた" : "あいて";
      var color_owner = comment_owner_is_current_user ? "my_comment" : "partner_comment";
      return (
        <div className={color_owner}>
          <div className={index == arr.length - 1 ? "enf_of_list" : ""}>
            <span>{user}</span>:<div className="comment">{comment.text}</div>
          </div>
        </div>
      );
    });
    return (
      <div className="commentList">
        {commentNodes}
      </div>
    );
  }
});

var CommentForm = React.createClass({

  handleSubmit: function(e) {
    e.preventDefault();
    var user_id = this.refs.user_id.value;
    var text = this.refs.text.value.trim();
    if (!text || !user_id) {
      return;
    }
    this.props.onCommentSubmit({user_id: user_id, text: text});
    this.refs.user_id.value = '';
    this.refs.text.value = '';
    return;
  },

  render: function() {
    return (
      <form className="commentForm" onSubmit={this.handleSubmit}>
        <input type="hidden" ref="user_id" value={this.props.current_user._id.$oid}/>
        <input type="text" placeholder="メッセージを入力" ref="text" className="navbar-fixed-bottom" />
      </form>
    );
  }
});
