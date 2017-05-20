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
    comment.user_id = "591b9deed283156c49597b6a";
    console.log(comment);
    $.ajax({
      url: this.props.url,
      dataType: 'json',
      type: 'POST',
      data: comment,
      success: function(data) {
        this.setState({data: this.state.data.concat([data])});
        console.log("sss");
      }.bind(this),
      error: function(xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  },
  render: function() {
    return (
      <div className="commentBox">
        <h1>{this.props.current_user.email}</h1>
        <CommentList data={this.state.data} current_user={this.props.current_user}/>
        <CommentForm onCommentSubmit={this.handleCommentSubmit} current_user={this.props.current_user}/>
      </div>
    );
  }
});


var CommentList = React.createClass({
  render: function() {
    var commentNodes = this.props.data.map(function (comment) {
      return (
        <Comment>
          {comment.text}
        </Comment>
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
    var text = this.refs.text.value.trim();
    if (!text) {
      return;
    }
    this.props.onCommentSubmit({user_id: this.refs.from_user.value ,text: text}); // ここでcallback実行する！
    this.refs.text.value = '';
    return;
  },

  render: function() {
    return (
      <form className="commentForm" onSubmit={this.handleSubmit}>
        <input type="text" placeholder="Say something..." ref="text" />
        <input type="hidden" ref="from_user" value={this.props.current_user._id} />
        <input type="submit" value="Post" />
      </form>
    );
  }
});


var Comment = React.createClass({
  render: function() {
    var rawMarkup = marked(this.props.children.toString(), {sanitize: true});
    return (
      <div className="comment">
        <span dangerouslySetInnerHTML={{
          __html: rawMarkup
        }}/>
      </div>
    );
  }
});
