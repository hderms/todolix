/** @jsx React.DOM */
var ReactCSSTransitionGroup = React.addons.CSSTransitionGroup;
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
        that.channel = {};
        socket.join("todo", "new", {}, function(channel) {
            console.log("connected");
            
            that.channel.create = channel;
            channel.on("new", function(new_message) {
                console.log(new_message);
                var todos = that.state.data;
                var new_list = todos.concat([new_message])
                that.setState({data: new_list})
            });
            
            

        });
        socket.join("todo", "deleted", {}, function(channel) {
            console.log("connected");
            
            that.channel.remove = channel;
            channel.on("deleted", function(new_message) {
                //TODO: Must actually implement delete
                var todos = that.state.data;
                var were_removed = _.remove(todos, function(el) { return el.uuid == new_message.uuid});
                that.setState({data: todos});
            });
            
            

        });

    },
    handleTodoSubmit: function(message) { 
        this.channel.create.send("new", 
            message);

    },
    handleTodoRemoval: function(uuid) {
        this.channel.remove.send("remove", 
        {uuid: uuid});


    },
    
    render: function() {
        return ( 
            <div className="todoBox">
            <TodoForm onTodoSubmit={this.handleTodoSubmit} />
            <br />
            <div className="row-fluid">

            <TodoList data={this.state.data} onTodoRemoval={this.handleTodoRemoval}/> 
            </div>

            </div>
        );
    }
});
var Todo = React.createClass({
    handleRemoval: function(e) {
        console.log("Handle removal");
        e.preventDefault();
        console.log(this.props);
        var uuid = this.props.todo.uuid
        if (!uuid) {
            return;
        }
        this.props.onTodoRemoval(uuid);
        return;
    }
    ,
    render: function() {
        
        return (<div key={this.props.todo.uuid} className="well" > 
                <span>
                {this.props.todo.body} 
                 </span>
                <span className="btn btn-danger btn-sm pull-right" onClick={this.handleRemoval}  data-uuid={this.props.todo.uuid}> x</span>
                
                </div>

        )} 
});
var TodoList = React.createClass({

    
    onTodoRemoval: function(uuid) {
        this.props.onTodoRemoval(uuid);

    },

    render: function() {
        var todoNodes = this.props.data.map(function(todo) {
            return  (<Todo todo={todo} onTodoRemoval={this.onTodoRemoval} />)
        }.bind(this));
        return ( 
            
            <div className="todoList" key="todolist">
            {todoNodes} 

            </div>
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

