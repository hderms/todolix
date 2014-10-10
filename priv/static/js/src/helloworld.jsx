/** @jsx React.DOM */
var data =[];
var TodoBox = React.createClass({
    getInitialState: function() {
        return {data: []}
    },
    
    componentDidMount: function() {

        $.ajax({
            url: this.props.url,
            dataType: 'json',
            success: function(data) {
                this.setState({data: data});
            }.bind(this),
            error: function(xhr, status, err) {
                console.error(this.props.url, status, err.toString());
            }.bind(this)
        });
        var socket = new Phoenix.Socket("/realtime")
        this.socket = socket;
        var that = this;
        socket.join("todo", "new", {}, function(channel) {
            console.log("connected");
            
            that.channel = channel;
            channel.on("new", function(new_message) {
                console.log(new_message);
                var todos = that.state.data;
                var new_list = todos.concat([new_message])
                that.setState({data: new_list})
            });
            
            

        });
        socket.join("todo", "deleted", {}, function(channel) {
            console.log("connected");
            
            that.channel = channel;
            channel.on("deleted", function(new_message) {
                //TODO: Must actually implement delete
            });
            
            

        });

    },
    handleTodoSubmit: function(message) { 
        this.channel.send("new", 
            message);

    }
    ,
    render: function() {
        return ( 
            <div className="todoBox">
            <TodoForm onTodoSubmit={this.handleTodoSubmit} />
            <TodoList data={this.state.data}/> 

            </div>
        );
    }
});
var TodoList = React.createClass({

    render: function() {
        var todoNodes = this.props.data.map(function(todo) {
            return ( 
                <li> 
                {todo.body} 
                </li>
            )
        });
        return ( 
            
            <ul className="todoList">
            {todoNodes} 
            </ul>
        )
    }
});
var TodoForm = React.createClass({
    handleSubmit: function(e) {
        e.preventDefault();
        var text = this.refs.text.getDOMNode().value.trim();
        if (!text) {
            return;
        }
        this.props.onTodoSubmit({ body: text});
        this.refs.text.getDOMNode().value = '';
        return;
    },
    render: function() {
        return (
            <form className="todoForm" onSubmit={this.handleSubmit}>
            <div className="input-group">
            <input type="text" className="form-control" placeholder="Todo..." ref="text" />
            <span className="input-group-btn">
            <input type="submit" className="btn btn-primary" value="Add Todo" />
            </span>
            </div>
            </form>
        );
    }
});
React.renderComponent(
    <TodoBox data={data} url="todos" /> 
    ,
    document.getElementById('content')
);

